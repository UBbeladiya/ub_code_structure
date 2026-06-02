import 'dart:developer';



import 'package:dio/dio.dart';
import 'package:ub_code_structure/app/utils/utils.dart';

import '../utils/logger.dart';
import 'curl_logger_interceptor.dart';

import 'end_point.dart';
import 'endpoint_http_type.dart';
import 'network_response_object.dart';

class WebserviceHelper<T> {
  Dio _dio = Dio();
  final EndpointType endPointType;
  final Map<String, dynamic>? params;
  final Map<String, dynamic>? queryParameters;
  final FormData? formData;
  List<String>? path;
  final T? Function(Map<String, dynamic>)? itemFromJson;
  final ProgressCallback? onSendProgress;
  final ProgressCallback? onReceiveProgress;
  final CancelToken? cancelToken;

  WebserviceHelper({
    required this.endPointType,
    this.itemFromJson,
    this.params,
    this.queryParameters,
    this.formData,
    this.path,
    this.onSendProgress,
    this.onReceiveProgress,
    this.cancelToken,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: endPointType.url,
        receiveDataWhenStatusError: true,
        headers: endPointType.headers,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        validateStatus: (statusCode) {
          log('statusCode: $statusCode');
          if (statusCode == null) {
            return false;
          }
          return true;
        },
      ),
    );
  }

  Future<Map<String, dynamic>> postNormal() async {
    if (endPointType.contentType != 'multipart/form-data') {
      _dio.interceptors.add(CurlLoggerInterceptor());
    }

    var url = endPointType.url;

    if (path != null) {
      for (var i = 0; i < path!.length; i++) {
        final key = ':i${i == 0 ? '' : i}d';
        url = url.replaceAll(key, path![i]);
      }
    }

    try {
      late Response response;
      switch (endPointType.httpMethod) {
        case EndpointHTTPType.get:
          response = await _dio.get(url, queryParameters: queryParameters);
          break;
        case EndpointHTTPType.post:
          response = await _dio.post(url, queryParameters: queryParameters, data: params);
          break;
        case EndpointHTTPType.put:
          response = await _dio.put(url, queryParameters: queryParameters, data: params);
          break;
        case EndpointHTTPType.delete:
          response = await _dio.delete(url, queryParameters: queryParameters, data: params);
          break;
        case EndpointHTTPType.patch:
          response = await _dio.patch(url, queryParameters: queryParameters, data: params);
          break;
        case EndpointHTTPType.postMultipart:

          response = await _dio.post(
            url,
            queryParameters: queryParameters,
            data: formData,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
            cancelToken: cancelToken,
          );

          break;
      }
      final data = response.data;
      if (data is Map<String, dynamic> || data is List) {

        Utils.debugLog(title: "data => ${endPointType.httpMethod}", object: data);


        Map<String, dynamic>  mapData ;
        if (data is Map<String, dynamic>) {
          mapData = data;
        }else{
          mapData = {'data': data};
        }
        return {'statusCode': response.statusCode, 'success': true, ...mapData};
      } else {
        return {'success': false, 'message': 'data is not a Map<String, dynamic>'};
      }
    } on DioException catch (error, stacktrace) {

      var errorMessage = 'Something Went Wrong';
      if (CancelToken.isCancel(error)) {
        errorMessage = error.message ?? errorMessage;
      }

      return {'success': false, 'message': errorMessage};
    } catch (error, stacktrace) {

      return {'success': false, 'message': 'Something Went Wrong'};
    }
  }

  Future<NetworkResponseObject<T>> post() async {
    if (endPointType.contentType != 'multipart/form-data') {
      _dio.interceptors.add(CurlLoggerInterceptor());
    }

    var url = endPointType.url;

    if (path != null) {
      for (var i = 0; i < path!.length; i++) {
        final key = ':i${i == 0 ? '' : i}d';
        url = url.replaceAll(key, path![i]);
      }
    }

    try {
      late Response response;
      switch (endPointType.httpMethod) {
        case EndpointHTTPType.get:
          response = await _dio.get(url, queryParameters: params);
          break;
        case EndpointHTTPType.post:
          response = await _dio.post(url, data: params);
          break;
        case EndpointHTTPType.put:
          response = await _dio.put(url, data: params);
          break;
        case EndpointHTTPType.delete:
          response = await _dio.delete(url, data: params);
          break;
        case EndpointHTTPType.patch:
          response = await _dio.patch(url, data: params);
          break;
        case EndpointHTTPType.postMultipart:
          response = await _dio.post(
            url,
            data: formData,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
            cancelToken: cancelToken,
          );

          break;
      }

      Logger.logMessage(title: 'API SUCCESS - $url \n\n', message: 'data: ${response.data}');

      return NetworkResponseObject(itemFromJson: itemFromJson).fromJson(response.data!);
    } on DioException catch (error, stacktrace) {
      Logger.logMessage(title: 'API FAILURE - $url \n\n', message: 'error: $error, \nstacktrace: $stacktrace \n\n');
      var errorMessage = 'Something Went Wrong';
      if (CancelToken.isCancel(error)) {
        errorMessage = error.message ?? errorMessage;
      }

      return NetworkResponseObject.fromDetail(false, errorMessage);
    } catch (error, stacktrace) {
      Logger.logMessage(title: 'API FAILURE - $url \n\n', message: 'error: $error, \nstacktrace: $stacktrace \n\n');

      return NetworkResponseObject.fromDetail(false, 'Something Went Wrong');
    }
  }
}

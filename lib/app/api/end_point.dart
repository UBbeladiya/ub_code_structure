

import 'package:ub_code_structure/app/utils/utils.dart';

import '../services/storage_service.dart';
import 'endpoint_http_type.dart';

abstract class EndpointType {
  String get baseURL;

  String get path;

  String get url;

  EndpointHTTPType get httpMethod;

  String get contentType;

  Map<String, dynamic> get headers;
}

const appBaseURL = 'https://jsonplaceholder.typicode.com';

enum Endpoint implements EndpointType {
  posts,
  addPost,
  postsId,
  deletePostId,
  ;

  @override
  String get baseURL => appBaseURL;

  @override
  String get contentType => 'application/json';

  @override
  Map<String, dynamic> get headers {
    Map<String, dynamic> header = {
      'Content-Type': contentType,
      'Accept': 'application/json',
    };

    String token =  AppPreference.getString(PrefKey.token);
    Utils.debugLog(title: "token", object: "=> $token");
    AppPreference.setString(PrefKey.token , "hello Ub");
   if (token.isNotEmpty) {
      header['Authorization'] = 'Bearer $token';
    }

    return header;
  }

  @override
  EndpointHTTPType get httpMethod {
    switch (this) {
      case Endpoint.posts:
        return EndpointHTTPType.get;
      case Endpoint.addPost:
        return EndpointHTTPType.post;
      case Endpoint.postsId:
        return EndpointHTTPType.put;
      case Endpoint.deletePostId:
        return EndpointHTTPType.delete;
    }
  }

  @override
  String get path {
    switch (this) {
      case Endpoint.posts:
        return '/posts';
      case Endpoint.addPost:
        return '/posts';
      case Endpoint.postsId:
        return '/posts/:id';
      case Endpoint.deletePostId:
        return '/posts/:id';


    }
  }

  @override
  String get url => baseURL + path;
}

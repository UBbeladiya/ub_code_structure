



import 'map_string_dynamic_extension.dart';

class NetworkResponseObject<T> {
  T? result;
  List<T> list = [];
  bool? status;
  String message = '';
  String? errorCode;
  dynamic errors;

  T? Function(Map<String, dynamic>)? itemFromJson;

  NetworkResponseObject({required this.itemFromJson});

  NetworkResponseObject.fromDetail(this.status, this.message);

  NetworkResponseObject<T> fromJson(Map<String, dynamic> json) {
    if (itemFromJson != null) {
      final it = itemFromJson!;
      if (json['data'] != null) {
        final response = json['data']!;
        if (response is List<dynamic>) {
          final map = response.map((e) => it.call(e as Map<String, dynamic>));
          list = map.whereType<T>().toList();
        } else if (response is Map<String, dynamic>) {
          result = it.call(response);
        }
      }
    }

    status = json['status'] as bool?;
    message = json['message']?.toString() ?? '';
    errors = json['errors'];
    errorCode = json['error_code'] != null ? json.safe('error_code') : null;
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = result;
    data['errors'] = errors;
    return data;
  }
}


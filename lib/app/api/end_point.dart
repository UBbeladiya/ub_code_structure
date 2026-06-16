

import '../services/storage_service.dart';
import '../utils/utils.dart';
import 'endpoint_http_type.dart';

/// Contract that describes a configured API endpoint.
abstract class EndpointType {
  /// Base host URL.
  String get baseURL;

  /// Relative endpoint path.
  String get path;

  /// Full endpoint URL (`baseURL + path`).
  String get url;

  /// HTTP method to use for this endpoint.
  EndpointHTTPType get httpMethod;

  /// Request body content type.
  String get contentType;

  /// Request headers to send.
  Map<String, dynamic> get headers;
}

/// Default API host used by [Endpoint].
const appBaseURL = 'https://jsonplaceholder.typicode.com';

/// Built-in endpoint catalog used by [WebserviceHelper].
enum Endpoint implements EndpointType {
  /// Fetches all posts.
  posts,

  /// Creates a new post.
  addPost,

  /// Updates a post by id.
  postsId,

  /// Deletes a post by id.
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

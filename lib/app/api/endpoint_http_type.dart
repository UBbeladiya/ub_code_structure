/// Supported HTTP methods for [EndpointType] requests.
enum EndpointHTTPType {
  /// HTTP GET.
  get,

  /// HTTP POST.
  post,

  /// Multipart/form-data POST.
  postMultipart,

  /// HTTP PUT.
  put,

  /// HTTP PATCH.
  patch,

  /// HTTP DELETE.
  delete,
}

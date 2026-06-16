/// Represents the lifecycle state of an API request.
enum APIState {
  /// No request has started yet.
  none,

  /// Request cannot proceed because internet is unavailable.
  noInternet,

  /// Request is currently in progress.
  loading,

  /// Request completed successfully.
  success,

  /// Request failed.
  failure,
}

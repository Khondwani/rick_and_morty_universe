import 'package:dio/dio.dart';

Interceptor headerInterceptor() {
  const apiKey = String.fromEnvironment('ZED_TRAVEL_API_KEY');
  if (apiKey.isEmpty) {
    throw AssertionError('ZED_TRAVEL_API_KEY is not set');
  }
  final encodedAPIKey = Uri.encodeComponent(apiKey);
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers.addAll({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      // Conditionally add headers
      if (_requiresApiKey(options) && _requiresFormUrlEncoded(options)) {
        options.headers.addAll({"X-API-Key": encodedAPIKey});
        options.contentType = Headers.formUrlEncodedContentType;
        options.data = FormData.fromMap(options.data);
      } else if (_requiresApiKey(options) &&
          _requiresFormUrlEncoded(options) == false) {
        options.headers.addAll({"X-API-Key": encodedAPIKey});
      } else if (_requiresApiKey(options) == false &&
          _requiresFormUrlEncoded(options)) {
        options.contentType = Headers.formUrlEncodedContentType;
      }

      return handler.next(options); // continue with request
    },
  );
}

// Helper functions
bool _requiresApiKey(RequestOptions options) {
  return options.path != 'auth/pos';
}

bool _requiresFormUrlEncoded(RequestOptions options) {
  return options.path == 'auth/pos';
}

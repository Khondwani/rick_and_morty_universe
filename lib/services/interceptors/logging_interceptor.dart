import 'package:dio/dio.dart';

Interceptor loggingInterceptor() {
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      print("Request[${options.method}] => PATH: ${options.path}");
      print("Headers: ${options.headers}");
      print("Request Body: ${options.data}");
      return handler.next(options);
    },
    onResponse: (response, handler) {
      print("Response[${response.statusCode}] => Data: ${response.data}");
      return handler.next(response);
    },
    onError: (DioException err, handler) {
      print("Error[${err.response?.statusCode}] => Message: ${err.message}");
      return handler.next(err);
    },
  );
}

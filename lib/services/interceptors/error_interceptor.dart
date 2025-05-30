import 'package:dio/dio.dart';
import 'package:rick_and_morty_universe/services/exceptions/api_exception.dart';

Interceptor errorInterceptor() {
  return InterceptorsWrapper(
    onError: (DioException error, handler) {
      // Custom error handling
      Exception customError = _handleDioException(error);
      // We can pass the custom error back to the caller
      return handler.reject(
        DioException(
          requestOptions: error.requestOptions,
          error: customError,
          type: error.type,
          response: error.response,
        ),
      );
    },
  );
}

// Handle Dio errors such as network issues
Exception _handleDioException(DioException error) {
  if (error.response != null) {
    if (error.response?.data['message'] != null) {
      return APIException(error.response?.data['message']);
    } else {
      return APIException(_getErrorMessage(error.response?.statusCode));
    }
  } else {
    // Handle no response (network error, etc.)
    return APIException("Network error: Unable to connect to the server.");
  }
}

// Returns error messages based on status codes
String _getErrorMessage(int? statusCode) {
  switch (statusCode) {
    case 400:
      return "Bad request: Please check your input.";
    case 401:
      return "Unauthorized: Invalid credentials.";
    case 403:
      return "Forbidden: You don't have permission to access this resource.";
    case 404:
      return "Resource not found.";
    case 500:
      return "Internal server error: Please try again later.";
    default:
      return "An unknown error occurred. If the problem persists, please contact support.";
  }
}

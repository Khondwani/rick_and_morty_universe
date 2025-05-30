import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rick_and_morty_universe/services/interceptors/error_interceptor.dart';
import 'package:rick_and_morty_universe/services/interceptors/header_interceptor.dart';
import 'package:rick_and_morty_universe/services/interceptors/logging_interceptor.dart';

class APIManagerService {
  static final APIManagerService instance = APIManagerService._();

  final Dio _dio = Dio();

  final String baseUrl =
      'https://rickandmortyapi.com/api/'; // Base URL for the API

  APIManagerService._() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(milliseconds: 5000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 3000);
    // Adding interceptors
    _dio.interceptors.addAll([
      loggingInterceptor(),
      headerInterceptor(),
      errorInterceptor(),
    ]);
  }

  // Error Interceptor for centralized error handling

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<Response> put(
    String endpoint,
    Map<String, dynamic> data, {
    bool requiresApiKey = true,
  }) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }

  Future<Response> delete(String endpoint, {bool requiresApiKey = true}) async {
    try {
      final response = await _dio.delete(endpoint);
      return response;
    } on DioException catch (_) {
      rethrow;
    }
  }
}

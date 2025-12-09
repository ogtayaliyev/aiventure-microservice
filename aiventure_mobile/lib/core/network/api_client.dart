import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient._(this.dio);

  /// Construct ApiClient from an existing Dio instance (allows interceptors)
  factory ApiClient.fromDio(Dio dio) => ApiClient._(dio);

  /// Convenience factory for simple clients without custom interceptors
  factory ApiClient({required String baseUrl}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(milliseconds: 15000),
        receiveTimeout: const Duration(milliseconds: 15000),
      ),
    );
    return ApiClient._(dio);
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) =>
      dio.get(path, queryParameters: queryParameters);
  Future<Response> post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) => dio.post(path, data: data, queryParameters: queryParameters);
  Future<Response> put(String path, {data}) => dio.put(path, data: data);
  Future<Response> delete(String path) => dio.delete(path);
}

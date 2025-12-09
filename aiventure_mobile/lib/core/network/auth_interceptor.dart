import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Interceptor that injects JWT from secure storage and attempts refresh on 401.
/// Uses a fresh Dio instance to call the refresh endpoint to avoid request cycles.
class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final String baseUrl;

  AuthInterceptor({required this.storage, required this.baseUrl});

  static const _jwtKey = 'jwt';
  static const _refreshKey = 'refresh_token';

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await storage.read(key: _jwtKey);
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (_) {}
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final response = err.response;
    if (response?.statusCode == 401 &&
        !err.requestOptions.extra.containsKey('retried')) {
      try {
        final refreshToken = await storage.read(key: _refreshKey);
        if (refreshToken != null) {
          final dio = Dio(BaseOptions(baseUrl: baseUrl));
          final refreshResp = await dio.post(
            '/auth/refresh',
            data: {'refreshToken': refreshToken},
          );
          final data = refreshResp.data as Map<String, dynamic>;
          final newToken = data['token'] as String?;
          final newRefresh = data['refreshToken'] as String?;
          if (newToken != null) {
            await storage.write(key: _jwtKey, value: newToken);
          }
          if (newRefresh != null) {
            await storage.write(key: _refreshKey, value: newRefresh);
          }

          // retry original with new token
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer $newToken';
          opts.extra['retried'] = true;
          try {
            final retryResp = await dio.fetch(opts);
            return handler.resolve(retryResp);
          } catch (e) {
            return handler.next(err);
          }
        }
      } catch (_) {
        // fallthrough to original error
      }
    }
    return handler.next(err);
  }
}

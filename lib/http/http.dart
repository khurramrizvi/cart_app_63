import 'package:cart_app/main.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_isar_store/dio_cache_interceptor_isar_store.dart';

class Http {
  static final Dio _dio = Dio()
    ..interceptors.add(
      DioCacheInterceptor(
        options: CacheOptions(
          maxStale: const Duration(hours: 12),
          store: IsarCacheStore(tempPath),
          policy: CachePolicy.request,
        ),
      ),
    );

  static Dio get artworkEndpoint => _dio
    ..interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          options.baseUrl = 'https://api.artic.edu/api/v1';
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) {
          return handler.next(error);
        },
      ),
    ]);
}

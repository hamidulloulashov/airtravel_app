import 'package:airtravel_app/core/token_storage.dart';
import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  @override
  Future<void> onRequest(  // ✅ Future<void> qo'shing
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await TokenStorage.getToken();
      
      print("-------TOKEN---------");
      print(token);
      print("-------TOKEN---------");

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      if (options.data != null) print("Data: ${options.data}");
      
      return handler.next(options);  // ✅ return qo'shing
    } catch (e) {
      print('Token olishda xato: $e');
      return handler.next(options);  // ✅ return qo'shing
    }
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    return handler.next(response);  // ✅ return qo'shing
  }

  @override
  Future<void> onError(  // ✅ Future<void> qo'shing
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final code = err.response?.statusCode;
    final path = err.requestOptions.path;

    if (code == 401) {
      try {
        final refreshToken = await TokenStorage.getRefreshToken();
        
        if (refreshToken != null && refreshToken.isNotEmpty) {
          final dio = Dio(BaseOptions(
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 15),
          ));
          
          final response = await dio.post(
            'http://194.187.122.4:8000/en/api/v1/accounts/user/token/refresh/',
            data: {'refresh': refreshToken},
          );

          if (response.statusCode == 200) {
            final newToken = response.data['access'];
            await TokenStorage.saveToken(newToken);
            
            // Retry request with new token
            final opts = err.requestOptions;
            opts.headers['Authorization'] = 'Bearer $newToken';
            
            final cloneReq = await dio.request(
              opts.path,
              options: Options(
                method: opts.method,
                headers: opts.headers,
              ),
              data: opts.data,
              queryParameters: opts.queryParameters,
            );
            
            return handler.resolve(cloneReq);  // ✅ return qo'shing
          }
        }
        
        // Agar refresh token ishlamasa
        await TokenStorage.deleteToken();
        await TokenStorage.deleteRefreshToken();
        return handler.next(err);  // ✅ return qo'shing
        
      } catch (e) {
        print('Token refresh xatosi: $e');
        await TokenStorage.deleteToken();
        await TokenStorage.deleteRefreshToken();
        return handler.next(err);  // ✅ return qo'shing
      }
    }
    
    return handler.next(err);  // ✅ return qo'shing
  }
}
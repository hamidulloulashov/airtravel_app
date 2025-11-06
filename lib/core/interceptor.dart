import 'package:airtravel_app/core/token_storage.dart';
import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
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


      return handler.next(options);
    } catch (e) {
      return handler.next(options);
    }
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    return handler.next(response);
  }

  @override
  Future<void> onError(
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
            
            return handler.resolve(cloneReq);
          }
        }
        
        await TokenStorage.deleteToken();
        await TokenStorage.deleteRefreshToken();
        return handler.next(err);
        
      } catch (e) {
        await TokenStorage.deleteToken();
        await TokenStorage.deleteRefreshToken();
        return handler.next(err);
      }
    }
    
    return handler.next(err);
  }
}
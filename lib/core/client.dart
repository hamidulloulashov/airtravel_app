import 'package:airtravel_app/core/interceptor.dart';
import 'package:airtravel_app/core/result.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  late final Dio _dio;
  static String _languageCode = 'uz';

  static Future<void> initLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _languageCode = prefs.getString('language_code') ?? 'uz';
  }

  static void updateLanguage(String newLang) {
    _languageCode = newLang;
  }

  static String get baseUrl =>
      "http://194.187.122.4:8000/$_languageCode/api/v1";

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30), 
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );
    
    _dio.interceptors.add(AppInterceptor());
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (obj) {
        },
      ),
    );
    
  }

  Dio get dio => _dio;

  Future<Result<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      if (queryParams != null) {
      }
      
      final response = await _dio.get(path, queryParameters: queryParams);
      
      
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Result.ok(response.data as T);
      } else {
        final errorMsg = "Server error: ${response.statusCode}";
        return Result.error(Exception(errorMsg));
      }
    } on DioException catch (dioError) {
      final errorMsg = _handleDioError(dioError);
      return Result.error(Exception(errorMsg));
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  Future<Result<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    try {
      if (data != null) {
      }
      
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParams,
        options: options,
      );
      
      
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Result.ok(response.data as T);
      } else {
        final errorMsg = "Server error: ${response.statusCode}";
        return Result.error(Exception(errorMsg));
      }
    } on DioException catch (dioError) {
      final errorMsg = _handleDioError(dioError);
      return Result.error(Exception(errorMsg));
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  Future<Result<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParams,
      );
      
      
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Result.ok(response.data as T);
      } else {
        final errorMsg = "Server error: ${response.statusCode}";
        return Result.error(Exception(errorMsg));
      }
    } on DioException catch (dioError) {
      final errorMsg = _handleDioError(dioError);
      return Result.error(Exception(errorMsg));
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  Future<Result<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParams,
      );
      
      
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Result.ok(response.data as T);
      } else {
        final errorMsg = "Server error: ${response.statusCode}";
        return Result.error(Exception(errorMsg));
      }
    } on DioException catch (dioError) {
      final errorMsg = _handleDioError(dioError);
      return Result.error(Exception(errorMsg));
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  Future<Result<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    try {
      
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParams,
        options: options,
      );
      
      
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Result.ok(response.data as T);
      } else {
        final errorMsg = "Server error: ${response.statusCode}";
        return Result.error(Exception(errorMsg));
      }
    } on DioException catch (dioError) {
      final errorMsg = _handleDioError(dioError);
      return Result.error(Exception(errorMsg));
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  String _handleDioError(DioException dioError) {
    
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return 'Server bilan bog\'lanish vaqti tugadi (Timeout: 30s)';
      case DioExceptionType.sendTimeout:
        return 'Ma\'lumot yuborishda vaqt tugadi';
      case DioExceptionType.receiveTimeout:
        return 'Server javob berishda sekin (Timeout: 30s)';
      case DioExceptionType.connectionError:
        return 'Internet aloqasini tekshiring yoki server ishlamayapti';
      case DioExceptionType.badResponse:
        final statusCode = dioError.response?.statusCode;
        final responseData = dioError.response?.data;
        return 'Server xatosi: $statusCode - ${responseData ?? dioError.response?.statusMessage}';
      case DioExceptionType.cancel:
        return 'So\'rov bekor qilindi';
      case DioExceptionType.badCertificate:
        return 'SSL sertifikat xatosi';
      case DioExceptionType.unknown:
        return 'Noma\'lum xato: ${dioError.error ?? dioError.message}';
      default:
        return 'Tarmoq xatosi: ${dioError.message ?? "noma\'lum xato"}';
    }
  }
}
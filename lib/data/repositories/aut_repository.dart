import 'dart:io';
import 'package:dio/dio.dart';
import 'package:airtravel_app/core/client.dart';
import 'package:airtravel_app/core/result.dart';
import 'package:airtravel_app/core/token_storage.dart';
import 'package:airtravel_app/data/model/auth_model.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<Result<UserRegistrationResponse>> registerUser({
    required String phoneNumber,
  }) async {
    try {
      if (phoneNumber.isEmpty) {
        return Result.error(Exception('Telefon raqami kiritilmagan'));
      }

      final request = UserRegistrationRequest(phoneNumber: phoneNumber);

      final result = await _apiClient.post<Map<String, dynamic>>(
        '/accounts/user/check/',
        data: request.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      return result.fold(
        (error) {
          return Result.error(error);
        },
        (data) {
          return Result.ok(UserRegistrationResponse.fromJson(data));
        },
      );
    } catch (e) {
      return Result.error(
        Exception("Ro'yxatdan o'tishda xatolik: ${e.toString()}"),
      );
    }
  }

  Future<Result<VerificationResponse>> verifyCode({
    required String phoneNumber,
    required String code,
  }) async {
    try {
      
      if (phoneNumber.isEmpty) {
        return Result.error(Exception('Telefon raqami bo\'sh'));
      }
      if (code.isEmpty) {
        return Result.error(Exception('Kod kiritilmagan'));
      }

      final request = VerificationRequest(
        phoneNumber: phoneNumber,
        code: code,
      );

      final result = await _apiClient.post<Map<String, dynamic>>(
        '/accounts/user/token/',
        data: request.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      return result.fold(
        (error) {
          return Result.error(error);
        },
        (data) async {
          
          final response = VerificationResponse.fromJson(data);
          
          if (response.hasToken) {
            await TokenStorage.saveToken(response.token!);
            
            if (response.refreshToken != null && response.refreshToken!.isNotEmpty) {
              await TokenStorage.saveRefreshToken(response.refreshToken!);
            }
            
          } else {
          }

          return Result.ok(response);
        },
      );
    } catch (e) {
      return Result.error(
        Exception("Kodni tasdiqlashda xatolik: ${e.toString()}"),
      );
    }
  }

  Future<Result<UserData>> updateProfile({
    String? firstName,
    String? lastName,
    String? region,
    File? profileImage,
    String? phoneNumber,
  }) async {
    try {
      print('👤 Profil yangilanmoqda...');

      final formData = FormData();

      if (phoneNumber != null && phoneNumber.isNotEmpty) {
        formData.fields.add(MapEntry('phone_number', phoneNumber));
      }

      if (firstName != null && firstName.isNotEmpty) {
        formData.fields.add(MapEntry('first_name', firstName));
      }
      if (lastName != null && lastName.isNotEmpty) {
        formData.fields.add(MapEntry('last_name', lastName));
      }
      
      if (region != null && region.isNotEmpty) {
        formData.fields.add(MapEntry('region', region));
      }

      if (profileImage != null) {
        formData.files.add(
          MapEntry(
            'profile_image',
            await MultipartFile.fromFile(
              profileImage.path,
              filename: profileImage.path.split('/').last,
            ),
          ),
        );
      }

      final result = await _apiClient.post<Map<String, dynamic>>(
        '/accounts/user/register/',
        data: formData,
        queryParams: null,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
        ),
      );

      return result.fold(
        (error) {
          return Result.error(error);
        },
        (data) async {
          
          final token = data['access'] ?? data['token'];
          final refreshToken = data['refresh'];
          
  
          if (token != null && token.toString().isNotEmpty) {
            await TokenStorage.saveToken(token.toString());
            
            if (refreshToken != null && refreshToken.toString().isNotEmpty) {
              await TokenStorage.saveRefreshToken(refreshToken.toString());
            }
            
            final savedToken = await TokenStorage.getToken();
          } else {
          }
          
       
          final userData = UserData(
            phoneNumber: phoneNumber,
            firstName: firstName,
            lastName: lastName,
            region: region != null ? int.tryParse(region) : null,
          );
          
          return Result.ok(userData);
        },
      );
    } catch (e) {
      return Result.error(
        Exception('Profilni yangilashda xatolik: ${e.toString()}'),
      );
    }
  }

  Future<Result<UserData>> getProfile() async {
    try {

      final result = await _apiClient.get<Map<String, dynamic>>(
        '/accounts/user/profile/',
      );

      return result.fold(
        (error) {
          return Result.error(error);
        },
        (data) {
          return Result.ok(UserData.fromJson(data));
        },
      );
    } catch (e) {
      return Result.error(
        Exception('Profilni yuklashda xatolik: ${e.toString()}'),
      );
    }
  }

  Future<void> logout() async {
    await TokenStorage.deleteToken();
    await TokenStorage.deleteRefreshToken();
  }
}
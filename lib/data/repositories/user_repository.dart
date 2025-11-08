import 'dart:io';
import 'package:airtravel_app/core/result.dart';
import 'package:airtravel_app/data/model/user_model.dart';
import 'package:airtravel_app/core/client.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final ApiClient _apiClient;
  UserRepository(this._apiClient);

  Future<Result<UserModel>> fetchUserData() async {
    final result = await _apiClient.get<Map<String, dynamic>>(
      '/accounts/user/retrieve/',
    );

    return result.fold(
          (error) => Result.error(error),
          (data) => Result.ok(UserModel.fromJson(data)),
    );
  }

  Future<Result<UserModel>> updateUserData(UserModel user, {File? photo}) async {
    try {
      FormData formData = FormData.fromMap({
        'first_name': user.firstName,
        'last_name': user.lastName,
        'phone_number': user.phoneNumber,
        'region': user.region.id,
        if (photo != null)
          'profile_photo': await MultipartFile.fromFile(
            photo.path,
            filename: 'avatar.jpg',
          ),
      });

      final result = await _apiClient.patch<Map<String, dynamic>>(
        '/accounts/user/update/',
        data: formData,
        options: Options(
          headers: {},
        ),
      );

      return result.fold(
            (error) => Result.error(error),
            (data) => Result.ok(UserModel.fromJson(data)),
      );
    } catch (e) {
      return Result.error(Exception(e));
    }
  }
}

import 'package:airtravel_app/data/model/user_model.dart';
import '../../core/client.dart';
import '../../core/result.dart';

class UserRepository {
  final ApiClient _apiClient;
  UserRepository(this._apiClient);

  Future<Result<UserModel>> fetchUserData() async {
    final result = await _apiClient.get<Map<String, dynamic>>(
      '/accounts/user/retrieve/',
    );

    return result.fold(
          (error) => Result.error(error),
          (data) {
        final user = UserModel.fromJson(data);
        return Result.ok(user);
      },
    );
  }

}

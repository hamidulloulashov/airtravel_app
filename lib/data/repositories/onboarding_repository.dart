import 'package:airtravel_app/core/client.dart';
import 'package:airtravel_app/core/result.dart';
import 'package:airtravel_app/data/model/onboarding_model.dart';

class OnboardingRepository {
  final ApiClient _apiClient;
  OnboardingRepository(this._apiClient);

  Future<Result<List<OnboardingModel>>> fetchOnboardingData() async {
    final result = await _apiClient.get<List<dynamic>>('/gallery/main_page_picture/list/');
    return result.fold(
      (error) => Result.error(error),
      (data) {
        final slides = data
            .map((item) => OnboardingModel.fromJson(item))
            .toList()
            .cast<OnboardingModel>();
        return Result.ok(slides);
      },
    );
  }
}

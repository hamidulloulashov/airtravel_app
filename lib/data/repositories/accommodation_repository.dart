import 'package:airtravel_app/core/client.dart';
import 'package:airtravel_app/core/result.dart';
import 'package:airtravel_app/data/model/accommodation_model.dart';

import '../model/detail_model.dart';

class AccommodationRepository {
  final ApiClient _apiClient;

  AccommodationRepository(this._apiClient);

  Future<Result<AccommodationModel>> fetchAccommodation(int id) async {
    final result = await _apiClient.get<Map<String, dynamic>>(
      '/packages/accommodation/retrieve/$id/',
    );

    return result.fold(
          (error) => Result.error(error),
          (data) {
        final accommodation = AccommodationModel.fromJson(data);
        return Result.ok(accommodation);
      },
    );
  }
  Future<Result<DetailModel>> fetchUmraTripDetail(int tripId) async {
    final result = await _apiClient.get<Map<String, dynamic>>(
      '/packages/package/retrieve/$tripId/',
    );

    return result.fold(
          (error) => Result.error(error),
          (data) {
        try {
          final umraTripDetail = DetailModel.fromJson(data);
          return Result.ok(umraTripDetail);
        } catch (e) {
          return Result.error(Exception(e));
        }
      },
    );
  }
}

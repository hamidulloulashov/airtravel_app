import 'package:airtravel_app/data/model/region_model.dart';
import '../../core/client.dart';
import '../../core/result.dart';

class BaseRepository {
  final ApiClient _apiClient;
  BaseRepository(this._apiClient);

  Future<Result<List<RegionModel>>> fetchRegionData() async {
    final result = await _apiClient.get<List<dynamic>>(
      '/base/region/list/',
    );

    return result.fold(
          (error) => Result.error(error),
          (data) {
        final regions = data.map((e) => RegionModel.fromJson(e)).toList();
        return Result.ok(regions);
      },
    );
  }
}

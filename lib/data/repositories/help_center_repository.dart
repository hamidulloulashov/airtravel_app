import 'package:airtravel_app/data/model/help_center_model.dart';

import '../../core/client.dart';
import '../../core/result.dart';

class HelpCenterRepository {
  final ApiClient _client;

  HelpCenterRepository({required ApiClient client}) : _client = client;

  Future<Result<List<HelpCenterModel>>> getContent() async {
    final result = await _client.get<List<dynamic>>('/about/social_media/list/');
    return result.fold(
          (error) => Result.error(error),
          (value) => Result.ok(
        value.map((e) => HelpCenterModel.fromJson(e)).toList(),
      ),
    );
  }
}


import 'package:airtravel_app/core/client.dart';
import 'package:airtravel_app/core/result.dart';
import 'package:airtravel_app/data/model/home_model.dart';

class HomeRepository {
  final ApiClient _client;

  HomeRepository(this._client);

  Future<Result<PackageListResponse>> getPackages({
  String? title,
  String? popularPlaces,
  String? startDate,
  String? endDate,
  String? country,
  String? city,
  int? limit,
  int? offset,
}) async {
  try {
    final queryParams = <String, dynamic>{};
    if (title != null && title.isNotEmpty) queryParams['title'] = title;
    if (popularPlaces != null && popularPlaces.isNotEmpty) {
      queryParams['popular_places'] = popularPlaces;
    }
    if (startDate != null && startDate.isNotEmpty) queryParams['start_date'] = startDate;
    if (endDate != null && endDate.isNotEmpty) queryParams['end_date'] = endDate;
    if (country != null && country.isNotEmpty) queryParams['country'] = country;
    if (city != null && city.isNotEmpty) queryParams['city'] = city;
    if (limit != null) queryParams['limit'] = limit;
    if (offset != null) queryParams['offset'] = offset;

    final result = await _client.get<dynamic>(
      '/packages/package/list/',
      queryParams: queryParams,
    );

    return result.fold(
      (error) => Result.error(error),
      (data) {
        try {
          if (data is Map<String, dynamic>) {
            final response = PackageListResponse.fromJson(data);
            return Result.ok(response);
          }

          if (data is List) {
            final results = data
                .map((e) => e is Map<String, dynamic>
                    ? HomeModel.fromJson(e)
                    : null)
                .whereType<HomeModel>() 
                .toList();

            final response = PackageListResponse(
              count: results.length,
              next: null,
              previous: null,
              results: results,
            );
            return Result.ok(response);
          }

          return Result.error(
            Exception('Unexpected data format: ${data.runtimeType}'),
          );
        } catch (e) {
          return Result.error(
            Exception('Ma\'lumotlarni qayta ishlashda xatolik: $e'),
          );
        }
      },
    );
  } catch (e) {
    return Result.error(
      Exception('Kutilmagan xatolik: $e'),
    );
  }
}


 Future<Result<List<PopularPlace>>> getPopularPlaces() async {
  try {
    final result = await _client.get<dynamic>(
      '/places/popular_place/list/',
      queryParams: {'limit': 100, 'offset': 0},
    );

    return result.fold(
      (error) {
        return Result.error(error);
      },
      (data) {
        try {
          if (data is Map<String, dynamic>) {
            final results = data['results'];
            
            if (results == null) {
              return Result.ok([]);
            }
            
            if (results is! List) {
              return Result.error(
                Exception('Expected List in results but got ${results.runtimeType}'),
              );
            }
            
            final places = (results as List)
                .map((json) => PopularPlace.fromJson(json as Map<String, dynamic>))
                .toList();
            
            return Result.ok(places);
          }
          
          if (data is List) {
            if (data.isEmpty) {
              return Result.ok([]);
            }
            
            final places = data
                .map((json) => PopularPlace.fromJson(json as Map<String, dynamic>))
                .toList();
            
            return Result.ok(places);
          }
          
          return Result.error(
            Exception('Unexpected data format: ${data.runtimeType}'),
          );
        } catch (e, stackTrace) {
     
      
          return Result.error(Exception('Ma\'lumotlarni qayta ishlashda xatolik: $e'));
        }
      },
    );
  } catch (e, stackTrace) {
    return Result.error(Exception('Tarmoq xatosi: $e'));
  }
}

  Future<Result<void>> toggleLike(int packageId) async {
  try {
    final result = await _client.post<dynamic>(
      '/packages/package/$packageId/like/',
    
    );

    return result.fold(
      (error) => Result.error(error),
      (_) => const Result.ok(null),
    );
  } catch (e) {
    return Result.error(Exception('Like qo\'shishda xatolik: $e'));
  }
}
}

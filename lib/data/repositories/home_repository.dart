
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
      if (startDate != null && startDate.isNotEmpty) {
        queryParams['start_date'] = startDate;
      }
      if (endDate != null && endDate.isNotEmpty) {
        queryParams['end_date'] = endDate;
      }
      if (country != null && country.isNotEmpty) {
        queryParams['country'] = country;
      }
      if (city != null && city.isNotEmpty) queryParams['city'] = city;
      if (limit != null) queryParams['limit'] = limit;
      if (offset != null) queryParams['offset'] = offset;

      final result = await _client.get<dynamic>(
        '/places/popular_place/list/',
        queryParams: queryParams,
      );

      return result.fold(
        (error) => Result.error(error),
        (data) {
          try {
            final jsonData = data is Map<String, dynamic> 
                ? data 
                : (data as Map).cast<String, dynamic>();
            
            final response = PackageListResponse.fromJson(jsonData);
            return Result.ok(response);
          } catch (e) {
            return Result.error(
              Exception('Ma\'lumotlarni qayta ishlashda xatolik: $e'),
            );
          }
        },
      );
    } catch (e) {
      return Result.error(Exception('Kutilmagan xatolik: $e'));
    }
  }

  Future<Result<List<PopularPlace>>> getPopularPlaces() async {
  try {
    final result = await _client.get<dynamic>(
      '/places/popular_place/list/',
    );

    return result.fold(
      (error) => Result.error(error),
      (data) {
        try {
        
          if (data is! List) {
            return Result.error(
              Exception('Kutilgan List, lekin keldi: ${data.runtimeType}'),
            );
          }

          final places = (data as List)
              .map((json) => PopularPlace.fromJson(json as Map<String, dynamic>))
              .toList();

         
          
          return Result.ok(places);
        } catch (e, stackTrace) {
     
          return Result.error(
            Exception('Popular places parse error: $e'),
          );
        }
      },
    );
  } catch (e) {
    return Result.error(Exception('Popular places error: $e'));
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

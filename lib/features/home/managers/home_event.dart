abstract class HomeEvent {
  const HomeEvent();
}

class LoadPackages extends HomeEvent {
  final String? title;
  final String? popularPlaces;
  final String? startDate;
  final String? endDate;
  final String? country;
  final String? city;
  final int? limit;
  final int? offset;
  final bool isRefresh;

  const LoadPackages({
    this.title,
    this.popularPlaces,
    this.startDate,
    this.endDate,
    this.country,
    this.city,
    this.limit = 10,
    this.offset = 0,
    this.isRefresh = false,
  });
}

class LoadMorePackages extends HomeEvent {
  const LoadMorePackages();
}

class TogglePackageLike extends HomeEvent {
  final int packageId;
  final int index;

  const TogglePackageLike({
    required this.packageId,
    required this.index,
  });
}

class SearchPackages extends HomeEvent {
  final String query;

  const SearchPackages(this.query);
}

class FilterPackages extends HomeEvent {
  final String? country;
  final String? city;
  final String? startDate;
  final String? endDate;

  const FilterPackages({
    this.country,
    this.city,
    this.startDate,
    this.endDate,
  });
}
class LoadPopularPlaces extends HomeEvent {
  const LoadPopularPlaces();

  @override
  List<Object?> get props => [];
}
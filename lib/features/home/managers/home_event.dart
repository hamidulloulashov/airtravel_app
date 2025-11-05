
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadPackages extends HomeEvent {
  final bool isRefresh;
  final int limit;

  const LoadPackages({
    this.isRefresh = false,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [isRefresh, limit];
}

class LoadMorePackages extends HomeEvent {
  final int limit;

  const LoadMorePackages({
    this.limit = 10,
  });

  @override
  List<Object?> get props => [limit];
}

// Search packages event
class SearchPackages extends HomeEvent {
  final String query;

  const SearchPackages(this.query);

  @override
  List<Object?> get props => [query];
}

// Clear search event
class ClearSearch extends HomeEvent {
  const ClearSearch();
}

// Refresh packages event
class RefreshPackages extends HomeEvent {
  const RefreshPackages();
}

// Toggle favorite event
class ToggleFavorite extends HomeEvent {
  final int packageId;

  const ToggleFavorite(this.packageId);

  @override
  List<Object?> get props => [packageId];
}

// Filter packages event
class FilterPackages extends HomeEvent {
  final String? destination;
  final int? minPrice;
  final int? maxPrice;
  final int? minDuration;
  final int? maxDuration;

  const FilterPackages({
    this.destination,
    this.minPrice,
    this.maxPrice,
    this.minDuration,
    this.maxDuration,
  });

  @override
  List<Object?> get props => [
        destination,
        minPrice,
        maxPrice,
        minDuration,
        maxDuration,
      ];
}

// Sort packages event
class SortPackages extends HomeEvent {
  final PackageSortType sortType;

  const SortPackages(this.sortType);

  @override
  List<Object?> get props => [sortType];
}

// Sort types
enum PackageSortType {
  priceAsc,
  priceDesc,
  durationAsc,
  durationDesc,
  newest,
  popular,
}
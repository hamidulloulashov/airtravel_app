
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


class SearchPackages extends HomeEvent {
  final String query;

  const SearchPackages(this.query);

  @override
  List<Object?> get props => [query];
  
  @override
  String toString() => 'SearchPackages(query: $query)';
}

class ClearSearch extends HomeEvent {
  const ClearSearch();
  
  @override
  List<Object?> get props => [];
  
  @override
  String toString() => 'ClearSearch()';
}

class RefreshPackages extends HomeEvent {
  const RefreshPackages();
}

class ToggleFavorite extends HomeEvent {
  final int packageId;

  const ToggleFavorite(this.packageId);

  @override
  List<Object?> get props => [packageId];
}

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

class SortPackages extends HomeEvent {
  final PackageSortType sortType;

  const SortPackages(this.sortType);

  @override
  List<Object?> get props => [sortType];
}

enum PackageSortType {
  priceAsc,
  priceDesc,
  durationAsc,
  durationDesc,
  newest,
  popular,
}
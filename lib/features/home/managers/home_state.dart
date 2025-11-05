
import 'package:equatable/equatable.dart';
import 'package:airtravel_app/data/model/home_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}


class PackageInitial extends HomeState {
  const PackageInitial();

  @override
  String toString() => 'PackageInitial';
}



class PackageLoading extends HomeState {
  const PackageLoading();

  @override
  String toString() => 'PackageLoading';
}



class PackageLoaded extends HomeState {
  final List<HomeModel> packages;
  final bool hasMore;
  final int currentPage;

  const PackageLoaded({
    required this.packages,
    this.hasMore = true,
    this.currentPage = 1,
  });

  @override
  List<Object?> get props => [packages, hasMore, currentPage];

  PackageLoaded copyWith({
    List<HomeModel>? packages,
    bool? hasMore,
    int? currentPage,
  }) {
    return PackageLoaded(
      packages: packages ?? this.packages,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  bool get isEmpty => packages.isEmpty;
  bool get isNotEmpty => packages.isNotEmpty;
  int get packageCount => packages.length;
  
  List<HomeModel> get favoritePackages {
    return packages.where((pkg) => pkg.isLiked).toList();
  }
  
  List<HomeModel> get discountedPackages {
    return packages.where((pkg) => pkg.hasDiscount).toList();
  }

  @override
  String toString() => 
    'PackageLoaded(packages: ${packages.length}, hasMore: $hasMore, page: $currentPage)';
}



class PackageLoadingMore extends HomeState {
  final List<HomeModel> packages;
  final int currentPage;

  const PackageLoadingMore({
    required this.packages,
    required this.currentPage,
  });

  @override
  List<Object?> get props => [packages, currentPage];

  
  int get packageCount => packages.length;

  @override
  String toString() => 
    'PackageLoadingMore(packages: ${packages.length}, page: $currentPage)';
}



class PackageError extends HomeState {
  final String message;
  final List<HomeModel>? cachedPackages;
  final dynamic error;

  const PackageError({
    required this.message,
    this.cachedPackages,
    this.error,
  });

  @override
  List<Object?> get props => [message, cachedPackages, error];

  bool get hasCachedData => 
    cachedPackages != null && cachedPackages!.isNotEmpty;
  
  int get cachedPackageCount => cachedPackages?.length ?? 0;

  @override
  String toString() => 
    'PackageError(message: $message, cached: ${cachedPackages?.length ?? 0})';
}



class PackageSearching extends HomeState {
  final String query;

  const PackageSearching({required this.query});

  @override
  List<Object?> get props => [query];

  @override
  String toString() => 'PackageSearching(query: $query)';
}

class PackageSearchResults extends HomeState {
  final List<HomeModel> packages;
  final String query;

  const PackageSearchResults({
    required this.packages,
    required this.query,
  });

  @override
  List<Object?> get props => [packages, query];

  bool get isEmpty => packages.isEmpty;
  bool get isNotEmpty => packages.isNotEmpty;
  int get resultCount => packages.length;

  @override
  String toString() => 
    'PackageSearchResults(results: ${packages.length}, query: $query)';
}

class PackageEmpty extends HomeState {
  final String? message;

  const PackageEmpty({this.message});

  @override
  List<Object?> get props => [message];
  
  @override
  String toString() => 'PackageEmpty(message: $message)';
}



class PackageRefreshing extends HomeState {
  final List<HomeModel> oldPackages;

  const PackageRefreshing({required this.oldPackages});

  @override
  List<Object?> get props => [oldPackages];

  int get oldPackageCount => oldPackages.length;

  @override
  String toString() => 
    'PackageRefreshing(oldPackages: ${oldPackages.length})';
}



class PackageFiltered extends HomeState {
  final List<HomeModel> packages;
  final Map<String, dynamic> filters;

  const PackageFiltered({
    required this.packages,
    required this.filters,
  });

  @override
  List<Object?> get props => [packages, filters];

  bool get isEmpty => packages.isEmpty;
  bool get isNotEmpty => packages.isNotEmpty;
  int get resultCount => packages.length;
  bool get hasActiveFilters => filters.isNotEmpty;

  @override
  String toString() => 
    'PackageFiltered(results: ${packages.length}, filters: $filters)';
}


class PackageSorted extends HomeState {
  final List<HomeModel> packages;
  final String sortBy;

  const PackageSorted({
    required this.packages,
    required this.sortBy,
  });

  @override
  List<Object?> get props => [packages, sortBy];

  int get packageCount => packages.length;

  @override
  String toString() => 
    'PackageSorted(packages: ${packages.length}, sortBy: $sortBy)';
}
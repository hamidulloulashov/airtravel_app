import 'package:airtravel_app/data/model/home_model.dart';

abstract class HomeState {
  const HomeState();
}

class PackageInitial extends HomeState {
  const PackageInitial();
}

class PackageLoading extends HomeState {
  const PackageLoading();
}

class PackageLoadingMore extends HomeState {
  final List<HomeModel> packages;

  const PackageLoadingMore(this.packages);
}

class PackageLoaded extends HomeState {
  final List<HomeModel> packages;
  final int totalCount;
  final bool hasMore;
  final int currentOffset;

  const PackageLoaded({
    required this.packages,
    required this.totalCount,
    required this.hasMore,
    required this.currentOffset,
  });

  PackageLoaded copyWith({
    List<HomeModel>? packages,
    int? totalCount,
    bool? hasMore,
    int? currentOffset,
  }) {
    return PackageLoaded(
      packages: packages ?? this.packages,
      totalCount: totalCount ?? this.totalCount,
      hasMore: hasMore ?? this.hasMore,
      currentOffset: currentOffset ?? this.currentOffset,
    );
  }
}

class PackageError extends HomeState {
  final String message;

  const PackageError(this.message);
}

class PackageEmpty extends HomeState {
  const PackageEmpty();
}
// ✅ Yangi state'lar
class PopularPlacesLoading extends HomeState {
  const PopularPlacesLoading();

  @override
  List<Object?> get props => [];
}

class PopularPlacesLoaded extends HomeState {
  final List<PopularPlace> places;

  const PopularPlacesLoaded(this.places);

  @override
  List<Object?> get props => [places];
}

class PopularPlacesError extends HomeState {
  final String message;

  const PopularPlacesError(this.message);

  @override
  List<Object?> get props => [message];
}
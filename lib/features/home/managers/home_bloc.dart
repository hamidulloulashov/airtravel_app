import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:airtravel_app/data/model/home_model.dart';
import 'package:airtravel_app/data/repositories/home_repository.dart';
import 'package:airtravel_app/features/home/managers/home_event.dart';
import 'package:airtravel_app/features/home/managers/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  
  List<HomeModel> _allPackages = [];
  int _currentOffset = 0;
  bool _hasMore = true;
  final int _pageSize = 10;

  HomeBloc({required this.repository}) : super(const PackageInitial()) {
    on<LoadPackages>(_onLoadPackages);
    on<LoadMorePackages>(_onLoadMorePackages);
    on<SearchPackages>(_onSearchPackages);
    on<ClearSearch>(_onClearSearch);
    on<RefreshPackages>(_onRefreshPackages);
    on<ToggleFavorite>(_onToggleFavorite);
    on<FilterPackages>(_onFilterPackages);
    on<SortPackages>(_onSortPackages);
  }

  Future<void> _onLoadPackages(
    LoadPackages event,
    Emitter<HomeState> emit,
  ) async {
    try {
      if (event.isRefresh) {
        emit(PackageRefreshing(oldPackages: _allPackages));
      } else {
        emit(const PackageLoading());
      }

      _currentOffset = 0;
      _hasMore = true;

      final result = await repository.getPackages(
        limit: event.limit,
        offset: _currentOffset,
      );

      result.fold(
        (error) {
          emit(PackageError(
            message: error.toString(),
            cachedPackages: _allPackages.isNotEmpty ? _allPackages : null,
          ));
        },
        (response) {
          _allPackages = response.results;
          _currentOffset = event.limit;
          _hasMore = response.hasMore;

          if (_allPackages.isEmpty) {
            emit(const PackageEmpty(
              message: 'Hozircha hech qanday paket yo\'q',
            ));
          } else {
            emit(PackageLoaded(
              packages: _allPackages,
              hasMore: _hasMore,
              currentPage: 1,
            ));
          }
        },
      );
    } catch (e) {
      emit(PackageError(
        message: 'Xatolik yuz berdi: ${e.toString()}',
        cachedPackages: _allPackages.isNotEmpty ? _allPackages : null,
      ));
    }
  }

  Future<void> _onLoadMorePackages(
    LoadMorePackages event,
    Emitter<HomeState> emit,
  ) async {
    if (!_hasMore || state is PackageLoadingMore) return;

    try {
      final currentPage = (_currentOffset ~/ _pageSize) + 1;

      emit(PackageLoadingMore(
        packages: _allPackages,
        currentPage: currentPage,
      ));

      final result = await repository.getPackages(
        limit: event.limit,
        offset: _currentOffset,
      );

      result.fold(
        (error) {
          emit(PackageLoaded(
            packages: _allPackages,
            hasMore: _hasMore,
            currentPage: currentPage - 1,
          ));
        },
        (response) {
          final newPackages = response.results.where((newPkg) {
            return !_allPackages.any((existingPkg) => existingPkg.id == newPkg.id);
          }).toList();
          
          _allPackages.addAll(newPackages);
          _currentOffset += event.limit;
          _hasMore = response.hasMore;

          emit(PackageLoaded(
            packages: _allPackages,
            hasMore: _hasMore,
            currentPage: currentPage,
          ));
        },
      );
    } catch (e) {
      final currentPage = (_currentOffset ~/ _pageSize);
      emit(PackageLoaded(
        packages: _allPackages,
        hasMore: _hasMore,
        currentPage: currentPage,
      ));
    }
  }

  Future<void> _onSearchPackages(
    SearchPackages event,
    Emitter<HomeState> emit,
  ) async {
    final query = event.query.trim();
    

    if (query.isEmpty) {
      emit(PackageLoaded(
        packages: _allPackages,
        hasMore: _hasMore,
        currentPage: (_currentOffset ~/ _pageSize),
      ));
      return;
    }

    emit(PackageSearching(query: query));

    await Future.delayed(const Duration(milliseconds: 300));

    final searchQuery = query.toLowerCase();
    final searchResults = _allPackages.where((package) {
      final titleMatch = package.title.toLowerCase().contains(searchQuery);
      final cityMatch = package.destinationCities.toLowerCase().contains(searchQuery);
      final destMatch = package.destinations.any((dest) => 
        dest.ccity.toLowerCase().contains(searchQuery)
      );
      
      return titleMatch || cityMatch || destMatch;
    }).toList();


    if (searchResults.isEmpty) {
      emit(const PackageEmpty(
        message: 'Qidiruv bo\'yicha natija topilmadi',
      ));
    } else {
      emit(PackageSearchResults(
        packages: searchResults,
        query: query,
      ));
    }
  }

  void _onClearSearch(
    ClearSearch event,
    Emitter<HomeState> emit,
  ) {
    
    emit(PackageLoaded(
      packages: _allPackages,
      hasMore: _hasMore,
      currentPage: (_currentOffset ~/ _pageSize),
    ));
  }

  Future<void> _onRefreshPackages(
    RefreshPackages event,
    Emitter<HomeState> emit,
  ) async {
    add(const LoadPackages(isRefresh: true));
  }

  void _onToggleFavorite(
    ToggleFavorite event,
    Emitter<HomeState> emit,
  ) {
    final updatedPackages = _allPackages.map((package) {
      if (package.id == event.packageId) {
        return package.copyWith(isLiked: !package.isLiked);
      }
      return package;
    }).toList();

    _allPackages = updatedPackages;

    if (state is PackageLoaded) {
      final loadedState = state as PackageLoaded;
      emit(loadedState.copyWith(packages: updatedPackages));
    } else if (state is PackageSearchResults) {
      final searchState = state as PackageSearchResults;
      final updatedSearchResults = searchState.packages.map((package) {
        if (package.id == event.packageId) {
          return package.copyWith(isLiked: !package.isLiked);
        }
        return package;
      }).toList();

      emit(PackageSearchResults(
        packages: updatedSearchResults,
        query: searchState.query,
      ));
    }
  }

  void _onFilterPackages(
    FilterPackages event,
    Emitter<HomeState> emit,
  ) {
    var filteredPackages = List<HomeModel>.from(_allPackages);

    if (event.destination != null && event.destination!.isNotEmpty) {
      filteredPackages = filteredPackages.filterByDestination(event.destination!);
    }

    if (event.minPrice != null || event.maxPrice != null) {
      filteredPackages = filteredPackages.filterByPriceRange(
        minPrice: event.minPrice,
        maxPrice: event.maxPrice,
      );
    }

    if (event.minDuration != null || event.maxDuration != null) {
      filteredPackages = filteredPackages.filterByDuration(
        minDuration: event.minDuration,
        maxDuration: event.maxDuration,
      );
    }

    if (filteredPackages.isEmpty) {
      emit(const PackageEmpty(
        message: 'Filter bo\'yicha natija topilmadi',
      ));
    } else {
      emit(PackageLoaded(
        packages: filteredPackages,
        hasMore: false,
        currentPage: 1,
      ));
    }
  }

  void _onSortPackages(
    SortPackages event,
    Emitter<HomeState> emit,
  ) {
    final currentState = state;
    List<HomeModel> packagesToSort;

    if (currentState is PackageLoaded) {
      packagesToSort = List.from(currentState.packages);
    } else if (currentState is PackageSearchResults) {
      packagesToSort = List.from(currentState.packages);
    } else {
      return;
    }

    switch (event.sortType) {
      case PackageSortType.priceAsc:
        packagesToSort = packagesToSort.sortByPriceAsc();
        break;

      case PackageSortType.priceDesc:
        packagesToSort = packagesToSort.sortByPriceDesc();
        break;

      case PackageSortType.durationAsc:
        packagesToSort = packagesToSort.sortByDurationAsc();
        break;

      case PackageSortType.durationDesc:
        packagesToSort = packagesToSort.sortByDurationDesc();
        break;

      case PackageSortType.newest:
        packagesToSort.sort((a, b) => b.id.compareTo(a.id));
        break;

      case PackageSortType.popular:
        packagesToSort = packagesToSort.sortByDiscount();
        break;
    }


    if (currentState is PackageLoaded) {
      emit(currentState.copyWith(packages: packagesToSort));
    } else if (currentState is PackageSearchResults) {
      emit(PackageSearchResults(
        packages: packagesToSort,
        query: currentState.query,
      ));
    }
  }

  List<HomeModel> get favoritePackages {
    return _allPackages.where((pkg) => pkg.isLiked).toList();
  }

  List<HomeModel> get discountedPackages {
    return _allPackages.filterByDiscount();
  }

  int get totalLoadedPackages => _allPackages.length;

  bool get hasCachedData => _allPackages.isNotEmpty;

  void clearCache() {
    _allPackages.clear();
    _currentOffset = 0;
    _hasMore = true;
  }

  @override
  Future<void> close() {
    clearCache();
    return super.close();
  }
}
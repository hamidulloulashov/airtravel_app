import 'package:airtravel_app/data/model/home_model.dart';
import 'package:airtravel_app/data/repositories/home_repository.dart';
import 'package:airtravel_app/features/home/managers/home_event.dart';
import 'package:airtravel_app/features/home/managers/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _repository;
  
  List<HomeModel> _allPackages = [];
  int _currentOffset = 0;
  final int _limit = 10;
  bool _hasMore = true;
  
  String? _currentTitle;
  String? _currentCountry;
  String? _currentCity;
  String? _currentStartDate;
  String? _currentEndDate;

  HomeBloc({required HomeRepository repository})
      : _repository = repository,
        super(const PackageInitial()) {
    on<LoadPackages>(_onLoadPackages);
    on<LoadMorePackages>(_onLoadMorePackages);
    on<TogglePackageLike>(_onToggleLike);
    on<SearchPackages>(_onSearchPackages);
    on<FilterPackages>(_onFilterPackages);
    on<LoadPopularPlaces>(_onLoadPopularPlaces);
    
  }

  Future<void> _onLoadPackages(
    LoadPackages event,
    Emitter<HomeState> emit,
  ) async {
    if (event.isRefresh) {
      _currentOffset = 0;
      _allPackages.clear();
      _hasMore = true;
    }

    if (_allPackages.isEmpty) {
      emit(const PackageLoading());
    }

    _currentTitle = event.title;
    _currentCountry = event.country;
    _currentCity = event.city;
    _currentStartDate = event.startDate;
    _currentEndDate = event.endDate;

    try {
      final result = await _repository.getPackages(
        title: event.title,
        popularPlaces: event.popularPlaces,
        startDate: event.startDate,
        endDate: event.endDate,
        country: event.country,
        city: event.city,
        limit: event.limit ?? _limit,
        offset: event.offset ?? 0,
      );

      result.fold(
        (error) {
          emit(PackageError(error.toString()));
        },
        (response) {
          
          if (response.results.isEmpty && _allPackages.isEmpty) {
            emit(const PackageEmpty());
          } else {
            _allPackages = response.results;
            _currentOffset = _allPackages.length;
            _hasMore = response.next != null;
            
            emit(PackageLoaded(
              packages: _allPackages,
              totalCount: response.count,
              hasMore: _hasMore,
              currentOffset: _currentOffset,
            ));
          }
        },
      );
    } catch (e) {
      emit(PackageError('Xatolik yuz berdi: $e'));
    }
  }

  Future<void> _onLoadMorePackages(
    LoadMorePackages event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! PackageLoaded) return;
    if (!_hasMore) return;

    final currentState = state as PackageLoaded;
    emit(PackageLoadingMore(currentState.packages));

    try {
      final result = await _repository.getPackages(
        title: _currentTitle,
        country: _currentCountry,
        city: _currentCity,
        startDate: _currentStartDate,
        endDate: _currentEndDate,
        limit: _limit,
        offset: _currentOffset,
      );

      result.fold(
        (error) {
          emit(currentState);
        },
        (response) {
          
          _allPackages.addAll(response.results);
          _currentOffset = _allPackages.length;
          _hasMore = response.next != null;

          emit(PackageLoaded(
            packages: _allPackages,
            totalCount: response.count,
            hasMore: _hasMore,
            currentOffset: _currentOffset,
          ));
        },
      );
    } catch (e) {
      emit(currentState);
    }
  }

  Future<void> _onToggleLike(
    TogglePackageLike event,
    Emitter<HomeState> emit,
  ) async {
    if (state is! PackageLoaded) return;

    final currentState = state as PackageLoaded;
    final updatedPackages = List<HomeModel>.from(currentState.packages);
    
    final package = updatedPackages[event.index];
    updatedPackages[event.index] = package.copyWith(isLiked: !package.isLiked);

    emit(currentState.copyWith(packages: updatedPackages));

    try {
      final result = await _repository.toggleLike(event.packageId);

      result.fold(
        (error) {
          updatedPackages[event.index] = package;
          emit(currentState.copyWith(packages: updatedPackages));
        },
        (_) {
          _allPackages = updatedPackages;
        },
      );
    } catch (e) {
      updatedPackages[event.index] = package;
      emit(currentState.copyWith(packages: updatedPackages));
    }
  }

  Future<void> _onSearchPackages(
    SearchPackages event,
    Emitter<HomeState> emit,
  ) async {
    add(LoadPackages(
      title: event.query,
      isRefresh: true,
    ));
  }

  Future<void> _onFilterPackages(
    FilterPackages event,
    Emitter<HomeState> emit,
  ) async {
    add(LoadPackages(
      country: event.country,
      city: event.city,
      startDate: event.startDate,
      endDate: event.endDate,
      isRefresh: true,
    ));
  }

  Future<void> _onLoadPopularPlaces(
    LoadPopularPlaces event,
    Emitter<HomeState> emit,
  ) async {
    emit(const PopularPlacesLoading());

    try {
      final result = await _repository.getPopularPlaces();

      result.fold(
        (error) {
          emit(PopularPlacesError(error.toString()));
        },
        (places) {
          emit(PopularPlacesLoaded(places));
        },
      );
    } catch (e) {
      emit(PopularPlacesError('Xatolik yuz berdi: $e'));
    }
  }
}
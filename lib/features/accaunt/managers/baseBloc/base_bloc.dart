import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:airtravel_app/core/utils/status.dart';
import 'package:airtravel_app/data/repositories/base_repository.dart';
import 'base_state.dart';

part 'base_event.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  final BaseRepository _baseRepo;

  BaseBloc({required BaseRepository baseRepo})
      : _baseRepo = baseRepo,
        super(BaseState.initial()) {
    on<BaseFetchRegions>(_onFetchRegions);

    add(BaseFetchRegions());
  }

  Future<void> _onFetchRegions(
      BaseFetchRegions event, Emitter<BaseState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final result = await _baseRepo.fetchRegionData();

    result.fold(
          (error) => emit(
        state.copyWith(status: Status.error, errorMessage: error.toString()),
      ),
          (regions) => emit(
        state.copyWith(status: Status.success, regions: regions),
      ),
    );
  }
}

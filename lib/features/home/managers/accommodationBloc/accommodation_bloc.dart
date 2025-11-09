import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:airtravel_app/core/utils/status.dart';
import 'package:airtravel_app/data/repositories/accommodation_repository.dart';
import 'accommodation_state.dart';

part 'accommodation_event.dart';

class AccommodationBloc extends Bloc<AccommodationEvent, AccommodationState> {
  final AccommodationRepository repository;

  AccommodationBloc({required this.repository})
      : super(AccommodationState.initial()) {
    on<FetchAccommodation>((event, emit) async {
      emit(state.copyWith(status: Status.loading));

      final result = await repository.fetchAccommodation(event.id);
      result.fold(
            (error) => emit(state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        )),
            (data) => emit(state.copyWith(
          status: Status.success,
          accommodation: data,
        )),
      );
    });
  }
}

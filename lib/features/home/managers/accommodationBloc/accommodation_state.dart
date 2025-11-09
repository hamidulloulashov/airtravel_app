import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:airtravel_app/core/utils/status.dart';
import 'package:airtravel_app/data/model/accommodation_model.dart';

part 'accommodation_state.freezed.dart';

@freezed
abstract class AccommodationState with _$AccommodationState {
  const factory AccommodationState({
    required Status status,
    AccommodationModel? accommodation,
    String? errorMessage,
  }) = _AccommodationState;

  factory AccommodationState.initial() => const AccommodationState(
    status: Status.initial,
    accommodation: null,
    errorMessage: null,
  );
}

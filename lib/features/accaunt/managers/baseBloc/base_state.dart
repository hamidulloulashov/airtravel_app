import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:airtravel_app/core/utils/status.dart';
import 'package:airtravel_app/data/model/region_model.dart';

part 'base_state.freezed.dart';

@freezed
abstract class BaseState with _$BaseState {
  factory BaseState({
    required Status status,
    String? errorMessage,
    required List<RegionModel> regions,
  }) = _BaseState;

  factory BaseState.initial() => BaseState(
    status: Status.initial,
    errorMessage: null,
    regions: [],
  );
}

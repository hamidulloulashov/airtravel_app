import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:airtravel_app/data/model/help_center_model.dart';
import '../../../../core/utils/status.dart';

part 'help_center_state.freezed.dart';

@freezed
abstract class HelpCenterState with _$HelpCenterState {
  const factory HelpCenterState({
    required Status status,
    String? errorMessage,
    required List<HelpCenterModel> contacts,
    required List<FaqModel> faqs,
  }) = _HelpCenterState;

  factory HelpCenterState.initial() => HelpCenterState(
    status: Status.loading,
    errorMessage: null,
    contacts: const [],
    faqs: const [],
  );
}

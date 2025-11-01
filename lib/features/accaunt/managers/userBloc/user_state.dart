import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:airtravel_app/core/utils/status.dart';
import 'package:airtravel_app/data/model/user_model.dart';

part 'user_state.freezed.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState({
    required Status status,
    UserModel? user,
    String? errorMessage,
  }) = _UserState;

  factory UserState.initial() => const UserState(
    status: Status.initial,
    user: null,
    errorMessage: null,
  );
}

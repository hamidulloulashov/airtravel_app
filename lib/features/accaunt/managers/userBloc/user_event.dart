part of 'user_bloc.dart';

sealed class UserEvent {}

final class FetchUserData extends UserEvent {}

final class UpdateUserData extends UserEvent {
  final UserModel user;
  final File? photo;

  UpdateUserData(this.user, {this.photo});
}

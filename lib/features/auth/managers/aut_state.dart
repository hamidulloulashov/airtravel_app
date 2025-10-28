import 'package:airtravel_app/data/model/auth_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class RegistrationSuccess extends AuthState {
  final String message;
  final String phoneNumber;
  final bool isRegistered;

  const RegistrationSuccess({
    required this.message,
    required this.phoneNumber,
    required this.isRegistered,
  });

  @override
  List<Object?> get props => [message, phoneNumber, isRegistered];
}

class VerificationSuccess extends AuthState {
  final String token;
  final UserData? user;
  final bool isExistingUser;

  const VerificationSuccess({
    required this.token,
    this.user,
    this.isExistingUser = false,
  });

  @override
  List<Object?> get props => [token, user, isExistingUser];
}

class Authenticated extends AuthState {
  final UserData user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class ProfileUpdated extends AuthState {
  final UserData user;

  const ProfileUpdated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
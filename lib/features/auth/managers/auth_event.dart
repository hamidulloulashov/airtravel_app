import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class RegisterUserEvent extends AuthEvent {
  final String phoneNumber;
  const RegisterUserEvent({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class VerifyCodeEvent extends AuthEvent {
  final String phoneNumber;
  final String code;

  const VerifyCodeEvent({
    required this.phoneNumber,
    required this.code,
  });

  @override
  List<Object?> get props => [phoneNumber, code];
}

class UpdateProfileEvent extends AuthEvent {
  final String? firstName;
  final String? lastName;
  final String? region;
  final File? profileImage;
  final String? phoneNumber; 

  const UpdateProfileEvent({
    this.firstName,
    this.lastName,
    this.region,
    this.profileImage,
    this.phoneNumber, required bool isNewUser,
  });

  @override
  List<Object?> get props => [firstName, lastName, region, profileImage, phoneNumber];
}

class GetProfileEvent extends AuthEvent {
  const GetProfileEvent();
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

class ResetAuthEvent extends AuthEvent {
  const ResetAuthEvent();
}

class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}

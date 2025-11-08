import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:airtravel_app/core/utils/status.dart';
import 'package:airtravel_app/data/model/user_model.dart';
import '../../../../data/repositories/user_repository.dart';
import 'user_state.dart';

part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserState.initial()) {
    on<FetchUserData>((event, emit) async {
      emit(state.copyWith(status: Status.loading));

      final result = await userRepository.fetchUserData();
      result.fold(
        (error) => emit(
          state.copyWith(
            status: Status.error,
            errorMessage: error.toString(),
          ),
        ),
        (value) => emit(
          state.copyWith(
            status: Status.success,
            user: value,
          ),
        ),
      );
    });

    on<UpdateUserData>((event, emit) async {
      emit(state.copyWith(status: Status.loading));

      final result = await userRepository.updateUserData(
        event.user,
        photo: event.photo,
      );

      result.fold(
        (error) => emit(
          state.copyWith(
            status: Status.error,
            errorMessage: error.toString(),
          ),
        ),
        (value) => emit(
          state.copyWith(
            status: Status.success,
            user: value,
          ),
        ),
      );
    });
  }
}

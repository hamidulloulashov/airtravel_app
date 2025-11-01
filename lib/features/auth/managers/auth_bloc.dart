import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:airtravel_app/core/token_storage.dart';
import 'package:airtravel_app/data/repositories/aut_repository.dart';
import 'auth_event.dart';
import 'aut_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(const AuthInitial()) {
    on<RegisterUserEvent>(_onRegisterUser);
    on<VerifyCodeEvent>(_onVerifyCode);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<GetProfileEvent>(_onGetProfile);
    on<LogoutEvent>(_onLogout);
    on<ResetAuthEvent>(_onResetAuth);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  Future<void> _onRegisterUser(
    RegisterUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _repository.registerUser(phoneNumber: event.phoneNumber);

    result.fold(
      (error) {
        emit(AuthError(error.toString()));
      },
      (response) {
        final isRegistered = response.exist ?? false;
        
        emit(
          RegistrationSuccess(
            message: 'Tasdiqlash kodi yuborildi',
            phoneNumber: event.phoneNumber,
            isRegistered: isRegistered, 
          ),
        );
      },
    );
  }

  Future<void> _onVerifyCode(
    VerifyCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    final result = await _repository.verifyCode(
      phoneNumber: event.phoneNumber,
      code: event.code,
    );

    result.fold(
      (error) {
        emit(AuthError(error.toString()));
      },
      (response) {
        final isExistingUser = response.exist == true;
        final hasUserData = response.user != null && 
                           response.user!.firstName != null && 
                           response.user!.firstName!.isNotEmpty;
        
       
        emit(
          VerificationSuccess(
            token: response.token,
            user: response.user,
            isExistingUser: isExistingUser,
          ),
        );
      },
    );
  }

  Future<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<AuthState> emit,
  ) async {
    
    emit(const AuthLoading());
    final result = await _repository.updateProfile(
      firstName: event.firstName,
      lastName: event.lastName,
      region: event.region,
      profileImage: event.profileImage,
      phoneNumber: event.phoneNumber,
    );

    result.fold(
      (error) {
        emit(AuthError(error.toString()));
      },
      (user) {
        emit(ProfileUpdated(user));
      },
    );
  }

  Future<void> _onGetProfile(
    GetProfileEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await _repository.getProfile();

    result.fold(
      (error) {
        emit(AuthError(error.toString()));
      },
      (user) {
        emit(Authenticated(user));
      },
    );
  }

  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _repository.logout();
    emit(const Unauthenticated());
  }

  void _onResetAuth(
    ResetAuthEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(const AuthInitial());
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    
    emit(const AuthLoading());
    final hasToken = await TokenStorage.hasToken();

    if (hasToken) {
      add(const GetProfileEvent());
    } else {
      emit(const Unauthenticated());
    }
  }
}

import 'package:airtravel_app/features/onboarding/managers/onboarding_event.dart';
import 'package:airtravel_app/features/onboarding/managers/onboarding_state.dart';
import 'package:bloc/bloc.dart';
import 'package:airtravel_app/data/repositories/onboarding_repository.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final OnboardingRepository repository;

  OnboardingBloc(this.repository) : super(OnboardingInitial()) {
    on<LoadOnboardingEvent>(_onLoadOnboarding);
  }

  Future<void> _onLoadOnboarding(
    LoadOnboardingEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(OnboardingLoading());
    final result = await repository.fetchOnboardingData();

    result.fold(
      (error) => emit(OnboardingError(error.toString())),
      (data) => emit(OnboardingLoaded(data)),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/status.dart';
import '../../../../data/repositories/help_center_repository.dart';
import 'help_center_state.dart';
part 'help_center_event.dart';

class HelpCenterBloc extends Bloc<HelpCenterEvent, HelpCenterState> {
  HelpCenterBloc({
    required HelpCenterRepository helpCenterRepo,
  })  : _helpCenterRepo = helpCenterRepo,
        super(HelpCenterState.initial()) {

    on<HelpCenterContentLoading>(_onContentLoading);

    add(HelpCenterContentLoading());
  }

  final HelpCenterRepository _helpCenterRepo;

  Future<void> _onContentLoading(
      HelpCenterContentLoading event,
      Emitter<HelpCenterState> emit,
      ) async {
    emit(state.copyWith(status: Status.loading));
    final result = await _helpCenterRepo.getContent();

    result.fold(
          (error) => emit(
        state.copyWith(status: Status.error, errorMessage: error.toString()),
      ),
          (value) =>
          emit(state.copyWith(status: Status.success, contacts: value)),
    );
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/status.dart';
import '../../../../data/repositories/payment_repository.dart';
import 'payment_state.dart';

part 'payment_event.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository _paymentRepo;

  PaymentBloc({required PaymentRepository paymentRepo})
      : _paymentRepo = paymentRepo,
        super(PaymentState.initial()) {
    on<PaymentsLoading>(_onPaymentsLoading);
    add(PaymentsLoading());
  }

  Future<void> _onPaymentsLoading(PaymentsLoading event, Emitter<PaymentState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final result = await _paymentRepo.fetchPayment();

    result.fold(
      (error) => emit(
        state.copyWith(status: Status.error, errorMessage: error.toString()),
      ),
      (value) => emit(
        state.copyWith(status: Status.success, payments: value),
      ),
    );
  }
}

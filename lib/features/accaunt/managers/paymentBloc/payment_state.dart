import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/status.dart';
import '../../../../data/model/payment_model.dart';

part 'payment_state.freezed.dart';

@freezed
abstract class PaymentState with _$PaymentState {
  const factory PaymentState({
    required Status status,
    String? errorMessage,
    required List<PaymentModel> payments,
  }) = _PaymentState;

  factory PaymentState.initial() => PaymentState(
        status: Status.loading,
        errorMessage: null,
        payments: [],
      );
}

import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/status.dart';
import '../../../../data/model/order_model.dart';
part 'order_state.freezed.dart';

@freezed
abstract class OrderState with _$OrderState {
  const factory OrderState({
    required Status status,
    String? errorMessage,
    required List<OrderModel> orders,
  }) = _OrderState;

  factory OrderState.initial() => OrderState(
    status: Status.loading,
    errorMessage: null,
    orders: [],
  );
}

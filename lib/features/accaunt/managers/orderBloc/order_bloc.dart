import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/status.dart';
import '../../../../data/repositories/order_repository.dart';
import 'order_state.dart';
part 'order_event.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepo;

  OrderBloc({required OrderRepository orderRepo})
      : _orderRepo = orderRepo,
        super(OrderState.initial()) {
    on<OrdersLoading>(_onOrdersLoading);
    add(OrdersLoading());
  }

  Future<void> _onOrdersLoading(
      OrdersLoading event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final result = await _orderRepo.fetchOrders();

    result.fold(
          (error) => emit(
        state.copyWith(status: Status.error, errorMessage: error.toString()),
      ),
          (value) => emit(
        state.copyWith(status: Status.success, orders: value),
      ),
    );
  }
}

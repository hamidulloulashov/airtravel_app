import 'package:airtravel_app/core/client.dart';
import 'package:airtravel_app/core/result.dart';
import 'package:airtravel_app/data/model/order_model.dart';

class OrderRepository {
  final ApiClient _apiClient;

  OrderRepository(this._apiClient);

  Future<Result<List<OrderModel>>> fetchOrders() async {
    final result = await _apiClient.get<List<dynamic>>('/orders/order/list/');

    return result.fold(
          (error) => Result.error(error),
          (data) {
        final orders = data
            .map((item) => OrderModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return Result.ok(orders);
      },
    );
  }
}

import 'package:airtravel_app/core/client.dart';
import 'package:airtravel_app/core/result.dart';
import 'package:airtravel_app/data/model/payment_model.dart';

class PaymentRepository {
  final ApiClient _apiClient;

  PaymentRepository(this._apiClient);

  Future<Result<List<PaymentModel>>> fetchPayment() async {
    final result = await _apiClient.get<dynamic>('/payments/payment/list/');

    return result.fold(
          (error) => Result.error(error),
          (data) {
        final list = (data as List)
            .map((item) => PaymentModel.fromJson(item as Map<String, dynamic>))
            .toList();
        return Result.ok(list);
      },
    );
  }

}

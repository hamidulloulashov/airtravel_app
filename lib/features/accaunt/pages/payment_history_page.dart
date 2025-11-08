import 'package:airtravel_app/core/utils/status.dart';
import 'package:airtravel_app/features/accaunt/managers/paymentBloc/payment_bloc.dart';
import 'package:airtravel_app/features/accaunt/managers/paymentBloc/payment_state.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentHistoryPage extends StatelessWidget {
  const PaymentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'To’lovlar Tarixi',
        showThemeToggle: true,
      ),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if(state.status == Status.error){
            return Center(child: Text("xatolik yuz berdi aka"),);
          }
          if(state.status == Status.loading){
            return Center(child: CircularProgressIndicator(),);
          }
          if(state.status == Status.success) {
            return Column(
              children: [
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}

import 'package:airtravel_app/core/client.dart';
import 'package:airtravel_app/data/repositories/help_center_repository.dart';
import 'package:airtravel_app/features/accaunt/managers/helpCenterBloc/help_center_bloc.dart';
import 'package:airtravel_app/features/accaunt/managers/helpCenterBloc/help_center_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FaqQuestionWidget extends StatelessWidget {
  const FaqQuestionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HelpCenterBloc(
        helpCenterRepo: HelpCenterRepository(
          client: ApiClient(),
        ),
      ),
      child: BlocBuilder<HelpCenterBloc, HelpCenterState>(
        builder: (context, state) => Column(
          children: [
            ...List.generate(state.faqs.length, (index) {
              return Text(state.faqs[index].answer);
            })
          ],
        ),
      ),
    );
  }
}

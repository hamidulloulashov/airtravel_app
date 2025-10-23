import 'package:airtravel_app/core/client.dart';
import 'package:airtravel_app/data/repositories/help_center_repository.dart';
import 'package:airtravel_app/features/accaunt/managers/helpCenterBloc/help_center_bloc.dart';
import 'package:airtravel_app/features/accaunt/managers/helpCenterBloc/help_center_state.dart';
import 'package:airtravel_app/features/accaunt/widgets/help_center_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_icons.dart';

class AloqaContent extends StatelessWidget {
  const AloqaContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HelpCenterBloc(
        helpCenterRepo: HelpCenterRepository(client: ApiClient()),
      ),
      child: BlocBuilder<HelpCenterBloc, HelpCenterState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              spacing: 24.h,
              children: [
                ...List.generate(state.contacts.length, (index) {
                  return HelpButtonWidget(
                      icon: state.contacts[index].icon,
                      label: state.contacts[index].title,
                      onTap: () {});
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}

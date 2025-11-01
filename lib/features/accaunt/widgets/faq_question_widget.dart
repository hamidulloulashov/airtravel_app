import 'package:airtravel_app/core/client.dart';
import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/core/utils/status.dart';
import 'package:airtravel_app/data/repositories/help_center_repository.dart';
import 'package:airtravel_app/features/accaunt/managers/helpCenterBloc/help_center_bloc.dart';
import 'package:airtravel_app/features/accaunt/managers/helpCenterBloc/help_center_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FaqQuestionWidget extends StatelessWidget {
  const FaqQuestionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const Color questionColor = AppColors.containerGreen;
    return BlocProvider(
      create: (context) => HelpCenterBloc(
        helpCenterRepo: HelpCenterRepository(
          client: ApiClient(),
        ),
      )..add(FaqLoading()),
      child: BlocBuilder<HelpCenterBloc, HelpCenterState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final faq = state.faqs;
          return Column(
            spacing: 24.h,
            children: [
              SizedBox(),
              ...List.generate(faq.length, (index) {
                final item = faq[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24,),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.borderGrey,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.borderGrey,
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text(
                          item.question,
                          style: const TextStyle(
                            color: questionColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        iconColor: questionColor,
                        collapsedIconColor: questionColor,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsetsGeometry.symmetric(horizontal: 24, vertical: 24),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item.answer,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
            ],
          );
        },
      ),
    );
  }
}
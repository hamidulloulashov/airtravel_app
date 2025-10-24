import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_icons.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leadingIcon;
  final String title;
  final List<Widget>? actions;

  const AppBarWidget({
    super.key,
    this.leadingIcon,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 75,
      leading: Center(
        child: leadingIcon ??
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: SvgPicture.asset(
                AppIcons.arrowLeft,
                width: 28.w,
                height: 28.h,
                fit: BoxFit.scaleDown,
              ),
            ),
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.grey),
      ),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

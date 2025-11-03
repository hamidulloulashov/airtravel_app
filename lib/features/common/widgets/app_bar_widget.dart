import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/features/common/managers/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/app_icons.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leadingIcon;
  final String? title;
  final List<Widget>? actions;
  final bool showThemeToggle;

  const AppBarWidget({
    super.key,
    this.leadingIcon,
    this.title,
    this.actions,
    this.showThemeToggle = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 75,
      leading: leadingIcon != null
          ? Center(child: leadingIcon)
          : Center(
              child: IconButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
                icon: SvgPicture.asset(
                  AppIcons.arrowLeft,
                  width: 28.w,
                  height: 28.h,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).appBarTheme.foregroundColor ?? Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
      title: title != null
          ? Text(
              title!,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).appBarTheme.foregroundColor ?? AppColors.grey,
              ),
            )
          : null,
      actions: [
        if (actions != null) ...actions!,
        if (showThemeToggle)
          IconButton(
            onPressed: () {
              context.read<ThemeBloc>().add(ThemeToggled());
            },
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              size: 24.sp,
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
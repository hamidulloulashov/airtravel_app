import 'package:airtravel_app/core/routing/routes.dart';
import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/core/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationBarApp extends StatelessWidget {
  const BottomNavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return Container(
      width: double.infinity,
      height: 86.h,
      decoration:  BoxDecoration(color: AppColors.primary,
          border: Border(top: BorderSide(color: AppColors.primary)) ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navItem(
            context,
            icon: AppIcons.home,
            label: "Asosiy",
            route: Routes.home,
            isSelected: location == Routes.home,
          ),
          _navItem(
            context,
            icon: AppIcons.ticket,
            label: "Paketlar",
            route: Routes.profile,
            isSelected: location == Routes.profile,
          ),
          _navItem(
            context,
            icon: AppIcons.call,
            label: "Aloqa",
            route: Routes.profile,
            isSelected: location == Routes.profile,
          ),
          _navItem(
            context,
            icon: AppIcons.heart,
            label: "Sevimlilar",
            route: Routes.like,
            isSelected: location == Routes.like,
          ),
          _navItem(
            context,
            icon: AppIcons.profile,
            label: "Profile",
            route: Routes.profile,
            isSelected: location == Routes.profile,
          ),
        ],
      ),
    );
  }
  Widget _navItem(
      BuildContext context, {
        required String icon,
        required String label,
        required String route,
        required bool isSelected,
      }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {
        context.go(route);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 24.w,
            height: 24.h,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              isSelected ? AppColors.containerGreen : AppColors.grey,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: isSelected ? AppColors.containerGreen : AppColors.grey,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
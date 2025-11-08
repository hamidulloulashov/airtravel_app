import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  String collect = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
      'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.'
      'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

  String data = 'Magna etiam tempor orci eu lobortis elementum nibh. '
      'Vulputate enim nulla aliquet porttitor lacus. Orci sagittis eu volutpat odio. '
      'Cras semper auctor neque vitae tempus quam pellentesque nec. '
      'Non quam lacus suspendisse faucibus interdum posuere lorem ipsum dolor. '
      'Commodo elit at imperdiet dui. Nisi vitae suscipit tellus mauris a diam. '
      'Erat pellentesque adipiscing commodo elit at imperdiet dui. '
      'Mi ipsum faucibus vitae aliquet nec ullamcorper. '
      'Pellentesque pulvinar pellentesque habitant morbi tristique senectus et.';

  String disclosure =
      'Consequat id porta nibh venenatis cras sed. '
      'Ipsum nunc aliquet bibendum enim facilisis gravida neque. '
      'Nibh tellus molestie nunc non blandit massa. '
      'Quam pellentesque nec nam aliquam sem et tortor consequat id. '
      'Faucibus vitae aliquet nec ullamcorper sit amet risus. '
      'Nunc consequat interdum varius sit amet. '
      'Eget magna fermentum iaculis eu non diam phasellus vestibulum. '
      'Pulvinar pellentesque habitant morbi tristique senectus et. '
      'Lorem donec massa sapien faucibus et molestie. '
      'Massa tempor nec feugiat nisl pretium fusce id. '
      'Lacinia at quis risus sed vulputate odio. '
      'Integer vitae justo eget magna fermentum iaculis. '
      'Eget gravida cum sociis natoque penatibus et magnis.';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBarWidget(title: 'Maxfiylik Siyosati ', showThemeToggle: true,),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 24.w, vertical: 24.h),
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          spacing: 24.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1. Types of Data We Collect',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color:  isDark ? AppColors.grenWhite : AppColors.grey,),
            ),
            Text(
              collect,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: isDark ? AppColors.grenWhite : AppColors.grey,
              ),
            ),
            Text(
              '2. Use of Your Personal Data',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color:  isDark ? AppColors.grenWhite : AppColors.grey,),
            ),
            Text(
              data,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color:  isDark ? AppColors.grenWhite : AppColors.grey,
              ),
            ),
            Text(
              '3. Disclosure of Your Personal Data',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color:  isDark ? AppColors.grenWhite : AppColors.grey,),
            ),
            Text(
              disclosure,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color:  isDark ? AppColors.grenWhite : AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

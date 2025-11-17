import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/core/utils/app_icons.dart';
import 'package:airtravel_app/data/model/accommodation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'feature_icon_widget.dart';

class AmenitiesWidget extends StatelessWidget {
  const AmenitiesWidget({
    super.key,
    required this.product,
    required this.isDark,
  });

  final AccommodationModel product;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 20,
        children: [
          Column(
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.containerGrey,
                ),
                child: SvgPicture.asset(
                  AppIcons.cilRoom,
                  width: 27.w,
                  height: 27.h,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                '1 Yotoqxona',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
          ...List.generate(
            product.features.length,
            (index) {
              final features = product.features;
              return SizedBox(
                child: Column(
                  spacing: 5.h,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.containerGreen,
                      ),
                      child: FeatureIconWidget(
                        url: features[index].icon,
                        width: 20.w,
                        height: 19.h,
                      ),
                    ),
                    Text(
                      features[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: isDark ? AppColors.grenWhite : AppColors.grey,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

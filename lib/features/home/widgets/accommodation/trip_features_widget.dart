import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../data/model/detail_model.dart';
import 'feature_icon_widget.dart';

class TripFeaturesWidget extends StatelessWidget {
  final DetailModel trip;
  final bool isDark;

  const TripFeaturesWidget({
    super.key,
    required this.trip,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> dayFeatures = trip.destinations.map((d) {
      return Padding(
        padding: EdgeInsets.only(right: 15.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: AppColors.containerGreen,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.white),
              SizedBox(width: 5.w),
              Text(
                '${d.duration} ${d.city.split(" ").first}',
                style: TextStyle(fontSize: 12.sp, color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }).toList();

    // Core features
    final List<Widget> coreFeatureWidgets = trip.coreFeatures.map((f) {
      return Padding(
        padding: EdgeInsets.only(right: 15.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FeatureIconWidget(
              url: f.icon,
              width: 18.w,
              height: 18.h,
            ),
            SizedBox(width: 5.w),
            Text(
              f.title.split(' ').first,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.containerGreen,
              ),
            ),
          ],
        ),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: dayFeatures),
        ),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 15.w,
          runSpacing: 5.h,
          children: coreFeatureWidgets,
        ),
      ],
    );
  }
}

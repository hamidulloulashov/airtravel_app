import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyTimelineWidget extends StatelessWidget {
  final List days;
  final bool isDark;

  const DailyTimelineWidget({
    super.key,
    required this.days,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(days.length, (index) {
        final day = days[index];
        final isLast = index == days.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chapdagi indikator
            Column(
              children: [
                Container(
                  width: 14.w,
                  height: 14.w,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2.w,
                    height: 60.h,
                    color: Colors.green.withOpacity(0.4),
                  ),
              ],
            ),
            SizedBox(width: 10.w),
            // O‘ngdagi matn
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 15.h),
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Day ${day.day}: ${day.title}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      day.description,
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

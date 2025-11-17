import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/core/utils/app_icons.dart';
import 'package:airtravel_app/core/utils/status.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import 'package:airtravel_app/features/home/pages/accommodation_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../data/model/detail_model.dart';
import '../managers/accommodationBloc/accommodation_bloc.dart';
import '../managers/accommodationBloc/accommodation_state.dart';

class TravelDetail extends StatefulWidget {
  final int tripId;

  const TravelDetail({super.key, required this.tripId});

  @override
  State<TravelDetail> createState() => _TravelDetailState();
}

class _TravelDetailState extends State<TravelDetail> {
  @override
  void initState() {
    super.initState();
    context.read<AccommodationBloc>().add(FetchUmraTripDetail(widget.tripId));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBarWidget(showThemeToggle: true),
      body: BlocBuilder<AccommodationBloc, AccommodationState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == Status.error) {
            return Center(child: Text(state.errorMessage ?? "Ma'lumotni yuklashda xatolik"));
          }
          final trip = state.umraTripDetail;
          if (trip == null) {
            return const Center(child: Text("Ma'lumot topilmadi"));
          }
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final minPrice =
              trip.plans.isNotEmpty ? trip.plans.map((p) => p.discountedPrice).reduce((a, b) => a < b ? a : b) : 0;

          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 80.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 250.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(trip.pictures.first.picture),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          Card(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 6.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(trip.title, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                                  Text(
                                    trip.description.split('\n').first,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              spacing: 10.w,
                              children: [
                                ...List.generate(trip.destinations.length, (index) {
                                  return Container(
                                    height: 25.h,
                                    decoration: BoxDecoration(
                                        color: isDark ? AppColors.containerBlack : AppColors.grenWhite,
                                        borderRadius: BorderRadius.circular(11.r),
                                        border: Border.all(color: AppColors.containerGreen)),
                                    child: Row(
                                      spacing: 2,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(2),
                                          width: 20.w,
                                          height: 20.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.containerGreen,
                                          ),
                                          child: SvgPicture.asset(AppIcons.calendar),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${trip.destinations[index].duration}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp,
                                                color: AppColors.containerGreen,
                                              ),
                                            ),
                                            Text(
                                              "Kun",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 4.sp,
                                                color: AppColors.containerGreen,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          trip.destinations[index].city,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: isDark ? AppColors.white : AppColors.containerGreen,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                          SizedBox(height: 21.h),
                          Text(
                            'Sayohat tarkibi',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: isDark ? AppColors.grenWhite : AppColors.containerBlack,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              spacing: 10.w,
                              children: [
                                ...List.generate(trip.coreFeatures.length, (index) {
                                  return Container(
                                    height: 25.h,
                                    decoration: BoxDecoration(
                                        color: isDark ? AppColors.containerBlack : AppColors.grenWhite,
                                        borderRadius: BorderRadius.circular(11.r),
                                        border: Border.all(color: AppColors.containerGreen)),
                                    child: Row(
                                      spacing: 2,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(2),
                                          width: 20.w,
                                          height: 20.h,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.containerGreen,
                                          ),
                                          child: SvgPicture.asset(AppIcons.tick),
                                        ),
                                        Text(
                                          trip.coreFeatures[index].title,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: isDark ? AppColors.white : AppColors.containerGreen,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            'Sayohat kundaligi',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: isDark ? AppColors.grenWhite : AppColors.containerBlack,
                            ),
                          ),
                          SizedBox(height: 15.h),
                          SizedBox(
                            width: 397.w,
                            child: Container(
                              child: Column(
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      spacing: 9.w,
                                      children: [
                                        ...List.generate(trip.days.length, (index) {
                                          final day = trip.days;
                                          return Container(
                                            height: 59.h,
                                            padding: EdgeInsetsGeometry.symmetric(horizontal: 14.w, vertical: 6.h),
                                            decoration: BoxDecoration(
                                                color: AppColors.containerGrey,
                                                borderRadius: BorderRadiusGeometry.circular(10.r)),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${day[index].dayNumber} Kun",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15.sp,
                                                    color: isDark ? AppColors.containerBlack : AppColors.containerBlack,
                                                  ),
                                                ),
                                                Text(
                                                  day[index].date,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15.sp,
                                                    color: isDark ? AppColors.containerBlack : AppColors.containerBlack,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                  // Column(
                                  //   children: [
                                  //     ...List.generate(trip.pictures.length, (index) {
                                  //       return Container(
                                  //         width: 321.w,
                                  //         height: 125.h,
                                  //         padding: EdgeInsetsGeometry.symmetric(
                                  //           vertical: 9.h,
                                  //           horizontal: 22.w,
                                  //         ),
                                  //         decoration: BoxDecoration(
                                  //           borderRadius: BorderRadius.only(
                                  //               bottomRight: Radius.circular(20.r),
                                  //               bottomLeft: Radius.circular(5.r),
                                  //               topLeft: Radius.circular(20.r),
                                  //               topRight: Radius.circular(5.r)),
                                  //           border: Border.all(
                                  //             color: AppColors.containerGreyDark,
                                  //           ),
                                  //         ),
                                  //         child: Column(
                                  //           children: [
                                  //             Row(
                                  //               children: [
                                  //                 Text(
                                  //                   'Uchish',
                                  //                   style: TextStyle(
                                  //                     fontWeight: FontWeight.w700,
                                  //                     fontSize: 14.sp,
                                  //                     color: isDark ? AppColors.grenWhite : AppColors.containerBlack,
                                  //                   ),
                                  //                 ),
                                  //               ],
                                  //             )
                                  //           ],
                                  //         ),
                                  //       );
                                  //     })
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text("Tariflar", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700)),
                          SizedBox(height: 15.h),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...List.generate(
                                  trip.plans.length,
                                  (index) {
                                    final tariff = trip.plans;
                                    return Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          width: 183.w,
                                          height: 263.h,
                                          decoration: BoxDecoration(
                                            color: AppColors.succesGren,
                                            border: Border.all(
                                              color: AppColors.cardYellow,
                                              width: 3.sp,
                                            ),
                                            borderRadius: BorderRadius.circular(16.r),
                                          ),
                                        ),
                                        Positioned(
                                          top: -15.h,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                                            height: 29.h,
                                            decoration: BoxDecoration(
                                              color: isDark ? AppColors.containerBlack : AppColors.grenWhite,
                                              borderRadius: BorderRadius.circular(10.r),
                                              border: Border.all(color: AppColors.containerGreen),
                                            ),
                                            child: Text(
                                              tariff[index].type.title,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.containerGreen,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );

                                  },
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 100.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          "Jami qiymat",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "$minPrice\$",
                          style:
                              TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700, color: AppColors.containerGreen),
                        ),
                      ]),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.shopping_bag_outlined, color: AppColors.grenWhite),
                          label: Text("Buyurtma berish", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.containerGreen,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

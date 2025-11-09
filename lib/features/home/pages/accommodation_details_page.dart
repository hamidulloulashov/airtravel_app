import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/core/utils/app_icons.dart';
import 'package:airtravel_app/core/utils/status.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import 'package:airtravel_app/features/common/widgets/bottom_navigation_bar_app.dart';
import 'package:airtravel_app/features/home/managers/accommodationBloc/accommodation_bloc.dart';
import 'package:airtravel_app/features/home/managers/accommodationBloc/accommodation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';

import '../widgets/accommodation/feature_icon_widget.dart';

class AccommodationDetailsPage extends StatefulWidget {
  final int id;

  const AccommodationDetailsPage({super.key, required this.id});

  @override
  State<AccommodationDetailsPage> createState() => _AccommodationDetailsPageState();
}

class _AccommodationDetailsPageState extends State<AccommodationDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<AccommodationBloc>().add(FetchAccommodation(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBarWidget(
        showThemeToggle: true,
      ),
      bottomNavigationBar: BottomNavigationBarApp(),
      body: BlocBuilder<AccommodationBloc, AccommodationState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.loading:
              return Center(child: CircularProgressIndicator());
            case Status.error:
              return Center(child: Text("Xatolik yuz berdi"));
            case Status.success:
              if (state.accommodation == null) {
                return Center(child: Text("Ma'lumot topilmadi"));
              }
              final product = state.accommodation!;

              return Column(
                spacing: 21.h,
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 14.w),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        if (product.features.isNotEmpty)
                          SingleChildScrollView(
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
                                            padding: EdgeInsetsGeometry.symmetric(horizontal: 5, vertical: 6),
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
                          ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 398.w,
                          height: 147.h,
                          child: Card(
                            color: isDark ? AppColors.grey : AppColors.grenWhite,
                            child: Padding(
                              padding: EdgeInsetsGeometry.symmetric(horizontal: 9.w, vertical: 6.h),
                              child: Column(
                                spacing: 6.h,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: isDark ? AppColors.grenWhite : AppColors.grey,
                                    ),
                                  ),
                                  Row(
                                    spacing: 5,
                                    children: [
                                      SvgPicture.asset(
                                        AppIcons.star,
                                        width: 12.w,
                                        height: 12.h,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        product.rating,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                          color: isDark ? AppColors.grenWhite : AppColors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    maxLines: 4,
                                    product.longDescription,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                      color: isDark ? AppColors.grenWhite : AppColors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    spacing: 15.h,
                    children: [
                      Text(
                        "Mehmonxona joylashuvi",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: isDark ? AppColors.grenWhite : AppColors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 398.w,
                        height: 198.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: FlutterMap(
                            options: MapOptions(
                              initialCenter: LatLng(
                                double.tryParse(product.latitude) ?? 41.311081,
                                double.tryParse(product.longitude) ?? 69.240562,
                              ),
                              initialZoom: 14,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.example.airtravel_app',
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    width: 40.w,
                                    height: 40.h,
                                    point: LatLng(
                                      double.tryParse(product.latitude) ?? 41.311081,
                                      double.tryParse(product.longitude) ?? 69.240562,
                                    ),
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              );
            default:
              return const Center(child: Text("Ma'lumot yuklanmoqda..."));
          }
        },
      ),
    );
  }
}

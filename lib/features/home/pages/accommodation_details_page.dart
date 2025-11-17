import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/core/utils/app_icons.dart';
import 'package:airtravel_app/core/utils/status.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import 'package:airtravel_app/features/common/widgets/bottom_navigation_bar_app.dart';
import 'package:airtravel_app/features/home/managers/accommodationBloc/accommodation_bloc.dart';
import 'package:airtravel_app/features/home/managers/accommodationBloc/accommodation_state.dart';
import 'package:airtravel_app/features/home/widgets/accommodation/amenities_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';

import '../widgets/accommodation/feature_icon_widget.dart';
import '../widgets/accommodation/image_gallery_widget.dart';

class AccommodationDetailsPage extends StatefulWidget {
  final int id;

  const AccommodationDetailsPage({super.key, required this.id});

  @override
  State<AccommodationDetailsPage> createState() => _AccommodationDetailsPageState();
}

class _AccommodationDetailsPageState extends State<AccommodationDetailsPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<AccommodationBloc>().add(FetchAccommodation(widget.id));
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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

              final List<String> imageUrls = product.pictures.map((p) => p.picture).toList();

              return SingleChildScrollView(
                child: Column(
                  children: [
                    ImageGalleryWidget(pictures: imageUrls),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          if (product.features.isNotEmpty) AmenitiesWidget(product: product, isDark: isDark),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 398.w,
                            height: 147.h,
                            child: Card(
                              color: isDark ? AppColors.grey : AppColors.grenWhite,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 6.h),
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
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mehmonxona joylashuvi",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? AppColors.grenWhite : AppColors.grey,
                                ),
                              ),
                              SizedBox(height: 15.h),
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
                                        urlTemplate: product.embeddedLink,
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
                          SizedBox(height: 20),
                          TabBar(
                            controller: _tabController,
                            indicatorSize: TabBarIndicatorSize.label,
                            labelColor: AppColors.containerGreen,
                            unselectedLabelColor: AppColors.grey,
                            indicatorColor: AppColors.containerGreen,
                            tabs: [
                              Tab(
                                child: Text(
                                  "Battfsil ma'lumot",
                                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Xususiyatlar",
                                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Bolalar va qo'shimcha xonalar",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 400.h,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                SingleChildScrollView(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.city!.title ?? "",
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                          color: isDark ? AppColors.grenWhite : AppColors.grey,
                                        ),
                                      ),
                                      Text(
                                        product.country,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: isDark ? AppColors.grenWhite : AppColors.grey,
                                        ),
                                      ),
                                      Text(
                                        product.landmark,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: isDark ? AppColors.grenWhite : AppColors.grey,
                                        ),
                                      ),
                                      Text(
                                        product.address,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: isDark ? AppColors.grenWhite : AppColors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(children: [
                                  SizedBox(height: 27.h,),
                                  Card(
                                    color: isDark ? AppColors.grey : AppColors.grenWhite,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 6.h),
                                      child: Column(
                                        spacing: 6.h,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Mashxur xususiyatlar",
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700,
                                              color: isDark ? AppColors.grenWhite : AppColors.grey,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 117.h,
                                            width: 398.w,
                                            child: Wrap(
                                              spacing: 10.w,
                                              runSpacing: 10.h,
                                              children: [
                                                ...List.generate(product.features.length, (index){
                                                  final feature = product.features[index];
                                                  if (feature.isPopular == true) {
                                                    return Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      spacing: 8,
                                                      children: [
                                                        FeatureIconWidget(
                                                          url: feature.icon,
                                                          width: 20.w,
                                                          height: 19.h,
                                                        ),
                                                        Text(
                                                          feature.title,
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w700,
                                                            color: isDark ? AppColors.grenWhite : AppColors.grey,
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                  return SizedBox.shrink();
                                                }),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                                Center(child: Text("Bolalar va qo'shimcha xonalar topilmadi!")),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            default:
              return const Center(child: Text("Malumot yuklanmoqda"));
          }
        },
      ),
    );
  }
}

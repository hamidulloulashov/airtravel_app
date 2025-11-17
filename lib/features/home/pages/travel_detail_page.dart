import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/core/utils/status.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import 'package:airtravel_app/features/home/pages/accommodation_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/model/detail_model.dart';
import '../managers/accommodationBloc/accommodation_bloc.dart';
import '../managers/accommodationBloc/accommodation_state.dart';
import '../widgets/accommodation/feature_icon_widget.dart';

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
      appBar: const AppBarWidget(
        showThemeToggle: true,
      ),
      body: BlocBuilder<AccommodationBloc, AccommodationState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.error:
              return Center(child: Text(state.errorMessage ?? "Ma'lumotni yuklashda xatolik"));
            case Status.success:
              final trip = state.umraTripDetail;
              if (trip == null) {
                return const Center(child: Text("Ma'lumot topilmadi"));
              }
              final minPrice =
                  trip.plans.isNotEmpty ? trip.plans.map((p) => p.discountedPrice).reduce((a, b) => a < b ? a : b) : 0;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildImageGallery(trip.pictures.first.picture, context),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h),
                                  SizedBox(
                                    width: 398.w,
                                    child: Card(
                                      child: Padding(
                                        padding: EdgeInsetsGeometry.symmetric(horizontal: 9.w, vertical: 6.h),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          spacing: 2.h,
                                          children: [
                                            Text(trip.title,
                                                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                                            Text(trip.description.split('\n').first,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 12.sp, color: AppColors.grey)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  _buildTripFeatures(trip, isDark),
                                  SizedBox(height: 20.h),
                                  Text("Sayohat kundaligi",
                                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700)),
                                  SizedBox(height: 15.h),
                                  DailyTimelineWidget(days: trip.days, isDark: isDark),
                                  SizedBox(height: 20.h),
                                  Text("Tariflar", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700)),
                                  SizedBox(height: 15.h),
                                  _buildTariffs(trip.plans),
                                  SizedBox(height: 20.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: _buildFooter(minPrice.toString()),
                        ),
                      ],
                    ),
                  ],
                ),
              );

            default:
              return const Center(child: Text("Ma'lumot yuklanmoqda"));
          }
        },
      ),
    );
  }

  Widget _buildImageGallery(String url, BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTripFeatures(DetailModel trip, bool isDark) {
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
              Text('${d.duration} ${d.city.split(" ").first}', style: TextStyle(fontSize: 12.sp, color: Colors.white)),
            ],
          ),
        ),
      );
    }).toList();
    final List<Widget> coreFeatureWidgets = trip.coreFeatures.map((f) {
      return Padding(
        padding: EdgeInsets.only(right: 15.w),
        child: Row(
          children: [
            FeatureIconWidget(
              url: f.icon,
              width: 18.w,
              height: 18.h,
            ),
            SizedBox(width: 5.w),
            Text(f.title.split(' ').first, style: TextStyle(fontSize: 12.sp, color: AppColors.containerGreen)),
          ],
        ),
      );
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: dayFeatures),
        SizedBox(height: 10.h),
        Wrap(spacing: 15.w, runSpacing: 5.h, children: coreFeatureWidgets),
      ],
    );
  }

  Widget _buildTariffs(List<UmraTariff> tariffs) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 15.w,
        children: tariffs.map((tariff) {
          return TariffCardWidget(tariff: tariff);
        }).toList(),
      ),
    );
  }

  Widget _buildFooter(String minPrice) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Narxidan boshlab", style: TextStyle(fontSize: 10.sp, color: AppColors.grey)),
              Text("$minPrice\$", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.shopping_bag_outlined, size: 20, color: Colors.white),
              label: Text("Buyurtma berish", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.containerGreen,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TariffCardWidget extends StatelessWidget {
  final UmraTariff tariff; // To'g'ri model

  const TariffCardWidget({super.key, required this.tariff});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170.w,
      decoration: BoxDecoration(
        color: AppColors.containerGreen,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(tariff.type.title.split(' ').first,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 2.h),
          Text("${tariff.discountedPrice}\$", style: TextStyle(fontSize: 14.sp, color: Colors.white)),
          SizedBox(height: 8.h),
          ...tariff.features
              .map((feature) => Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outline, size: 14, color: Colors.white70),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: Text(feature.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 10.sp, color: Colors.white70)),
                        ),
                      ],
                    ),
                  ))
              .toList(),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}

class DailyTimelineWidget extends StatelessWidget {
  final List<PackageDay> days;
  final bool isDark;

  const DailyTimelineWidget({super.key, required this.days, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> staticSteps = [
      {'title': 'Uchish', 'time': '8:30 am', 'description': 'Toshkentdan Madinaga parvoz', 'isHotel': false},
      {
        'title': 'Mehmonxonada',
        'time': '5:30 pm',
        'description': 'Madina Al Munavvara. Mehmonxona nomi',
        'isHotel': true,
        'accommodationId': 101
      },
      {
        'title': 'Ziyoratgoh',
        'time': '8:30 am',
        'description': 'Qubo masjidi. Madina boʻylab ekskursiya',
        'isHotel': false
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: days.map((day) {
        final dayIndex = day.dayNumber;
        final isLast = dayIndex == days.length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.containerGreen,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Text("${dayIndex}-Kun",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp)),
            ),
            ...staticSteps.map((step) {
              final isHotel = step['isHotel'] as bool;

              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.containerGreen,
                            ),
                            child: Center(
                              child: isHotel
                                  ? const Icon(Icons.hotel, size: 16, color: Colors.white)
                                  : const Icon(Icons.flight, size: 16, color: Colors.white),
                            ),
                          ),
                          if (!isLast) Container(width: 2.w, height: 70.h, color: AppColors.containerGreen),
                        ],
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${step['title']} - ${step['time']}",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? AppColors.grenWhite : AppColors.grey)),
                            SizedBox(height: 5.h),
                            Text(step['description'] as String,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: isDark ? AppColors.grenWhite.withOpacity(0.8) : AppColors.grey)),
                            if (isHotel)
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AccommodationDetailsPage(id: step['accommodationId'] as int),
                                      ));
                                },
                                icon: const Icon(Icons.hotel, size: 16, color: AppColors.containerGreen),
                                label: Text("Mehmonxonani ko'rish", style: TextStyle(color: AppColors.containerGreen)),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              );
            }).toList(),
            SizedBox(height: 15.h),
            Divider(color: AppColors.grey.withOpacity(0.3)),
          ],
        );
      }).toList(),
    );
  }
}

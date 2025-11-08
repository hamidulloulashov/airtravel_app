import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:airtravel_app/core/utils/app_icons.dart';
import 'package:airtravel_app/core/utils/status.dart';
import 'package:airtravel_app/features/accaunt/managers/orderBloc/order_bloc.dart';
import 'package:airtravel_app/features/accaunt/managers/orderBloc/order_state.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  String formatDate(String isoString) {
    final dateTime = DateTime.parse(isoString).toLocal();
    final dateFormatter = DateFormat('MMM dd, yyyy', 'en_US');
    final formattedDate = dateFormatter.format(dateTime);

    final timeFormatter = DateFormat('hh:mm a', 'en_US');
    final formattedTime = timeFormatter.format(dateTime);

    return "$formattedDate | $formattedTime";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        if (state.status == Status.loading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.status == Status.error) {
          return Scaffold(
            appBar: AppBarWidget(
              title: 'Buyurtmalar Tarixi',
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'akkauntga tokensiz kirdiz aka',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.sp),
                )
              ],
            ),
          );
        }
        if (state.status == Status.success) {
          final orders = state.orders;
          return Scaffold(
            appBar: AppBarWidget(
              showThemeToggle: true,
              title: 'Buyurtmalar Tarixi',
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      AppIcons.search,
                      width: 28.w,
                      height: 28.h,
                      fit: BoxFit.scaleDown,
                      colorFilter: ColorFilter.mode(
                        isDark ? AppColors.grenWhite : AppColors.grey,
                        BlendMode.srcIn,
                      ),
                    ))
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<OrderBloc>().add(OrdersLoading());
              },
              child: ListView.builder(
                padding: EdgeInsets.all(10.w),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: isDark ? AppColors.grey : AppColors.containerGrey,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.network(
                            order.package.picture,
                            width: 133.w,
                            height: 133.h,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 133.w,
                                height: 134.h,
                                color: AppColors.containerGrey,
                                child: Icon(Icons.broken_image, size: 50),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.package.title,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color:  isDark ? AppColors.grenWhite : AppColors.containerBlack,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                'Qayerdan',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppColors.textGrey,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                children: [
                                  Text(
                                    'Qayerga',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: AppColors.textGrey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "${order.priceTotal}\$",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp,
                                  color:  isDark ? AppColors.grenWhite : AppColors.containerBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formatDate(order.created),
                              style: TextStyle(
                                color: isDark ? AppColors.grenWhite : AppColors.grey,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              order.fromCity,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: isDark ? AppColors.grenWhite : AppColors.containerBlack,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              order.toCity,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color:  isDark ? AppColors.grenWhite : AppColors.containerBlack,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5.h),
                            Container(
                              height: 19.h,
                              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11.r),
                                border: Border.all(color: AppColors.containerGreen),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 15.w,
                                    height: 15.h,
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.containerGreen
                                    ),
                                    child: SvgPicture.asset(
                                      AppIcons.profile,
                                      colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                                      width: 12.w,
                                      height: 12.h,
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Text(
                                    '${order.id} kishi uchun',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.containerGreen,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                        SizedBox(width: 12.w),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}

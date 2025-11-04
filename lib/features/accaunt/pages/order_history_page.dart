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
        if (state.status == Status.loading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.status == Status.error) {
          return Center(child: Text("Xatolik yuz berdi!"));
        }
        if (state.status == Status.success) {
          final orders = state.orders;
          return Scaffold(
            appBar: AppBarWidget(
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
                        AppColors.grey,
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
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.containerGrey,
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
                                height: 133.h,
                                color: Colors.grey[300],
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      order.package.title,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.containerBlack,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    formatDate(order.created),
                                    style: TextStyle(
                                      color: AppColors.grey,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                children: [
                                  Text(
                                    'Qayerdan ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: AppColors.textGrey,
                                    ),
                                  ),
                                  Spacer(),
                                  Expanded(
                                    child: Text(
                                      order.fromCity,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.containerBlack,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                children: [
                                  Text(
                                    'Qayerga ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: AppColors.textGrey,
                                    ),
                                  ),
                                  Spacer(),
                                  Expanded(
                                    child: Text(
                                      order.toCity,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.containerBlack,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${order.priceTotal}\$",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.sp,
                                      color: AppColors.containerBlack,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(11.r),
                                      border: Border.all(color: AppColors.containerGreen),
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppIcons.profile,
                                          colorFilter: ColorFilter.mode(AppColors.containerGreen, BlendMode.srcIn),
                                          width: 12.w,
                                          height: 12.h,
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
                              ),
                            ],
                          ),
                        )
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

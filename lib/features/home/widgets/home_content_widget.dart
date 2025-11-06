import 'package:airtravel_app/data/model/home_model.dart';
import 'package:airtravel_app/features/home/widgets/banner_carudel_widget.dart';
import 'package:airtravel_app/features/home/widgets/home_eror_widget.dart';
import 'package:airtravel_app/features/home/widgets/home_timer_widget.dart';
import 'package:airtravel_app/features/home/widgets/package_state_handle_widget.dart';
import 'package:airtravel_app/features/home/widgets/popular_places_carusel.dart';
import 'package:flutter/material.dart';

class HomeContentWidget extends StatelessWidget {
  final String? errorMessage;
  final List<PopularPlace>? popularPlaces;
  final bool isLoadingPlaces;
  final int hours;
  final int minutes;
  final int seconds;
  final Function(PopularPlace) onBannerTapped;
  final Function(PopularPlace) onPlaceSelected;

  const HomeContentWidget({
    super.key,
    this.errorMessage,
    this.popularPlaces,
    required this.isLoadingPlaces,
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.onBannerTapped,
    required this.onPlaceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: HomeErrorWidget(errorMessage: errorMessage),
        ),
        
        SliverToBoxAdapter(
          child: BannerCarousel(
            places: popularPlaces,
            isLoading: isLoadingPlaces,
            onBannerTapped: onBannerTapped,
          ),
        ),
        
        const SliverToBoxAdapter(
          child: SizedBox(height: 24),
        ),
        
        SliverToBoxAdapter(
          child: PopularPlacesCarousel(
            places: popularPlaces,
            isLoading: isLoadingPlaces,
            onPlaceSelected: onPlaceSelected,
          ),
        ),
        
        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
        
        SliverToBoxAdapter(
          child: HomeTimerWidget(
            hours: hours,
            minutes: minutes,
            seconds: seconds,
          ),
        ),
        
        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
        
        const PackageStateHandlerWidget(),
        
        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
      ],
    );
  }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:airtravel_app/data/model/home_model.dart';

class BannerCarousel extends StatefulWidget {
  final List<PopularPlace>? places;
  final bool isLoading;
  final Function(PopularPlace)? onBannerTapped;

  const BannerCarousel({
    super.key,
    required this.places,
    required this.isLoading,
    this.onBannerTapped,
  });

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  late PageController _pageController;
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 1000);

    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted || widget.places == null || widget.places!.isEmpty) return;

      _pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return Container(
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (widget.places == null || widget.places!.isEmpty) {
      return const SizedBox.shrink();
    }

    final places = widget.places!;

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index % places.length;
              });
            },
            itemBuilder: (context, index) {
              final place = places[index % places.length];
              return _buildBannerCard(context, place);
            },
          ),
        ),
        const SizedBox(height: 12),
        _buildPageIndicator(places.length),
      ],
    );
  }

  Widget _buildBannerCard(BuildContext context, PopularPlace place) {
    return GestureDetector(
      onTap: () => widget.onBannerTapped?.call(place),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: place.picture,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[300],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image_not_supported, size: 48, color: Colors.grey[500]),
                      const SizedBox(height: 8),
                      Text(
                        'Rasm yuklanmadi',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _currentPage == index ? 20 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _currentPage == index
                ? const Color(0xFF4CAF50)
                : Colors.grey[300],
          ),
        ),
      ),
    );
  }
}


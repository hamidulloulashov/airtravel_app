import 'package:airtravel_app/data/model/home_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PopularPlacesCarousel extends StatelessWidget {
  final List<PopularPlace>? places;
  final bool isLoading;
  final Function(PopularPlace)? onPlaceSelected;

  const PopularPlacesCarousel({
    super.key,
    required this.places,
    required this.isLoading,
    this.onPlaceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Mashxur Joylar',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : places == null || places!.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.place_outlined,
                            size: 48,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ma\'lumot topilmadi',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: places!.length,
                      itemBuilder: (context, index) {
                        return _buildPlaceCard(
                          context,
                          places![index],
                        );
                      },
                    ),
        ),
      ],
    );
  }
  Widget _buildPlaceCard(BuildContext context, PopularPlace place) {
    return GestureDetector(
      onTap: () => onPlaceSelected?.call(place),
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: CachedNetworkImage(
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
                        Icon(Icons.place, size: 32, color: Colors.grey[500]),
                        const SizedBox(height: 4),
                        Text(
                          'Rasm yuklanmadi',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        
           
        
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 30),
              child: Text(
                place.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(0, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
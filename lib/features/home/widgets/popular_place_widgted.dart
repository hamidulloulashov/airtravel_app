import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:airtravel_app/data/model/home_model.dart';

class PopularPlacesWidget extends StatelessWidget {
  final List<PopularPlace>? places;
  final bool isLoading;

  const PopularPlacesWidget({
    super.key,
    required this.places,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      padding: const EdgeInsets.only(left: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mashxur joylar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                Text(
                  'Barchasini ko\'rish',
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF4CAF50),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : places == null || places!.isEmpty
                    ? Center(
                        child: Text(
                          'Ma\'lumot topilmadi',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6),
                          ),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: places!.length,
                        itemBuilder: (context, index) {
                          return _buildPopularPlaceCard(context, places![index]);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularPlaceCard(BuildContext context, PopularPlace place) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: place.picture,
              width: 160,
              height: 120,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[300],
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: Icon(Icons.place, size: 40, color: Colors.grey[500]),
              ),
            ),
            
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Text(
                place.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
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
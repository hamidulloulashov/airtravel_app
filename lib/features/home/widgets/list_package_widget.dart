import 'package:airtravel_app/data/model/home_model.dart';
import 'package:airtravel_app/features/home/widgets/package_card_widget.dart';
import 'package:flutter/material.dart';

class PackageListWidget extends StatelessWidget {
  final List<Package> packages;
  final bool isLoadingMore;
  final bool showResultCount;
  final int? resultCount;

  const PackageListWidget({
    super.key,
    required this.packages,
    this.isLoadingMore = false,
    this.showResultCount = false,
    this.resultCount,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = 320.0;
    final totalCardsWidth = packages.length * (cardWidth + 16);
    final centerPadding = (screenWidth - cardWidth) / 2;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFB2FF59).withOpacity(0.2),
            const Color(0xFFFFEB3B).withOpacity(0.3),
          ],
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showResultCount && resultCount != null)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFF4CAF50),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Color(0xFF4CAF50),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '$resultCount ta natija topildi',
                            style: const TextStyle(
                              color: Color(0xFF4CAF50),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              
              const SizedBox(height: 16),
              
              SizedBox(
                height: 520,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(
                    left: totalCardsWidth < screenWidth ? centerPadding : 16,
                    right: totalCardsWidth < screenWidth ? centerPadding : 16,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: packages.length + (isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == packages.length && isLoadingMore) {
                      return Center(
                        child: Container(
                          width: 60,
                          margin: const EdgeInsets.only(right: 16),
                          child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                          ),
                        ),
                      );
                    }
                    
                    return PackageCardWidget(
                      package: packages[index],
                      index: index,
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          
          
        ],
      ),
    );
  }
}
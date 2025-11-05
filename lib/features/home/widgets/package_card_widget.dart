import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:airtravel_app/data/model/home_model.dart';

class PackageCardWidget extends StatelessWidget {
  final Package package;
  final int index;

  const PackageCardWidget({
    Key? key,
    required this.package,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      width: 320,
      height: 500, 
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF4CAF50),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSection(context),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: _buildContentSection(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
          child: SizedBox(
            height: 160,
            width: double.infinity,
            child: package.picture != null && package.picture!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: package.picture!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[200],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.hide_image_outlined, size: 40, color: Colors.grey[400]),
                          const SizedBox(height: 6),
                          Text(
                            'Rasm yuklanmadi',
                            style: TextStyle(color: Colors.grey[500], fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    color: Colors.grey[200],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.hide_image_outlined, size: 40, color: Colors.grey[400]),
                        const SizedBox(height: 6),
                        Text(
                          'Rasm yuklanmadi',
                          style: TextStyle(color: Colors.grey[500], fontSize: 11),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        
        Positioned(
          top: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.wb_sunny_outlined, size: 12, color: Colors.white),
                const SizedBox(width: 3),
                Text(
                  '${package.duration ?? 0} kun',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Color(0xFF4CAF50),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
        
        if (package.destinations != null && package.destinations!.isNotEmpty)
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Row(
              children: package.destinations!.take(2).map((dest) {
                final isFirst = package.destinations!.indexOf(dest) == 0;
                return Container(
                  margin: EdgeInsets.only(right: isFirst ? 6 : 0),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check, size: 12, color: Colors.white),
                      const SizedBox(width: 3),
                      Text(
                        '${dest.duration ?? 0} ${dest.ccity?.replaceAll(' (uz)', '') ?? ''}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildContentSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2C) : Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(17)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            package.title?.replaceAll(' (uz)', '') ?? '',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          
          _buildDestinationChips(),
          const SizedBox(height: 10),
          
          Text(
            'Sayohat tarkibi',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          
          _buildFeatures(isDark),
          const SizedBox(height: 12),
          
          Text(
            'Tariflar',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          
          _buildPricingPlans(),
          const SizedBox(height: 12),
          
          _buildDetailsButton(),
        ],
      ),
    );
  }

  Widget _buildDestinationChips() {
    if (package.destinations == null || package.destinations!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: package.destinations!.map((dest) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_on, size: 11, color: Colors.white),
              const SizedBox(width: 3),
              Text(
                '${dest.duration ?? 0} ${dest.ccity?.replaceAll(' (uz)', '') ?? ''}',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFeatures(bool isDark) {
    final features = [
      {'icon': Icons.verified_user_outlined, 'label': 'Sug\'urta'},
      {'icon': Icons.receipt_outlined, 'label': 'Ovqat'},
      {'icon': Icons.description_outlined, 'label': 'Visa'},
    ];
    
    if (package.coreFeatures != null && package.coreFeatures!.isNotEmpty) {
      final extraCount = package.coreFeatures!.length;
      features.add({'icon': Icons.add, 'label': '$extraCount+'});
    }

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: features.map((feature) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF4CAF50), width: 1.5),
            borderRadius: BorderRadius.circular(16),
            color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                feature['icon'] as IconData,
                size: 12,
                color: const Color(0xFF4CAF50),
              ),
              const SizedBox(width: 4),
              Text(
                feature['label'] as String,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF4CAF50),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPricingPlans() {
    if (package.plans == null || package.plans!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      children: package.plans!.take(2).map((plan) {
        final index = package.plans!.indexOf(plan);
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index == 0 ? 6 : 0),
            child: _buildPlanCard(plan),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPlanCard(Plan plan) {
    final bool hasDiscount = plan.isDiscountActive == true && (plan.discount ?? 0) > 0;
    final planName = plan.type?.replaceAll(' (uz)', '') ?? '';
    
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF4CAF50),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  planName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (hasDiscount)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '-${plan.discount}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          
          if (hasDiscount)
            Text(
              '${plan.price}\$',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.white70,
                decorationThickness: 2,
              ),
            ),
          Text(
            '${hasDiscount ? plan.discountedPrice?.toStringAsFixed(0) ?? plan.price : plan.price}\$',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          
          if (plan.features != null)
            ...plan.features!.take(2).map((feature) {
              final featureName = feature.title?.replaceAll(' (uz)', '') ?? '';
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 12,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        featureName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildDetailsButton() {
    return SizedBox(
      height: 44,
      child: Stack(
        children: [
          SizedBox(
            width: double.maxFinite,
            height: 44,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Batafsil...',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFA726),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
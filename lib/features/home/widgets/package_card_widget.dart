import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:airtravel_app/data/model/home_model.dart';

class PackageCardWidget extends StatelessWidget {
  final HomeModel package;
  final int index;

  const PackageCardWidget({
    super.key,
    required this.package,
    required this.index,
  });

  int _getMaxDiscount() {
    if (package.plans.isEmpty) return 0;
    int maxDiscount = 0;
    for (var plan in package.plans) {
      if (plan.discount > maxDiscount) {
        maxDiscount = plan.discount;
      }
    }
    return maxDiscount;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSection(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  package.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                const SizedBox(height: 12),
                
                if (package.destinations.isNotEmpty)
                  _buildRouteTimeline(context),
                
                const SizedBox(height: 16),
                
                _buildTravelInfo(context),
                
                const SizedBox(height: 16),
                
                if (package.plans.isNotEmpty)
                  _buildPlansSection(context),
                
                const SizedBox(height: 16),
                _buildButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    final maxDiscount = _getMaxDiscount();
    
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Stack(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: package.picture,
              fit: BoxFit.cover,
              httpHeaders: const {
                'Connection': 'keep-alive',
              },
              placeholder: (context, url) => Container(
                color: Colors.grey[300],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) {
             
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.grey[300]!,
                        Colors.grey[400]!,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.landscape, 
                        size: 64, 
                        color: Colors.grey[600]
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rasm yuklanmadi',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                ],
              ),
            ),
          ),
          
          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (maxDiscount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '-$maxDiscount%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  const SizedBox(),
                
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.calendar_today, size: 12, color: Colors.black87),
                      const SizedBox(width: 4),
                      Text(
                        '${package.duration} kun',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteTimeline(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark 
            ? const Color(0xFF1E3A28)
            : const Color(0xFFF0F9F4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          for (int i = 0; i < package.destinations.length; i++) ...[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark ? const Color(0xFF1E3A28) : Colors.white, 
                            width: 2
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          package.destinations[i].name,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Text(
                      '${package.destinations[i].duration} kun',
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            if (i < package.destinations.length - 1)
              Container(
                width: 30,
                height: 2,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildTravelInfo(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildInfoChip(
          context: context,
          icon: Icons.flight_takeoff,
          label: _formatDateTime(package.startDate),
          color: const Color(0xFF4CAF50),
        ),
        
        _buildInfoChip(
          context: context,
          icon: Icons.flight_land,
          label: _formatDateTime(package.endDate),
          color: const Color(0xFF2196F3),
        ),
        
        ...package.coreFeatures.map((feature) =>
          _buildInfoChip(
            context: context,
            icon: Icons.verified,
            label: feature.title,
            color: const Color(0xFFFF9800),
          ),
        ),
      ],
    );
  }

  String _formatDateTime(String dateStr) {
    try {
      final dt = DateTime.parse(dateStr);
      return DateFormat('yyyy-MM-dd HH:mm').format(dt);
    } catch (e) {
      return dateStr;
    }
  }

  Widget _buildInfoChip({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlansSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tariflar:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        const SizedBox(height: 12),
        
        if (package.plans.length <= 2)
          Row(
            children: package.plans.map((plan) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    right: package.plans.indexOf(plan) < package.plans.length - 1 ? 8 : 0,
                  ),
                  child: _buildPlanCard(plan),
                ),
              );
            }).toList(),
          )
        else
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: package.plans.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 160,
                  child: _buildPlanCard(package.plans[index]),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildPlanCard(PlanModel plan) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF4CAF50),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4CAF50).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            plan.type.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          
          if (plan.discount > 0) ...[
            Text(
              '\$${plan.price}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            Text(
              '\$${plan.discountedPrice.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ] else
            Text(
              '\$${plan.price}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          
          const SizedBox(height: 8),
          
          // ✅ Plan features
          ...plan.features.map((feature) =>
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, size: 12, color: Colors.white),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      feature.title,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4CAF50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Batafsil',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
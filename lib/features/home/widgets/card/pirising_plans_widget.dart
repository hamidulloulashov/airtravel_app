import 'package:flutter/material.dart';
import 'package:airtravel_app/data/model/home_model.dart';

class PirisingPlansWidget extends StatelessWidget {
  final List<Plan>? plans;

  const PirisingPlansWidget({
    Key? key,
    this.plans,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (plans == null || plans!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      children: plans!.take(2).map((plan) {
        final index = plans!.indexOf(plan);
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index == 0 ? 6 : 0),
            child: PlanCard(plan: plan),
          ),
        );
      }).toList(),
    );
  }
}

class PlanCard extends StatelessWidget {
  final Plan plan;

  const PlanCard({
    Key? key,
    required this.plan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool hasDiscount =
        plan.isDiscountActive == true && (plan.discount ?? 0) > 0;
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
              if (hasDiscount) _buildDiscountBadge(),
            ],
          ),
          const SizedBox(height: 6),
          if (hasDiscount) _buildOriginalPrice(),
          _buildCurrentPrice(hasDiscount),
          const SizedBox(height: 8),
          if (plan.features != null) _buildFeatures(),
        ],
      ),
    );
  }

  Widget _buildDiscountBadge() {
    return Container(
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
    );
  }

  Widget _buildOriginalPrice() {
    return Text(
      '${plan.price}\$',
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 10,
        decoration: TextDecoration.lineThrough,
        decorationColor: Colors.white70,
        decorationThickness: 2,
      ),
    );
  }

  Widget _buildCurrentPrice(bool hasDiscount) {
    return Text(
      '${hasDiscount ? plan.discountedPrice?.toStringAsFixed(0) ?? plan.price : plan.price}\$',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
    );
  }

  Widget _buildFeatures() {
    return Column(
      children: plan.features!.take(2).map((feature) {
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
      }).toList(),
    );
  }
}
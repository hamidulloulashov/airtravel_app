import 'package:flutter/material.dart';
import 'package:airtravel_app/data/model/home_model.dart';

class DistationChipsWidget extends StatelessWidget {
  final List<Destination>? destinations;

  const DistationChipsWidget({
    Key? key,
    this.destinations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (destinations == null || destinations!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: destinations!.map((dest) {
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
}
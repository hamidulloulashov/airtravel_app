import 'package:airtravel_app/features/home/pages/favorit_page.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:airtravel_app/data/model/home_model.dart';

class PackeImageSectionWidget extends StatefulWidget {
  final Package package;
  final bool isLiked;
  final Function(bool)? onLikeChanged;

  const PackeImageSectionWidget({
    Key? key,
    required this.package,
    this.isLiked = false,
    this.onLikeChanged,
  }) : super(key: key);

  @override
  State<PackeImageSectionWidget> createState() => _PackageImageSectionState();
}

class _PackageImageSectionState extends State<PackeImageSectionWidget>
    with SingleTickerProviderStateMixin {
  late bool _isLiked;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(PackeImageSectionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLiked != widget.isLiked) {
      setState(() {
        _isLiked = widget.isLiked;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });

    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    widget.onLikeChanged?.call(_isLiked);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _isLiked
                    ? 'Sevimlilar ro\'yxatiga qo\'shildi'
                    : 'Sevimlilardan o\'chirildi',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: _isLiked ? const Color(0xFF4CAF50) : Colors.grey[700],
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        action: _isLiked
            ? SnackBarAction(
                label: 'Ko\'rish',
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoritesPage(),
                    ),
                  );
                },
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
          child: SizedBox(
            height: 160,
            width: double.infinity,
            child: widget.package.picture != null &&
                    widget.package.picture!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: widget.package.picture!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF4CAF50)),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => _buildImagePlaceholder(),
                  )
                : _buildImagePlaceholder(),
          ),
        ),
        _buildDurationBadge(),
        _buildLikeButton(),
        if (widget.package.destinations != null &&
            widget.package.destinations!.isNotEmpty)
          _buildDestinationBadges(),
      ],
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
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
    );
  }

  Widget _buildDurationBadge() {
    return Positioned(
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
              '${widget.package.duration ?? 0} kun',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLikeButton() {
    return Positioned(
      top: 10,
      right: 10,
      child: GestureDetector(
        onTap: _toggleLike,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: _isLiked ? Colors.red : const Color(0xFF4CAF50),
                  shape: BoxShape.circle,
                  boxShadow: _isLiked
                      ? [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.5),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDestinationBadges() {
    return Positioned(
      bottom: 10,
      left: 10,
      right: 10,
      child: Row(
        children: widget.package.destinations!.take(2).map((dest) {
          final isFirst = widget.package.destinations!.indexOf(dest) == 0;
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
    );
  }
}
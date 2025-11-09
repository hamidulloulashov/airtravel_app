import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeatureIconWidget extends StatelessWidget {
  final String url;
  final double width;
  final double height;

  const FeatureIconWidget({
    super.key,
    required this.url,
    this.width = 32,
    this.height = 32,
  });

  @override
  Widget build(BuildContext context) {
    if (url.endsWith('.svg')) {
      return FutureBuilder<Widget>(
        future: _loadSvg(url),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              width: width,
              height: height,
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          }
          if (snapshot.hasError) {
            return Icon(Icons.error, size: width);
          }
          return snapshot.data ?? Icon(Icons.error, size: width);
        },
      );
    } else {
      return Image.network(
        url,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.broken_image, size: width),
      );
    }
  }

  Future<Widget> _loadSvg(String url) async {
    try {
      return SvgPicture.network(
        url,
        width: width,
        height: height,
        fit: BoxFit.contain,
      );
    } catch (e) {
      return Icon(Icons.error, size: width);
    }
  }
}

import 'package:airtravel_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageGalleryWidget extends StatelessWidget {
  final List<String> pictures;

  const ImageGalleryWidget({super.key, required this.pictures});

  @override
  Widget build(BuildContext context) {
    if (pictures.isEmpty) {
      return Container(
        height: 250.h,
        color: AppColors.containerGrey,
        child: Center(child: Text("Rasmlar mavjud emas", style: TextStyle(color: Colors.white70))),
      );
    }

    final mainImageUrl = pictures.first;
    final otherPictures = pictures.skip(1).toList();

    return SizedBox(
      height: 250.h,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildImage(
              context,
              mainImageUrl,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 2.w),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 1.h),
                    child: otherPictures.length > 0
                        ? _buildImage(context, otherPictures[0], fit: BoxFit.cover)
                        : Container(color: AppColors.containerGrey.withOpacity(0.3)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (otherPictures.length > 1)
                          _buildImage(context, otherPictures[1], fit: BoxFit.cover),
                        if (pictures.length > 3)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                            ),
                            child: Center(
                              child: Text(
                                '+${pictures.length - 3}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        else if (otherPictures.length <= 1)
                          Container(color: AppColors.containerGrey.withOpacity(0.3)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context, String url, {BoxFit fit = BoxFit.contain}) {
    return Image.network(
      url,
      fit: fit,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => Container(
        color: AppColors.containerGrey.withOpacity(0.7),
        child: Center(
          child: Icon(Icons.broken_image, color: Colors.white, size: 40.w),
        ),
      ),
    );
  }
}
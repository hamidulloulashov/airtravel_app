// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
// class AccommodationPicture {
//   final String picture;
//   final bool isMain;
//
//   AccommodationPicture({
//     required this.picture,
//     this.isMain = false,
//   });
// }
//
// // -----------------------------------------------------------------------------
//
// class AccommodationGalleryWidget extends StatelessWidget {
//   final List<AccommodationPicture> pictures;
//
//   const AccommodationGalleryWidget({super.key, required this.pictures});
//
//   @override
//   Widget build(BuildContext context) {
//     if (pictures.isEmpty) {
//       return SizedBox(
//         height: 250.h,
//         child: Center(
//           child: Text(
//             "Rasm yo‘q",
//             style: TextStyle(
//               color: Theme.of(context).textTheme.bodyLarge?.color,
//               fontSize: 14.sp,
//             ),
//           ),
//         ),
//       );
//     }
//
//     final totalPictures = pictures.length;
//     final otherPicturesCount = totalPictures > 4 ? totalPictures - 4 : 0;
//
//     final picUrls = List<String>.generate(4, (index) {
//       return index < totalPictures ? pictures[index].picture : 'placeholder_url';
//     });
//
//     return Stack(
//       children: [
//         _buildImageGrid(context, picUrls, otherPicturesCount),
//
//         // 🔙 Back button
//         Positioned(
//           top: 40.h,
//           left: 10.w,
//           child: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => Navigator.pop(context),
//             style: IconButton.styleFrom(
//               backgroundColor: Colors.black54,
//               shape: const CircleBorder(),
//             ),
//           ),
//         ),
//
//         // ➕ +13 overlay
//         if (otherPicturesCount > 0)
//           Positioned(
//             bottom: 10.h,
//             right: 10.w,
//             child: GestureDetector(
//               onTap: () => _showAllImages(context, pictures),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
//                 decoration: BoxDecoration(
//                   color: Colors.black54,
//                   borderRadius: BorderRadius.circular(8.r),
//                 ),
//                 child: Text(
//                   '+$otherPicturesCount',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
//
//   // 🖼 Grid bo‘linmasi
//   Widget _buildImageGrid(BuildContext context, List<String> picUrls, int otherPicturesCount) {
//     double height = 250.h;
//     double width = 1.sw;
//
//     return GestureDetector(
//       onTap: () => _showAllImages(context, pictures),
//       child: Container(
//         width: width,
//         height: height,
//         color: Colors.grey[100],
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             Positioned(
//               top: 0,
//               left: 0,
//               width: width * 0.5,
//               height: height * 0.5,
//               child: _imageNetwork(picUrls[0]),
//             ),
//             Positioned(
//               top: 0,
//               right: 0,
//               width: width * 0.5,
//               height: height * 0.5,
//               child: _imageNetwork(picUrls[1]),
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               width: width * 0.5,
//               height: height * 0.5,
//               child: _imageNetwork(picUrls[2]),
//             ),
//             Positioned(
//               bottom: 0,
//               right: 0,
//               width: width * 0.5,
//               height: height * 0.5,
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   _imageNetwork(picUrls[3]),
//                   if (otherPicturesCount > 0)
//                     Container(color: Colors.black38),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // 🧩 Network Image yuklash
//   Widget _imageNetwork(String url) {
//     if (url == 'placeholder_url') {
//       return Container(color: Colors.grey[300]);
//     }
//
//     return Image.network(
//       url,
//       fit: BoxFit.cover,
//       loadingBuilder: (context, child, loadingProgress) {
//         if (loadingProgress == null) return child;
//         return const Center(
//           child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
//         );
//       },
//       errorBuilder: (context, error, stackTrace) => Container(
//         color: Colors.grey[200],
//         child: const Icon(Icons.broken_image, color: Colors.grey, size: 30),
//       ),
//     );
//   }
//
//   // 🪟 Fullscreen carousel dialog
//   void _showAllImages(BuildContext context, List<AccommodationPicture> pictures) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           backgroundColor: Colors.black.withOpacity(0.9),
//           insetPadding: EdgeInsets.all(10.w),
//           child: Stack(
//             children: [
//               CarouselSlider(
//                 options: CarouselOptions(
//                   height: 400.h,
//                   viewportFraction: 1.0,
//                   enableInfiniteScroll: false,
//                   enlargeCenterPage: false,
//                 ),
//                 items: pictures.map((pic) {
//                   return Image.network(
//                     pic.picture,
//                     fit: BoxFit.contain,
//                     errorBuilder: (context, error, stackTrace) => const Center(
//                       child: Icon(Icons.broken_image, color: Colors.white, size: 50),
//                     ),
//                   );
//                 }).toList(),
//               ),
//               Positioned(
//                 top: 10.h,
//                 right: 10.w,
//                 child: IconButton(
//                   icon: const Icon(Icons.close, color: Colors.white, size: 28),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

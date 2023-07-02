// import 'package:flutter/material.dart';
// import 'package:pendy_pay_flutter/core/packages/ocr_card_bank/src/model/card_orientation.dart';
//
// class CameraOverlayWidget extends StatelessWidget {
//   final CardOrientation cardOrientation;
//   final double overlayBorderRadius;
//   final Color overlayColorFilter;
//
//   const CameraOverlayWidget({
//     Key? key,
//     required this.cardOrientation,
//     required this.overlayBorderRadius,
//     required this.overlayColorFilter,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(25),
//       child: ColorFiltered(
//         colorFilter: ColorFilter.mode(overlayColorFilter, BlendMode.srcOut),
//         child: Stack(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               child: Align(
//                 alignment: Alignment.bottomRight,
//                 child: Center(
//                   child: _getContainer(context),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _getContainer(context) {
//     if (cardOrientation == CardOrientation.portrait) {
//       return Container(
//         margin: const EdgeInsets.all(12),
//         height: (MediaQuery.of(context).size.width * 0.5),
//         width: (MediaQuery.of(context).size.width * 0.75) * 1.6,
//         decoration: BoxDecoration(
//           color: Colors.black,
//           borderRadius: BorderRadius.circular(overlayBorderRadius),
//         ),
//       );
//     }
//     return Container(
//       height: (MediaQuery.of(context).size.width * 0.95),
//       width: (MediaQuery.of(context).size.width * 0.95) / 1.6,
//       decoration: BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.circular(overlayBorderRadius),
//       ),
//     );
//   }
// }

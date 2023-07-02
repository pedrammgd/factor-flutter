// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pendy_pay_flutter/core/constans/constants.dart';
// import 'package:pendy_pay_flutter/core/packages/pendy_app_bar/pendy_app_bar.dart';
// import 'package:pendy_pay_flutter/core/packages/pendy_text/pendy_text.dart';
// import 'package:pendy_pay_flutter/core/router/pendy_pages.dart';
// import 'package:pendy_pay_flutter/core/theme/app_theme.dart';
// import 'package:pendy_pay_flutter/views/transfer_to_card_number/trtransfer_to_card_number_page.dart';
//
//
// class ScanBankCardPage extends StatefulWidget {
//   const ScanBankCardPage({Key? key}) : super(key: key);
//
//   @override
//   State<ScanBankCardPage> createState() => _ScanBankCardPageState();
// }
//
// class _ScanBankCardPageState extends State<ScanBankCardPage> {
//   // CardInfo? _cardInfo;
//   // final ScannerWidgetController _controller = ScannerWidgetController();
//
//   @override
//   void initState() {
//     _controller
//       ..setCardListener((value) {
//         setState(() {
//           _cardInfo = value;
//
//           if (_cardInfo != null) {
//             if (_cardInfo!.number.isNotEmpty) {
//               Get.offNamed(PendyRoutes.transferToCardNumberPage,
//                   arguments: TransferToCardNumberPage()
//                       .arguments(cardNum: _cardInfo?.number));
//             }
//           }
//         });
//       })
//       ..setErrorListener((exception) {
//         Get.snackbar('کارت نامعتبر', 'مجددا تلاش کنید');
//         print('Error: ${exception.message}');
//       });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     // _controller.dispose();
//     // _controller.disableScanning();
//     // _controller.disableCameraPreview();
//     // _controller.removeCardListeners((value) {});
//     // _controller.removeErrorListener((value) {});
//     // _controller.removeListener(() {});
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const PendyAppBar(
//         stringTitle: 'اسکن کارت',
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//         child: Column(
//           children: [
//             PendyText(
//               'لطفا کارت بانکی مقصد را روبروی دوربین بگیرید. سعی کنید کارت را روی سطح ثابتی قرار دهید.',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w400,
//                 color: Get.isDarkMode ? Colors.white : AppTheme.gray400Color,
//               ),
//             ),
//             Constants.xxLargeVerticalSpacer,
//             // SizedBox(
//             //   height: MediaQuery.of(context).size.height / 2,
//             //   child: ScannerWidget(
//             //     controller: _controller,
//             //   ),
//             // ),
//             Constants.largeVerticalSpacer,
//             GestureDetector(
//               onTap: () {
//                 Get.back();
//               },
//               child: Container(
//                 height: 48,
//                 width: 48,
//                 decoration: BoxDecoration(
//                     color: AppTheme.redColor.withOpacity(.2),
//                     shape: BoxShape.circle),
//                 child: const Center(
//                     child: Icon(
//                       Icons.clear,
//                       color: Colors.white,
//                     )),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

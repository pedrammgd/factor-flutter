// import 'dart:html' as html;
// import 'dart:ui' as ui;
//
// import 'package:factor_flutter_mobile/core/constans/constans.dart';
// import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
// import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
// import 'package:factor_flutter_mobile/views/shared/widgets/subscription_card_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:zarinpal/zarinpal.dart';
//
// class ZarinPalSubscriptionPage extends StatefulWidget {
//   const ZarinPalSubscriptionPage({Key? key}) : super(key: key);
//
//   @override
//   _ZarinPalSubscriptionPageState createState() =>
//       _ZarinPalSubscriptionPageState();
// }
//
// class _ZarinPalSubscriptionPageState extends State<ZarinPalSubscriptionPage> {
//   final PaymentRequest _paymentRequest = PaymentRequest()
//     ..setMerchantID("26b32af8-0aae-460f-90c8-8c497055de03")
//     ..setCallbackURL("http://localhost:49246/#/subscription");
//   List<Color> bacGroundColor = <Color>[
//     bronzeColor,
//     silverColor,
//     goldColor,
//   ];
//   String? _paymentUrl;
//
//   @override
//   void initState() {
//     super.initState();
//     print('sdsdsdds');
//     _paymentRequest.setIsSandBox(false);
//     // _paymentRequest.setMerchantID("26b32af8-0aae-460f-90c8-8c497055de03");
//     _paymentRequest.setAmount(100); //integar Amount
//     // _paymentRequest.setCallbackURL(
//     //     "http://localhost:49246/#/subscription"); //The callback can be an android scheme or a website URL, you and can pass any data with The callback for both scheme and  URL
//     _paymentRequest.setDescription("Payment Description");
//
//     ZarinPal().startPayment(_paymentRequest,
//         (int? status, String? paymentGatewayUri) {
//       if (status == 100) {
//         _paymentUrl = paymentGatewayUri;
//         // _launchURL(
//         //   _paymentUrl ?? '',
//         // );
//         print('paymentGatewayUri${paymentGatewayUri}');
//         print('status${status}');
//       } // launch URL in browser
//       else {
//         print('eeeeeeeerrrrrr');
//       }
//     });
//
//     ZarinPal().verificationPayment(
//         "Status", 'http://localhost:49246/#/subscription', _paymentRequest,
//         (isPaymentSuccess, refID, paymentRequest) {
//       if (isPaymentSuccess) {
//         // Payment Is Success
//         Get.snackbar('Success', 'Success', backgroundColor: Colors.green);
//         print("Success");
//       } else {
//         setState(() {});
//         print(refID);
//         // Error Print Status
//         print("Errorssss");
//         print("isPaymentSuccess${isPaymentSuccess}");
//         print("paymentRequest${paymentRequest}");
//         Get.snackbar('Error', 'Success', backgroundColor: Colors.red);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const FactorAppBar(title: Text('hh')),
//       body: InkWell(
//           onTap: () {
//             // _launchURL(_paymentUrl ?? '');
//           },
//           child: ListView.builder(
//             itemCount: 3,
//             itemBuilder: (context, index) => SubscriptionCardWidget(
//                 isLoading: false,
//                 backGroundColor: bacGroundColor[index],
//                 price: '100',
//                 description: 'descriptionCard',
//                 title: 'titleCard',
//                 icon: iconCard(index),
//                 onTap: () {
//                   // _launchURL(_paymentUrl ?? '');
//                   // html.window.history
//                   //     .pushState(null, FactorRoutes.pay, '#/pay');
//                   Get.toNamed(FactorRoutes.pay,
//                       arguments: const PayPage()
//                           .arguments(payLink: (_paymentUrl ?? '')));
//                 }),
//           )),
//     );
//   }
//
//   String iconCard(int index) {
//     switch (index) {
//       case 0:
//         return bronzeCupIcon;
//       case 1:
//         return silverCupIcon;
//       default:
//         return goldCupIcon;
//     }
//   }
//
//   void _launchURL(String url) async {
//     if (!await launch(url,
//         forceWebView: true,
//         enableJavaScript: true,
//         // webOnlyWindowName: '_self',
//         statusBarBrightness: Brightness.dark))
//       throw 'Could not launch $_paymentUrl';
//   }
// }
//
// class PayPage extends StatelessWidget {
//   const PayPage({Key? key}) : super(key: key);
//
//   Future<void> initArguments() async {
//     if (Get.arguments == null) return;
//     final arguments = Get.arguments as Map;
//     final payLink = arguments['payLink'];
//
//     await ui.platformViewRegistry.registerViewFactory(
//         'hello-world-html',
//         (int viewId) => html.IFrameElement()
//           ..width = double.maxFinite.toString()
//           ..height = double.maxFinite.toString()
//           ..src = payLink
//           ..style.border = 'none');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     initArguments();
//     return const Scaffold(
//       appBar: FactorAppBar(),
//       body: HtmlElementView(viewType: 'hello-world-html'),
//     );
//   }
//
//   Map arguments({
//     required String payLink,
//   }) {
//     final map = {};
//     map['payLink'] = payLink;
//     return map;
//   }
// }

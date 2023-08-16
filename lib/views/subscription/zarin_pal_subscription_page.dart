// import 'dart:developer';
// import 'dart:js' as js;
// import 'dart:html';
// import 'package:factor_flutter_mobile/core/constans/constans.dart';
// import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
// import 'package:factor_flutter_mobile/views/shared/widgets/subscription_card_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:uni_links/uni_links.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:zarinpal/zarinpal.dart';
//
// import '../shared/widgets/factor_snack_bar.dart';
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
//   List<Color> bacGroundColor = <Color>[
//     bronzeColor,
//     silverColor,
//     goldColor,
//   ];
//
//
//   late PaymentRequest paymentRequest;
//   bool isLoadingGoToPayment = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     paymentRequest = PaymentRequest()
//       ..setIsSandBox(true)
//       ..setMerchantID("a3c4b289-c631-4cb3-82f1-3af4041a05e1")
//       ..setCallbackURL(window.location.href)
//       ..setDescription("فیلم")
//       ..setAmount(1000);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     initUniLinks();
//
//     return Scaffold(
//       appBar:  FactorAppBar(
//           customBackButtonFunction:(){
//           }
//       ),
//       body: ListView.builder(
//             itemCount: 3,
//             itemBuilder: (context, index) => SubscriptionCardWidget(
//                 isLoading: false,
//                 backGroundColor: bacGroundColor[index],
//                 price: '100',
//                 description: 'descriptionCard',
//                 title: 'titleCard',
//                 icon: iconCard(index),
//                 onTap:()=> payment()),
//           ),
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
//   void payment() async{
//     isLoadingGoToPayment = true;
//
//     ZarinPal().startPayment(paymentRequest,
//         (int? status, String? paymentGatewayUri) async{
//       if (status == 100) {
//         // print(paymentGatewayUri);
//         // js.context.callMethod('open', [paymentGatewayUri]);
//
//         // launch(paymentGatewayUri! ,universalLinksOnly: true,forceWebView: true);
//       //
//       launchUrl(Uri.parse(paymentGatewayUri!), );
//       } else {
//         FactorSnackBar.getxSnackBar(
//             title: 'خطا دوباره تلاش کنید',
//             message: 'از اتصال اینترنت خود مطمعن شوید',
//             backgroundColor: Colors.red);
//       }
//       isLoadingGoToPayment = false;
//     });
//   }
//
//   Future<void> initUniLinks() async {
//     // var urlQuery = Uri.base.queryParametersAll.entries.toList();
//     var urlQuery = window.location.href;
//
//
//       print('urlQuery${window.location.href}');
//       if (urlQuery.contains('Status=OK')) {
//         paymentRequest = PaymentRequest()
//           ..setIsSandBox(true)
//           ..setMerchantID("a3c4b289-c631-4cb3-82f1-3af4041a05e1")
//           ..setCallbackURL(window.location.href)
//           ..setDescription("فیلم")
//           ..setAmount(1000);
//         print('--------------- payment ok -----------------');
//         print(urlQuery.substring(urlQuery.indexOf('00'),urlQuery.indexOf('&')));
//         print(urlQuery.substring(urlQuery.length - 2) );
//         ZarinPal().verificationPayment(
//             urlQuery.substring(urlQuery.indexOf('00'),urlQuery.indexOf('&')),'OK' , paymentRequest,
//             (isPaymentSuccess, refID, paymentRequest) {
//           log('isPaymentSuccess${isPaymentSuccess}');
//           if (isPaymentSuccess) {
//             // controller.statusPayment = 'PAID';
//             FactorSnackBar.getxSnackBar(
//                 backgroundColor: Colors.green,
//                 title: 'پرداخت موفق',
//                 message: 'با موفقیت پرداخت شد');
//           } else {
//             // controller.statusPayment = 'NOT PAID';
//             FactorSnackBar.getxSnackBar(
//                 backgroundColor: Colors.red,
//                 title: 'پرداخت ناموفق',
//                 message: 'خطا در پرداخت');
//           }
//         });
//       } else {
//         FactorSnackBar.getxSnackBar(
//             backgroundColor: Colors.red,
//             title: 'پرداخت لغو شده',
//             message: 'خطا در پرداخت');
//       }
//
//
//
//     // NOTE: Don't forget to call _sub.cancel() in dispose()
//   }
// }

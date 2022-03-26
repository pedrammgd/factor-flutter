import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:factor_flutter_mobile/views/web_view/web_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';

class ZarinPalSubscriptionPage extends StatefulWidget {
  const ZarinPalSubscriptionPage({Key? key}) : super(key: key);

  @override
  _ZarinPalSubscriptionPageState createState() =>
      _ZarinPalSubscriptionPageState();
}

class _ZarinPalSubscriptionPageState extends State<ZarinPalSubscriptionPage> {
  final PaymentRequest _paymentRequest = PaymentRequest();

  String? _paymentUrl;

  @override
  void initState() {
    super.initState();
    print('sdsdsdds');
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setMerchantID("26b32af8-0aae-460f-90c8-8c497055de03");
    _paymentRequest.setAmount(100); //integar Amount
    _paymentRequest.setCallbackURL(
        "Verfication Url callbacl"); //The callback can be an android scheme or a website URL, you and can pass any data with The callback for both scheme and  URL
    _paymentRequest.setDescription("Payment Description");

    ZarinPal().startPayment(_paymentRequest,
        (int? status, String? paymentGatewayUri) {
      if (status == 100) {
        _paymentUrl = paymentGatewayUri;
        print(paymentGatewayUri);
      } // launch URL in browser
      else {
        print('eeeeeeeerrrrrr');
      }
    });

    ZarinPal()
        .verificationPayment("Status", "Authority Call back", _paymentRequest,
            (isPaymentSuccess, refID, paymentRequest) {
      if (isPaymentSuccess) {
        // Payment Is Success
        print("Success");
      } else {
        print(refID);
        // Error Print Status
        print("Error");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FactorAppBar(),
      body: InkWell(
          onTap: () {
            Get.to(WebViewPage(url: _paymentUrl!));
            // _launchURL();
          },
          child: Center(child: Text('zarinPal'))),
    );
  }

  void _launchURL() async {
    if (!await launch('https://flutter.io',
        // forceWebView: true,
        // enableJavaScript: true,
        statusBarBrightness: Brightness.dark))
      throw 'Could not launch $_paymentUrl';
  }
}

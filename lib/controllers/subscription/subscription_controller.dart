import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  // Future<void> _initShop() async {
  //   var message = "pedram";
  //   var rsaKey =
  //       "MIHNMA0GCSqGSIb3DQEBAQUAA4G7ADCBtwKBrwDB4wvWse5D7qVusjoeiPZcv0C2wAcg3CPmx7ASl1nUTu5rxwr+adX/8z51kAqkNsluX5e0ZBcpd4LbViuk+CTYTVY9usWa8Oz4w1z3HfA7kSA0ZbLyPVXi/02v491x5oFf+5y0gugBUQUgAF1iVHrSMD2Cq8VRZSJgmNf1NB/1MGyLnq5gDJNIci3fQ2EZk/L7vnPwfSTtENQmlPAO9a9DZBSrbW67u+eKRdjksV0CAwEAAQ==";
  //   bool connected = false;
  //   try {
  //     connected = await FlutterPoolakey.connect(rsaKey, onDisconnected: () {
  //       message = "Poolakey disconnected!";
  //       log('log${connected}');
  //     });
  //   } on Exception catch (e) {
  //     message = e.toString();
  //     log(message);
  //   }
  //   if (!connected) {
  //     log('connected${message}');
  //     return;
  //   }
  //   // _reteriveProducts();
  // }
}

import 'package:get/get.dart';
import 'package:signature/signature.dart';

class SignatureBottomSheetController extends GetxController {
  late SignatureController signatureController;

  @override
  void onInit() {
    super.onInit();
    signatureController = SignatureController(penStrokeWidth: 3);
    signatureController.addListener(() {
      if (signatureController.isNotEmpty) {
        showClearButton.value = true;
      } else {
        showClearButton.value = false;
      }
    });
  }

  RxBool showClearButton = false.obs;

  @override
  void dispose() {
    signatureController.dispose();
    super.dispose();
  }
}

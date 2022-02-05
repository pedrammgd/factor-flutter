import 'dart:typed_data';

import 'package:get/get.dart';

class MyProfileController extends GetxController {
  RxBool isLegal = false.obs;
  RxInt loopLegal = 1.obs;
  RxBool isShowSignature = false.obs;
  Rxn<Uint8List> signatureIcon = Rxn<Uint8List>();
}

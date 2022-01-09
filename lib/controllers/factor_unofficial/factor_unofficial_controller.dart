import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:get/get.dart';

class FactorUnofficialController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }



  RxBool isLoading = false.obs;

  RxList<FactorUnofficialItemViewModel> factorUnofficialItemList =
      <FactorUnofficialItemViewModel>[].obs;


}

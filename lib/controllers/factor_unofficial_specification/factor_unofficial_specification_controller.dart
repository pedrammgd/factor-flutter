import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:get/get.dart';

class FactorUnofficialSpecificationController extends GetxController {
  final RxList<FactorUnofficialItemViewModel> factorUnofficialItemList;
  RxBool isExpandedBottomSheet = false.obs;

  final String totalPrice;
  final String taxation;
  final String discount;
  final String totalWordPrice;

  FactorUnofficialSpecificationController({
    required this.factorUnofficialItemList,
    required this.totalPrice,
    required this.taxation,
    required this.discount,
    required this.totalWordPrice,
  });
}

import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:get/get.dart';

class ListTypeFactorPageController extends GetxController {
  final RxList<FactorHomeViewModel> factorHomeList;

  ListTypeFactorPageController({required this.factorHomeList});
}

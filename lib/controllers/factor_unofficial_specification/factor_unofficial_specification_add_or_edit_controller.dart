import 'package:factor_flutter_mobile/models/specification_cost_view_model/specification_cost_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class FactorUnofficialSpecificationAddOrEditController extends GetxController {
  final RxList<SpecificationCostViewModel> specificationCostList;
  final SpecificationCostViewModel? editingSpecificationCostItem;
  late final bool isEdit;

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  FactorUnofficialSpecificationAddOrEditController({
    required this.specificationCostList,
    SpecificationCostViewModel? item,
  })  : editingSpecificationCostItem = item,
        isEdit = (item != null) {
    if (isEdit) {
      titleTextEditingController.text = item!.title;
      costPriceTextEditingController.text = item.price;
    }
  }

  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController costPriceTextEditingController =
      TextEditingController();

  final Uuid uuid = const Uuid();

  SpecificationCostViewModel get _specificationCostDto {
    return SpecificationCostViewModel(
      title: titleTextEditingController.text,
      price: costPriceTextEditingController.text,
      id: uuid.v4(),
    );
  }

  void save() {
    if (!keyForm.currentState!.validate()) return;
    if (isEdit) {
      editSpecificationCost();
    } else {
      addSpecificationCost();
    }
  }

  void addSpecificationCost() {
    specificationCostList.add(_specificationCostDto);
    Get.back(result: true);
  }

  void editSpecificationCost() {
    int index = specificationCostList.indexWhere(
        (element) => element.id == editingSpecificationCostItem?.id);
    specificationCostList[index] = SpecificationCostViewModel(
      id: editingSpecificationCostItem!.id,
      title: titleTextEditingController.text,
      price: costPriceTextEditingController.text,
    );
    Get.back(result: true);
  }
}

import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AddOrEditFactorUnofficialController extends GetxController {
  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController productCountController = TextEditingController();
  final TextEditingController productUnitPriceController =
      TextEditingController();
  final TextEditingController productDiscountController =
      TextEditingController();
  final TextEditingController productTaxationController =
      TextEditingController();
  final Uuid uuid = const Uuid();

  final FactorUnofficialItemViewModel? editingFactorUnofficialItem;
  late final bool isEdit;
  final RxList<FactorUnofficialItemViewModel> factorUnofficialItemList;
  RxBool isLoading = true.obs;
  AddOrEditFactorUnofficialController(
      FactorUnofficialItemViewModel? item, this.factorUnofficialItemList)
      : editingFactorUnofficialItem = item,
        isEdit = (item != null) {
    if (isEdit) {
      productDescriptionController.text = item!.productDescription;
      productCountController.text =       item.productCount.toString();
      productUnitPriceController.text =  item.productUnitPrice.toString();
      productDiscountController.text =   item.productDiscount.toString();
      productTaxationController.text =   item.productTaxation.toString();
    }
  }

  FactorUnofficialItemViewModel get factorUnofficialItemDto {
    return FactorUnofficialItemViewModel(
      id: uuid.v4(),
      productDescription: productDescriptionController.text,
      productCount: int.tryParse(productCountController.text) ?? 0,
      productUnitPrice: int.tryParse(productUnitPriceController.text) ?? 0,
      productDiscount: int.tryParse(productDiscountController.text) ?? 0,
      productTaxation: int.tryParse(productTaxationController.text) ?? 0,
    );
  }



  void save(){
    if(isEdit){

      print('edit');
    }else{
      addUnOfficialItem();
      print('notEdit');
    }


  }

  void addUnOfficialItem() {
    factorUnofficialItemList.add(factorUnofficialItemDto);
    Get.back();
    // productDescriptionController.clear();
    // productCountController.clear();
    // productUnitPriceController.clear();
    // productDiscountController.clear();
    // productTaxationController.clear();
  }
}

import 'package:factor_flutter_mobile/controllers/buyer/buyer_controller.dart';
import 'package:factor_flutter_mobile/views/buyer/widgets/buyer_add_or_edit_bottom_sheet.dart';
import 'package:factor_flutter_mobile/views/buyer/widgets/buyer_list.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_sliver_appBar.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyerPage extends GetView<BuyerController> {
  const BuyerPage({Key? key}) : super(key: key);

  void initArguments() {
    if (Get.arguments == null) return;
    final arguments = Get.arguments as Map;
    final isEnterFromSpecificFactor = arguments['isEnterFromSpecificFactor'];
    Get.lazyPut<BuyerController>(() =>
        BuyerController(isEnterFromSpecificFactor: isEnterFromSpecificFactor));
  }

  @override
  Widget build(BuildContext context) {
    initArguments();
    return Scaffold(
      body: FactorBodyAppBarSliver(
        body: SingleChildScrollView(
          child: Obx(() {
            return Column(
              children: [
                if (controller.isShowFoundSearch.value)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Text(
                      controller.buyerListSearch.isEmpty
                          ? 'نتونستم چیزی برات پیدا کنم'
                          : '${controller.buyerListSearch.length} مورد برات پیدا کردم',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                const BuyerList(),
              ],
            );
          }),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text('لیست مشتری ها',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              )),
        ),
        bottomWidget: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 34,
            ),
            child: SizedBox(
              height: 45,
              width: double.maxFinite,
              child: FactorTextFormField(
                controller: controller.searchTextEditingController,
                width: double.infinity,
                prefixIcon: const Icon(Icons.search),
                hintText: '.....جستجو کن',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hasBorder: true,
                borderColor: Theme.of(context).colorScheme.secondary,
                paddingBottom: 0,
                paddingTop: 0,
                contentPadding: 0,
                onChanged: controller.searchBuyer,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          final result = await Get.bottomSheet(
            BuyerAddOrEditBottomSheet(
              buyerItem: null,
              buyerList: controller.buyerList,
              sharedPreferences: controller.sharedPreferences,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                  30,
                ),
              ),
            ),
            isScrollControlled: true,
            enterBottomSheetDuration: const Duration(milliseconds: 300),
            exitBottomSheetDuration: const Duration(milliseconds: 0),
          );
          if (result == true) {
            controller.isShowFoundSearch.value = false;
            controller.loadBuyerData();
            controller.searchTextEditingController.clear();
          }
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Map arguments({required bool isEnterFromSpecificFactor}) {
    final map = {};
    map['isEnterFromSpecificFactor'] = isEnterFromSpecificFactor;
    return map;
  }
}

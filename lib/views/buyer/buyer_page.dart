import 'package:factor_flutter_mobile/controllers/buyer/buyer_controller.dart';
import 'package:factor_flutter_mobile/views/buyer/widgets/buyer_add_or_edit_bottom_sheet.dart';
import 'package:factor_flutter_mobile/views/buyer/widgets/buyer_list.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_modal_bottom_sheet.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_sliver_appBar.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyerPage extends GetView<BuyerController> {
  const BuyerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<BuyerController>(() => BuyerController());
    return Scaffold(
      body: FactorBodyAppBarSliver(
        body: const BuyerList(),
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
                width: double.infinity,
                prefixIcon: const Icon(Icons.search),
                hintText: '.....جستجو کن',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                fillColor: Colors.white,
                hasBorder: true,
                borderColor: Theme.of(context).colorScheme.secondary,
                paddingBottom: 0,
                paddingTop: 0,
                contentPadding: 0,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CustomModalBottomSheet.showModalBottomSheet(
            color: Theme.of(context).primaryColor,
            child: BuyerAddOrEditBottomSheet(
              buyerList: controller.buyerList,
              sharedPreferences: controller.sharedPreferences,
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

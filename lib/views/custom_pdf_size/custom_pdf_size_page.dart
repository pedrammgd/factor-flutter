import 'package:factor_flutter_mobile/controllers/custom_pdf_size/custom_pdf_size_controller.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPdfSizePage extends GetView<CustomPdfSizeController> {
  const CustomPdfSizePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<CustomPdfSizeController>(() => CustomPdfSizeController());
    return Scaffold(
      appBar: FactorAppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            'قالب فاکتور',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: controller.paperSizeListText.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: paperWidthSize(index),
          ),
          child: Obx(() {
            return InkWell(
              onTap: () {
                controller.selectedPaper.value = index;
                controller.savePaperSizeData();
              },
              child: Ink(
                  child: _paperItem(
                      index: index,
                      selectedItem: index == controller.selectedPaper.value),
                  height: 150,
                  color: Colors.white),
            );
          }),
        ),
      ),
    );
  }

  Widget _paperItem({required int index, required bool selectedItem}) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        controller.paperSizeListText[index],
        style:
            TextStyle(fontSize: 20, color: Theme.of(Get.context!).primaryColor),
      ),
      if (selectedItem)
        Icon(
          Icons.check,
          color: Theme.of(Get.context!).primaryColor,
        ),
    ]);
  }

  double paperWidthSize(int index) {
    if (index == 0) {
      return 50;
    } else if (index == 1) {
      return 100;
    } else {
      return 150;
    }
  }
}

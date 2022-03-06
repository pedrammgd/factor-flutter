import 'package:factor_flutter_mobile/controllers/currency/currency_controller.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrencyPage extends GetView<CurrencyController> {
  const CurrencyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<CurrencyController>(() => CurrencyController());
    return Scaffold(
      appBar: FactorAppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            'واحد پول',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: controller.currencyList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            return InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                controller.selectedCurrency.value = index;
                controller.saveCurrencyData();
              },
              child: Ink(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: _currencyItem(
                      index: index,
                      selectedItem:
                          index == controller.selectedCurrency.value)),
            );
          }),
        ),
      ),
    );
  }

  Widget _currencyItem({required int index, required bool selectedItem}) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        controller.currencyList[index],
        style: const TextStyle(fontSize: 20),
      ),
      if (selectedItem) const Icon(Icons.check),
    ]);
  }
}

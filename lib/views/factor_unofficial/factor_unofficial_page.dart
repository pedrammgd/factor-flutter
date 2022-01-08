import 'package:factor_flutter_mobile/controllers/factor_unofficial/factor_unofficial_controller.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial/widgets/factor_unofficial_list.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_modal_bottom_sheet.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FactorUnofficialPage extends GetView<FactorUnofficialController> {
  const FactorUnofficialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FactorUnofficialController());
    return Scaffold(
      appBar: const FactorAppBar(
        height: 56,
        title: Padding(
          padding: EdgeInsets.only(top: 19.0),
          child: Text(
            'فاکتور جدید',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
      body: const FactorUnofficialList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CustomModalBottomSheet.showModalBottomSheet(context,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.all(10),
                        height: 3,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ],
                  ),
                  const FactorTextFormField(
                    width: double.infinity,
                    labelText: 'شرح کالا *',
                    borderColor: Colors.black,
                    hasBorder: true,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Expanded(
                          child: FactorTextFormField(
                        labelText: 'تعداد *',
                      )),
                      Expanded(
                          child: FactorTextFormField(
                        labelText: 'قیمت واحد *',
                      )),
                    ],
                  ),
                  Row(
                    children: const [
                      Expanded(
                          child: FactorTextFormField(
                        labelText: 'تخفیف',
                      )),
                      Expanded(
                          child: FactorTextFormField(
                        labelText: 'مالیات',
                      )),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: OutlinedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('ثبت')))),
                ],
              ));
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

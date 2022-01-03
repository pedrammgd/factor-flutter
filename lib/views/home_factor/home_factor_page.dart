import 'package:factor_flutter_mobile/controllers/home_factor/home_factor_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/views/home_factor/widgets/factor_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFactorPage extends GetView<HomeFactorController> {
  const HomeFactorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeFactorController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _topCard('فاکتور رسمی', addFactorOfficialIcon),
                  _topCard('فاکتور غیر رسمی', addFactorUnofficialIcon),
                ],
              ),
              const FactorList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.factorList.add(FactorViewModel(title: 'فاکتور جدید3', id: 1));
          controller.saveFactorData();
        },
      ),
    );
  }



  Widget _topCard(String title, String icon) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 10, end: 15, start: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {},
        child: Ink(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 15),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

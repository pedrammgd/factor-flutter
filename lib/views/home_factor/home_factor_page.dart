import 'package:factor_flutter_mobile/controllers/home_factor/home_factor_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/views/home_factor/widgets/factor_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeFactorPage extends GetView<HomeFactorController> {
  const HomeFactorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeFactorController());
    return Scaffold(
      extendBody: true,
      bottomNavigationBar:   Padding(
        padding: const EdgeInsets.all(10.0),
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          currentIndex: 0,
          onTap: (value) {
            if(value ==1) {
              Get.toNamed(FactorRoutes.more);
            }
          },
          items: const <BottomNavigationBarItem>[
             BottomNavigationBarItem(
              icon:  Icon(Icons.home,color: Colors.white,),
              label:  "Left",
            ),
             BottomNavigationBarItem(
              icon:  Icon(Icons.search,color: Colors.white,),
               label:  "eee",
            ),
          ],
        ),
      ),

      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _topCard(context,'فاکتور رسمی', addFactorOfficialIcon),
                  _topCard(context,'فاکتور غیر رسمی', addFactorUnofficialIcon),
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



  Widget _topCard(BuildContext context, String title, String icon) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 10, end: 15, start: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {},
        child: Ink(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
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
                color: Theme.of(context).colorScheme.secondary,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 15),
                child: Text(
                  title,
                  style:  TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

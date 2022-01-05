import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class CustomBottomNavigationBar extends StatefulWidget {

 const CustomBottomNavigationBar();

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
    int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {

    return BottomAppBar(
      notchMargin: 5,
      // elevation: 20,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(2, (index) {

          return InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Text('aaaa',style: TextStyle(color: index == selectedIndex ? Colors.blue:null),));
          // return _navItems(context , index ,selectedIndex,(){})[index];

        }),
      ),
    );
  }




  // const SizedBox(
 List<Widget> _navItems(BuildContext context ,int index , int selectIndex , Function()? onTap){
    return [
      _itemNav(context,index,selectIndex,(){
        setState(() {
          selectIndex = index;
          print(selectIndex);
          Get.offAndToNamed(FactorRoutes.home);
        } );
      },index == selectIndex),
      _itemNav(context,index,selectIndex,(){
        setState(() {
          selectIndex = index;
          print(selectIndex);
        Get.offAndToNamed(FactorRoutes.more);
        });
      },index == selectIndex),
    ];

 }

  Widget _itemNav(BuildContext context,int index , int selectIndex , Function() onTap , bool isSelected){
    return GestureDetector(
      onTap: onTap,
      // onTap: () => Get.offAndToNamed(FactorRoutes.home),
      // onTap: () => Get.offAndToNamed(FactorRoutes.more),
      child: SizedBox(
        height: 50,
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: [
            Constants.tinyVerticalSpacer,
            Image.asset(
              homeIcon,
              width: 30,
              height: 30,
              fit: BoxFit.contain,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Constants.tinyVerticalSpacer,

             SizedBox(
                height: 5,
                width: 5,
                child: CircleAvatar(
                  backgroundColor:isSelected? Colors.black :Colors.blueAccent,
                )),
          ],
        ),
      ),
    );
  }
}

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar(
      {required this.items,
      this.selectedIndex = 0,
      required this.onItemSelected});

  final List<FactorBottomNavigationBarItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 20,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((e) {
          var index = items.indexOf(e);
          return InkWell(
            onTap: () => onItemSelected(index),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 60, end: 60),
              child: ItemsBottomNavigation(
                isSelected: index == selectedIndex,
                factorBottomNavigationBarItem: e,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ItemsBottomNavigation extends StatelessWidget {
  final bool isSelected;
  final FactorBottomNavigationBarItem factorBottomNavigationBarItem;

  const ItemsBottomNavigation(
      {required this.isSelected, required this.factorBottomNavigationBarItem});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Constants.tinyVerticalSpacer,
          Image.asset(
            factorBottomNavigationBarItem.icon,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
            color: Theme.of(context).colorScheme.secondary,
          ),
          Constants.tinyVerticalSpacer,
          if (isSelected)
            SizedBox(
                height: 5,
                width: 5,
                child: CircleAvatar(
                  backgroundColor: greenColor,
                ))
        ],
      ),
    );
  }
}

class FactorBottomNavigationBarItem {
  FactorBottomNavigationBarItem({
    required this.icon,
    this.activeColor = Colors.blue,
    this.textAlign,
    this.inactiveColor,
  });

  final String icon;

  final Color activeColor;

  final Color? inactiveColor;

  final TextAlign? textAlign;
}

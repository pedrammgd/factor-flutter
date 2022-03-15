import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/material.dart';

class BuyerCardWidget extends StatelessWidget {
  const BuyerCardWidget(
      {this.paddingTop = 10,
      this.paddingEnd = 20,
      this.paddingStart = 20,
      this.paddingBottom = 0,
      this.height = 71,
      this.onTap,
      this.removeOnTap,
      this.title = 'پدرام مجرد',
      required this.isHaghighi,
      this.onSelectedPopUp,
      this.itemPopUp,
      this.isPaintingBorder = false});

  final double paddingTop;
  final double paddingEnd;
  final double paddingStart;
  final double paddingBottom;
  final double height;
  final Function()? onTap;
  final Function()? removeOnTap;
  final String title;
  final bool isHaghighi;
  final Function(String)? onSelectedPopUp;
  final List<String>? itemPopUp;
  final bool isPaintingBorder;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: paddingTop,
          end: paddingEnd,
          start: paddingStart,
          bottom: paddingBottom),
      child: Container(
        // height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: isPaintingBorder ? Colors.black : Colors.black12,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.min,
            children: [
              _titleWidget(),
              Constants.largeHorizontalSpacer,
              Expanded(
                child: Text(
                  isHaghighi ? 'حقیقی' : 'حقوقی',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              _morePopup(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _morePopup() => PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert),
        iconSize: 20,
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        onSelected: onSelectedPopUp,
        itemBuilder: (context) => itemPopUp!
            .map((e) => PopupMenuItem<String>(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
      );
}

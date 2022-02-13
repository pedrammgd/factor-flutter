import 'package:flutter/material.dart';

class BuyerCardWidget extends StatelessWidget {
  const BuyerCardWidget(
      {this.paddingTop = 10,
      this.paddingEnd = 20,
      this.paddingStart = 20,
      this.paddingBottom = 0,
      this.height = 71,
      this.editOnTap,
      this.removeOnTap,
      this.title = 'پدرام مجرد',
      required this.isHaghighi,
      this.onSelectedPopUp,
      this.itemPopUp});

  final double paddingTop;
  final double paddingEnd;
  final double paddingStart;
  final double paddingBottom;
  final double height;
  final Function()? editOnTap;
  final Function()? removeOnTap;
  final String title;
  final bool isHaghighi;
  final Function(String)? onSelectedPopUp;
  final List<String>? itemPopUp;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: paddingTop,
          end: paddingEnd,
          start: paddingStart,
          bottom: paddingBottom),
      child: Ink(
        // height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: editOnTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              _titleWidget(),
              // Constants.largeHorizontalSpacer,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    isHaghighi ? 'حقیقی' : 'حقوقی',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
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
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 15, start: 20),
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

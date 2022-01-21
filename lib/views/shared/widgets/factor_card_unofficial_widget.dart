import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/material.dart';

class FactorCardUnOfficialWidget extends StatelessWidget {
  const FactorCardUnOfficialWidget(
      {this.paddingTop = 0,
      this.paddingEnd = 0,
      this.paddingStart = 0,
      this.paddingBottom = 0,
      this.height,
      this.onTap,
      this.title = 'فاکتور فروش محصولات اینترنتی',
      this.onSelectedPopUp,
      this.itemPopUp,
      required this.itemIndex});

  final double paddingTop;
  final double paddingEnd;
  final double paddingStart;
  final double paddingBottom;
  final double? height;
  final Function()? onTap;
  final Function(String)? onSelectedPopUp;
  final String title;
  final List<String>? itemPopUp;
  final int itemIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: paddingTop,
          end: paddingEnd,
          start: paddingStart,
          bottom: paddingBottom),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary,
              blurRadius: .1,
            ),
          ],
        ),
        child: InkWell(
            borderRadius: BorderRadius.circular(0),
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Constants.largeHorizontalSpacer,
                    _titleWidget(),
                    Constants.largeHorizontalSpacer,
                    _morePopup(),
                    Constants.largeHorizontalSpacer,
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Widget _titleWidget() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        '$itemIndex- ${title}',
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    ));
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

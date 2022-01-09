import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/material.dart';

class FactorCardUnOfficialWidget extends StatelessWidget {
  const FactorCardUnOfficialWidget(
      {this.paddingTop = 10,
      this.paddingEnd = 20,
      this.paddingStart = 20,
      this.paddingBottom = 0,
      this.height,
      this.editOnTap,
      this.removeOnTap,
      this.title = 'فاکتور فروش محصولات اینترنتی'});

  final double paddingTop;
  final double paddingEnd;
  final double paddingStart;
  final double paddingBottom;
  final double? height;
  final Function()? editOnTap;
  final Function()? removeOnTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: paddingTop,
          end: paddingEnd,
          start: paddingStart,
          bottom: paddingBottom),
      child: Ink(
        height: height,
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
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Widget _titleWidget() {
    return Expanded(
        child:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),

    ),
        ));
  }

  Widget _morePopup() => PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        iconSize: 20,
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: const Text('ویرایش'),
              onTap: editOnTap,
            ),
            PopupMenuItem(
              child: const Text('حذف'),
              onTap: removeOnTap,
            ),
          ];
        },
      );
}

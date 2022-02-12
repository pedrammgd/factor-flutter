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
      required this.isHaghighi});

  final double paddingTop;
  final double paddingEnd;
  final double paddingStart;
  final double paddingBottom;
  final double height;
  final Function()? editOnTap;
  final Function()? removeOnTap;
  final String title;
  final bool isHaghighi;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _titleWidget(),
              // Constants.largeHorizontalSpacer,
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  isHaghighi ? 'حقیقی' : 'حقوقی',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              _morePopup(),
            ],
          ),
          // const Spacer(),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: const [
          //     Padding(
          //       padding:
          //           EdgeInsetsDirectional.only(start: 20, bottom: 10),
          //       child: Text(
          //         'حقیقی',
          //         style: TextStyle(
          //           fontSize: 11,
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: EdgeInsetsDirectional.only(end: 10, bottom: 10),
          //       child: Text(
          //         '1 فاکتور',
          //         style: TextStyle(
          //           fontSize: 11,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 15, start: 20),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
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

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/material.dart';

class FactorCardHomeWidget extends StatelessWidget {
  const FactorCardHomeWidget(
      {this.paddingTop = 10,
      this.paddingEnd = 20,
      this.paddingStart = 20,
      this.paddingBottom = 0,
      this.height = 100,
      this.onTap,
      this.title = 'فاکتور فروش محصولات اینترنتی',
      required this.factorNum,
      required this.factorDate,
      this.onSelectedPopUp,
      this.itemPopUp});

  final double paddingTop;
  final double paddingEnd;
  final double paddingStart;
  final double paddingBottom;
  final double height;
  final Function()? onTap;
  final String title;
  final String factorNum;
  final String factorDate;
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
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _titleWidget(),
                    Constants.largeHorizontalSpacer,
                    _morePopup(),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          start: 20, bottom: 10),
                      child: Text(factorNum),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(end: 10, bottom: 10),
                      child: Text(
                        factorDate,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
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
      padding: const EdgeInsetsDirectional.only(top: 20, start: 20),
      child: Text(
        title,
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

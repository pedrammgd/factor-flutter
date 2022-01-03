import 'dart:ui';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/material.dart';

class MoreItemWidget extends StatelessWidget {
  final double paddingTop;
  final double paddingEnd;
  final double paddingBottom;
  final double paddingStart;
  final String title;
  final String icon;

  const MoreItemWidget(
      {this.paddingTop = 10,
      this.paddingEnd = 20,
      this.paddingBottom = 10,
      this.paddingStart = 20,
      this.title = 'عنوان',
      this.icon = purchaseRecordsIcon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.black54,
      onTap: () {},
      child: Padding(
        padding: EdgeInsetsDirectional.only(
            start: paddingStart,
            bottom: paddingBottom,
            end: paddingEnd,
            top: paddingTop),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 30,
              height: 30,
              fit: BoxFit.contain,
              color: Colors.black,
            ),
            Constants.smallHorizontalSpacer,
            Text(
              title,
              style: TextStyle(
                  color: settingTextColor, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 17,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

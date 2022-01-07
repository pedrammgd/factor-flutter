

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/material.dart';

class MoreItemWidget extends StatelessWidget {
  final double paddingTop;
  final double paddingEnd;
  final double paddingBottom;
  final double paddingStart;
  final String title;
  final String icon;
  final Function()? onTap;

  const MoreItemWidget(
      {this.paddingTop = 10,
      this.paddingEnd = 20,
      this.paddingBottom = 10,
      this.paddingStart = 20,
      this.title = 'عنوان',
      this.icon = purchaseRecordsIcon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.black54,
      onTap: onTap,
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
              width: 28,
              height: 28,
              fit: BoxFit.contain,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Constants.smallHorizontalSpacer,
            Text(
              title,
              style: const TextStyle(
                 fontWeight: FontWeight.bold),
            ),
            const Spacer(),
             Icon(
              Icons.arrow_forward_ios,
              size: 17,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}

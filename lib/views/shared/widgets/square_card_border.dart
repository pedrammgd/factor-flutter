import 'dart:typed_data';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SquareCardBorder extends StatelessWidget {
  const SquareCardBorder(
      {required this.title,
      required this.icon,
      this.onTap,
      this.signatureIcon,
      this.isShowSignature = false});

  final Widget title;
  final Widget icon;
  final Function()? onTap;
  final Uint8List? signatureIcon;
  final bool isShowSignature;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height / 4,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Constants.mediumVerticalSpacer,
            if (isShowSignature)
              Image.memory(
                signatureIcon!,
                width: MediaQuery.of(Get.context!).size.width / 2,
                height: MediaQuery.of(Get.context!).size.height / 8,
              )
            else
              icon,
            const Spacer(),
            title,
            Constants.mediumVerticalSpacer,
          ],
        ),
      ),
    );
  }
}

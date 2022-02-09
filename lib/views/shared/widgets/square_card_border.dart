import 'dart:typed_data';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SquareCardBorder extends StatelessWidget {
  const SquareCardBorder(
      {required this.title,
      required this.icon,
      this.onTap,
      this.uint8ListImage,
      this.isShowUint8List = false,
      this.removeUint8ListOnTap});

  final Widget title;
  final Widget icon;
  final Function()? onTap;
  final Uint8List? uint8ListImage;
  final bool isShowUint8List;
  final Function()? removeUint8ListOnTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border:
                    Border.all(color: Theme.of(context).colorScheme.secondary),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Constants.mediumVerticalSpacer,
                if (isShowUint8List)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.memory(
                        uint8ListImage!,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(Get.context!).size.width / 2,
                        height: MediaQuery.of(Get.context!).size.height / 8,
                      ),
                    ),
                  )
                else
                  icon,
                const Spacer(),
                title,
                Constants.mediumVerticalSpacer,
              ],
            ),
          ),
        ),
        if (isShowUint8List)
          InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: removeUint8ListOnTap,
            child: const Padding(
              padding: EdgeInsetsDirectional.only(
                  end: 10, top: 10, bottom: 10, start: 10),
              child: Icon(
                Icons.clear,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}

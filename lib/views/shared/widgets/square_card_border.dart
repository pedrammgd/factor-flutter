import 'dart:typed_data';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/cupertino.dart';
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
      this.removeUint8ListOnTap,
      this.height,
      this.width});

  final Widget title;
  final Widget icon;
  final Function()? onTap;
  final Uint8List? uint8ListImage;
  final bool isShowUint8List;
  final Function()? removeUint8ListOnTap;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Container(
            height: height ?? MediaQuery.of(context).size.height / 3.5,
            width: width ?? MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border:
                    Border.all(color: Theme.of(context).colorScheme.secondary),
                borderRadius: BorderRadius.circular(15)),
            // child: isShowUint8List
            //     ? Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 20),
            //         child: ClipRRect(
            //           borderRadius: BorderRadius.circular(15),
            //           child: Image.memory(
            //             uint8ListImage!,
            //             fit: BoxFit.contain,
            //             // width: MediaQuery.of(Get.context!).size.width / 2,
            //             height: MediaQuery.of(Get.context!).size.height / 2,
            //           ),
            //         ),
            //       )
            //     : Column(
            //         children: [
            //           const Spacer(),
            //           icon,
            //           Constants.mediumVerticalSpacer,
            //           Expanded(child: title),
            //           Constants.mediumVerticalSpacer,
            //         ],
            //       ),

            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Constants.mediumVerticalSpacer,
                  if (isShowUint8List)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.memory(
                            uint8ListImage!,
                            fit: BoxFit.contain,
                            width: MediaQuery.of(Get.context!).size.width / 2,
                            height: MediaQuery.of(Get.context!).size.height / 5,
                          ),
                        ),
                      ),
                    )
                  else
                    Expanded(child: Center(child: icon)),
                  Constants.smallVerticalSpacer,
                  title,
                  Constants.smallVerticalSpacer,
                ],
              ),
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

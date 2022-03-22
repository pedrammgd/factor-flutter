import 'dart:typed_data';

import 'package:factor_flutter_mobile/views/shared/widgets/square_card_border.dart';
import 'package:flutter/material.dart';

class MyProfileImageCard extends StatelessWidget {
  const MyProfileImageCard(
      {Key? key,
      this.onTap,
      this.removeUint8ListOnTap,
      required this.isShowUint8List,
      this.uint8ListImage,
      required this.title,
      required this.editTitle,
      required this.icon})
      : super(key: key);

  final Function()? onTap;
  final Function()? removeUint8ListOnTap;
  final bool isShowUint8List;
  final Uint8List? uint8ListImage;
  final String title;
  final String editTitle;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return SquareCardBorder(
      removeUint8ListOnTap: () => removeUint8ListOnTap!(),
      isShowUint8List: isShowUint8List,
      uint8ListImage: uint8ListImage,
      title: Text(!isShowUint8List ? title : editTitle),
      onTap: onTap,
      icon: Image.asset(
        icon,
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 13,
        fit: BoxFit.contain,
      ),
    );
  }
}

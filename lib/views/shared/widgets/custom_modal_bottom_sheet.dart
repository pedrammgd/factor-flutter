import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomModalBottomSheet {
  final ShapeBorder? shape;
  final Widget child;
  final Color color;

  CustomModalBottomSheet.showModalBottomSheet({
    this.color = Colors.white,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          30,
        ),
      ),
    ),
    required this.child,
  }) {
    Get.bottomSheet(
      child,
      backgroundColor: color,
      shape: shape,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 250),


    );
  }
}

import 'package:flutter/material.dart';

class CustomModalBottomSheet {
  ShapeBorder? shape;
  Widget child;

  CustomModalBottomSheet.showModalBottomSheet(
    BuildContext context, {
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          30,
        ),
      ),
    ),
    required this.child,
  }) {
    showModalBottomSheet(
      context: context,
      shape: shape,
      builder: (context) {
        return child;
      },
    );
  }
}

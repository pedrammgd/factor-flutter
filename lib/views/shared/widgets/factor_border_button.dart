import 'dart:ui';

import 'package:flutter/material.dart';

class CustomBorderButton extends StatelessWidget {
  const CustomBorderButton(
      {this.titleButton = 'دکمه',
      required this.onPressed,
      this.backgroundColor,
      this.isFilled = false,
      this.icon});

  final String titleButton;
  final Function()? onPressed;
  final Color? backgroundColor;
  final bool isFilled;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: icon ?? const SizedBox.shrink(),
      onPressed: onPressed,
      label: Text(
        titleButton,
        textAlign: TextAlign.start,
        style: TextStyle(
            color: isFilled ? Colors.red : Colors.black,
            fontWeight: FontWeight.bold),
      ),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.only(left: icon == null ? 10 : 0),
        primary: Colors.black,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(
          width: 1.5,
          color: isFilled ? Colors.red : Colors.black,
        ),
      ),
    );
  }
}

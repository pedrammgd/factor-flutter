import 'dart:ui';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/material.dart';

class FactorButton extends StatelessWidget {
  const FactorButton(
      {this.titleButton = 'دکمه',
      required this.onPressed,
      this.backgroundColor,
      this.icon,
      this.textColor,
      this.borderColor,
      this.height = 50,
      this.isLoading = false,
      this.width});

  final String titleButton;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Widget? icon;
  final double height;
  final double? width;
  final bool isLoading;

  const factory FactorButton.elevated({
    required Function()? onPressed,
    required String titleButton,
    bool isLoading,
    double height,
    Color? textColor,
    Widget? icon,
    double? width,
    Color? primaryColor,
    Color? borderColor,
  }) = _FactorElevatedButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: OutlinedButton.icon(
        icon: icon ?? const SizedBox.shrink(),
        onPressed: isLoading ? null : onPressed,
        label: Text(
          titleButton,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: textColor ?? greenColor, fontWeight: FontWeight.bold),
        ),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.only(
            left: icon == null ? 10 : 0,
          ),
          primary: greenColor,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(
            width: 1.5,
            color: borderColor ?? greenColor,
          ),
        ),
      ),
    );
  }
}

class _FactorElevatedButton extends FactorButton {
  final Color? primaryColor;
  const _FactorElevatedButton({
    required Function()? onPressed,
    required String titleButton,
    double height = 50,
    Color? textColor,
    bool isLoading = false,
    Widget? icon,
    double? width,
    this.primaryColor,
    Color? borderColor,
  }) : super(
            onPressed: onPressed,
            titleButton: titleButton,
            textColor: textColor,
            height: height,
            isLoading: isLoading,
            icon: icon,
            width: width,
            borderColor: borderColor);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: ElevatedButton.icon(
        icon: icon ?? const SizedBox.shrink(),
        onPressed: isLoading ? null : onPressed,
        label: Text(
          titleButton,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: textColor ?? Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.only(
            left: icon == null ? 10 : 0,
          ),
          primary: primaryColor ?? greenColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(
            width: 1.5,
            color: borderColor ?? greenColor,
          ),
        ),
      ),
    );
  }
}

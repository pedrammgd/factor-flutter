import 'package:flutter/material.dart';

class CustomFactorDivider extends StatelessWidget {
  final Color color;
  final double endIndent;
  final double height;
  final double indent;
  final double thickness;

  const CustomFactorDivider(
      {this.color = Colors.black,
      this.endIndent = 20,
      this.height = 16,
      this.indent = 20,
      this.thickness = 1});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      endIndent: endIndent,
      height: height,
      indent: indent,
      thickness: thickness,
    );
  }
}

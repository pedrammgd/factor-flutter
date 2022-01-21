import 'package:flutter/material.dart';

class FactorLabeledWidget extends StatelessWidget {
  final Widget? label;
  final int labelFlex;
  final Widget? child;
  final int childFlex;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry labelAlignment;
  final AlignmentGeometry childAlignment;

  FactorLabeledWidget(
      {this.label,
      this.labelFlex = 4,
      this.child,
      this.childFlex = 3,
      this.labelAlignment = AlignmentDirectional.center,
      this.childAlignment = AlignmentDirectional.center,
      this.padding = const EdgeInsets.all(3.0)})
      : assert(labelFlex >= 0),
        assert(childFlex >= 0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_labelWidget, _childWidget],
      ),
    );
  }

  Widget get _labelWidget => Expanded(
        flex: labelFlex,
        child: Align(alignment: labelAlignment, child: label ?? SizedBox()),
      );

  Widget get _childWidget => Expanded(
        flex: childFlex,
        child: Align(alignment: childAlignment, child: child ?? SizedBox()),
      );
}

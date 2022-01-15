import 'package:flutter/material.dart';

class KeyValueTextWidget extends StatelessWidget {
  KeyValueTextWidget(
      {required this.keyText,
      required this.valueText,
      this.keyTextSize = 15,
      this.valueTextSize = 15,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
      this.startSpacer = const SizedBox(
        width: 16,
      ),
      this.betweenSpacer = const SizedBox(
        width: 16,
      ),
      this.endSpacer = const SizedBox(
        width: 24,
      )});

  final String keyText;
  final String valueText;
  final double keyTextSize;
  final double valueTextSize;
  final MainAxisAlignment mainAxisAlignment;
  final SizedBox startSpacer;
  final SizedBox betweenSpacer;
  final SizedBox endSpacer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        startSpacer,
        Text(
          keyText,
          style: TextStyle(fontSize: keyTextSize),
        ),
        betweenSpacer,
        const Spacer(),
        Text(
          valueText,
          style: TextStyle(fontSize: valueTextSize),
        ),
        endSpacer,
      ],
    );
  }
}

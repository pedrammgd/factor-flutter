import 'package:flutter/material.dart';

class KeyValueTextWidget extends StatelessWidget {
  KeyValueTextWidget({
    required this.keyText,
    required this.valueText,
    this.keyTextSize = 15,
    this.valueTextSize = 13,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.startSpacer = const SizedBox(
      width: 16,
    ),
    this.betweenSpacer = const SizedBox(
      width: 16,
    ),
    this.endSpacer = const SizedBox(
      width: 24,
    ),
    this.bracketKeyText = '',
  });

  final String keyText;
  final String valueText;
  final double keyTextSize;
  final double valueTextSize;
  final MainAxisAlignment mainAxisAlignment;
  final SizedBox startSpacer;
  final SizedBox betweenSpacer;
  final SizedBox endSpacer;
  final String bracketKeyText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        startSpacer,
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: RichText(
              text: TextSpan(
                text: keyText,
                style: TextStyle(
                    fontSize: keyTextSize,
                    fontFamily: 'IRANSans',
                    color: Theme.of(context).colorScheme.secondary),
                children: <TextSpan>[
                  TextSpan(
                      text: bracketKeyText,
                      style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          fontFamily: 'IRANSans')),
                ],
              ),
            ),
          ),
        ),

        betweenSpacer,
        // const Spacer(),
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              valueText,
              style: TextStyle(
                fontSize: valueTextSize,
              ),
            ),
          ),
        ),
        endSpacer,
      ],
    );
  }
}

import 'package:flutter/material.dart';

class FactorCircularProgressIndicator extends StatelessWidget {
  const FactorCircularProgressIndicator({Key? key, this.color})
      : super(key: key);
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      width: 15,
      child: CircularProgressIndicator(
        color: color ?? Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

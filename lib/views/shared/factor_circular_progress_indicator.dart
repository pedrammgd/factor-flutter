import 'package:flutter/material.dart';

class FactorCircularProgressIndicator extends StatelessWidget {
  const FactorCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      width: 15,
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardIconWidget extends StatelessWidget {
  final String title;
  final String icon;
  final Function()? onTap;
  final bool comingSoon;

  const CardIconWidget(
      {required this.title,
      required this.icon,
      this.onTap,
      this.comingSoon = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: onTap,
      child: Ink(
        width: 110,
        height: 110,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (comingSoon)
              const Align(
                alignment: Alignment.topLeft,
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(-30 / 360),
                  child: Text(
                    'به زودی',
                    style: TextStyle(fontSize: 10, color: Colors.redAccent),
                  ),
                ),
              ),
            Image.asset(
              icon,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 15),
              child: Text(
                title,
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

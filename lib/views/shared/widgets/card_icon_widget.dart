import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/material.dart';

class CardIconWidget extends StatelessWidget {
  final String title;
  final String icon;
  final Function()? onTap;
  final Function()? infoOnTap;
  final bool comingSoon;
  final Color? iconColor;

  const CardIconWidget(
      {required this.title,
      required this.icon,
      this.onTap,
      this.comingSoon = false,
      this.iconColor,
      this.infoOnTap});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: onTap,
      child: Ink(
        width: 140,
        height: 140,
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
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Constants.largeVerticalSpacer,
                  Image.asset(
                    icon,
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                    color: iconColor,
                    // Theme.of(context).colorScheme.secondary,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 10),
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  Constants.smallVerticalSpacer,
                  if (comingSoon)
                    const Text(
                      'به زودی',
                      style: TextStyle(fontSize: 10, color: Colors.redAccent),
                    ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: infoOnTap,
                )),
          ],
        ),
      ),
    );
  }
}

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/home_factor/home_factor_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      Get.off(const HomeFactorPage(), transition: Transition.noTransition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: Image.asset(
              splashIcon,
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            )),
            Shimmer.fromColors(
                baseColor: Colors.black,
                highlightColor: Colors.grey[300]!,
                child: const Text(
                  'فاکتور',
                  style: TextStyle(fontSize: 17),
                )),
            Constants.mediumVerticalSpacer,
          ],
        ),
      ),
    );
  }
}

import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Factor',
      locale: const Locale('fa', 'IR'),
      getPages: FactorPage.routes,
      initialRoute: FactorRoutes.splash,
      // home: const SplashPage(),
    );
  }
}

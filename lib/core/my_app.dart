import 'package:factor_flutter_mobile/controllers/more/more_controller.dart';
import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:factor_flutter_mobile/core/theme/factor_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MoreController());

    return GetMaterialApp(
      themeMode: ThemeMode.light,
      theme: FactorTheme.lightTheme,
      darkTheme: FactorTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      title: 'Factor',
      locale: const Locale('fa', 'IR'),
      getPages: FactorPage.routes,
      initialRoute: FactorRoutes.splash,
      // home: const SplashPage(),
    );
  }
}

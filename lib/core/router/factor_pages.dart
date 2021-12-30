import 'package:factor_flutter_mobile/core/authentication/splash/spalsh_page.dart';
import 'package:factor_flutter_mobile/views/home_factor/home_factor_page.dart';
import 'package:get/get.dart';

part 'factor_routes.dart';

class FactorPage {
  static const initial = FactorRoutes.home;

  static final List<GetPage> routes = [
    GetPage(name: FactorRoutes.home, page: () => const HomeFactorPage()),
    GetPage(name: FactorRoutes.splash, page: () => const SplashPage()),
  ];
}

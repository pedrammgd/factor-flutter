import 'package:factor_flutter_mobile/core/authentication/splash/spalsh_page.dart';
import 'package:factor_flutter_mobile/views/factor_base/factor_base_page.dart';
import 'package:factor_flutter_mobile/views/more/more_page.dart';
import 'package:get/get.dart';

part 'factor_routes.dart';

class FactorPage {
  static const initial = FactorRoutes.home;

  static final List<GetPage> routes = [
    GetPage(name: FactorRoutes.home, page: () =>  FactorBasePage(),transition:Transition.noTransition),
    GetPage(name: FactorRoutes.splash, page: () => const SplashPage()),
    GetPage(name: FactorRoutes.more, page: () => const MorePage(),transition:Transition.noTransition),
  ];
}

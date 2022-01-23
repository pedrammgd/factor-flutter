import 'package:factor_flutter_mobile/core/authentication/splash/spalsh_page.dart';
import 'package:factor_flutter_mobile/views/factor_base/factor_base_page.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial/factor_unofficial_page.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial_specification/factor_unofficial_specification_page.dart';
import 'package:factor_flutter_mobile/views/list_type_factor/list_type_factor_page.dart';
import 'package:factor_flutter_mobile/views/more/more_page.dart';
import 'package:get/get.dart';

part 'factor_routes.dart';

class FactorPage {
  static const initial = FactorRoutes.home;

  static final List<GetPage> routes = [
    GetPage(
      name: FactorRoutes.home,
      page: () => FactorBasePage(),
    ),
    GetPage(
      name: FactorRoutes.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: FactorRoutes.more,
      page: () => const MorePage(),
    ),
    GetPage(
        name: FactorRoutes.listTypeFactor,
        page: () => const ListTypeFactorPage(),
        transition: Transition.noTransition),
    GetPage(
        name: FactorRoutes.factorUnofficial,
        page: () => const FactorUnofficialPage(),
        transition: Transition.noTransition),
    GetPage(
        name: FactorRoutes.factorUnofficialSpecification,
        page: () => const FactorUnofficialSpecificationPage(),
        transition: Transition.noTransition)
  ];
}

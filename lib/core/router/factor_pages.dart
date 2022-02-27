import 'package:factor_flutter_mobile/core/authentication/splash/spalsh_page.dart';
import 'package:factor_flutter_mobile/views/buyer/buyer_page.dart';
import 'package:factor_flutter_mobile/views/factor_base/factor_base_page.dart';
import 'package:factor_flutter_mobile/views/factor_header/factor_header_page.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial/factor_unofficial_page.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial_specification/factor_unofficial_specification_page.dart';
import 'package:factor_flutter_mobile/views/list_type_factor/list_type_factor_page.dart';
import 'package:factor_flutter_mobile/views/more/more_page.dart';
import 'package:factor_flutter_mobile/views/my_profile/my_profile_page.dart';
import 'package:factor_flutter_mobile/views/subscription/subscription_page.dart';
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
        page: () => FactorUnofficialPage(),
        transition: Transition.noTransition),
    GetPage(
        name: FactorRoutes.factorUnofficialSpecification,
        page: () => FactorUnofficialSpecificationPage(),
        transition: Transition.noTransition),
    GetPage(
        name: FactorRoutes.myProfile,
        page: () => const MyProfilePage(),
        transition: Transition.noTransition),
    GetPage(
        name: FactorRoutes.buyer,
        page: () => const BuyerPage(),
        transition: Transition.noTransition),
    GetPage(
        name: FactorRoutes.subscription,
        page: () => const SubscriptionPage(),
        transition: Transition.noTransition),
    GetPage(
        name: FactorRoutes.factorHeader,
        page: () => const FactorHeaderPage(),
        transition: Transition.noTransition),
  ];
}

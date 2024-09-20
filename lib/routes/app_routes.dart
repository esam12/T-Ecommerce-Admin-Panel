import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/app.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';

class TAppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: TRoutes.firstScreen,
      page: () => const FirstScreen(),
    ),
    GetPage(
      name: TRoutes.secondScreen,
      page: () => const SecondScreen(),
    ),
    GetPage(
      name: TRoutes.secondScreenWithId,
      page: () => const SecondScreen(),
    ),
  ];
}

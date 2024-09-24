import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/device/device_utility.dart';

class SidebarController extends GetxController {
  final activteItem = TRoutes.login.obs;
  final hoverItem = ''.obs;

  void changeActiveItem(String route) => activteItem.value = route;

  void changeHoverItem(String route) {
    if (!isActive(route)) hoverItem.value = route;
  }

  bool isActive(String route) => activteItem.value == route;

  bool isHovering(String route) => hoverItem.value == route;

  void menuOnTap(String route) {
    if (!isActive(route)) {
      changeActiveItem(route);

      if (TDeviceUtils.isMobileScreen(Get.context!)) Get.back();

      Get.toNamed(route);
    }
  }
}

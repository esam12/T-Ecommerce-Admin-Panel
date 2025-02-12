import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/device/device_utility.dart';

class SidebarController extends GetxController {
  final activateItem = ''.obs; 
  final hoverItem = ''.obs;

  @override
  void onInit() {
    super.onInit();
    
    // Ensure the current route is part of sidebar items, otherwise fallback to default
    final currentRoute = Get.currentRoute;
    if (TRoutes.sidebarMenuItems.contains(currentRoute)) {
      activateItem.value = currentRoute;
    } else {
      activateItem.value = TRoutes.dashboard; // Fallback to dashboard
    }
  }

  void changeActiveItem(String route) => activateItem.value = route;

  void changeHoverItem(String route) {
    if (!isActive(route)) hoverItem.value = route;
  }

  bool isActive(String route) => activateItem.value == route;

  bool isHovering(String route) => hoverItem.value == route;

  void menuOnTap(String route) {
    if (!isActive(route)) {
      changeActiveItem(route);

      if (TDeviceUtils.isMobileScreen(Get.context!)) Get.back();

      Get.toNamed(route);
    }
  }
}

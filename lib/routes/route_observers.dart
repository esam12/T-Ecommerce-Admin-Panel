import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/layouts/sidebars/sidebar_controller.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';

class RouteObservers extends GetObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    final sidebarController = Get.put(SidebarController());

    if (previousRoute != null) {
      for (var routeName in TRoutes.sidebarMenuItems) {
        if (previousRoute.settings.name == routeName) {
          sidebarController.activteItem.value = routeName;
        }
      }
    }
  }
}

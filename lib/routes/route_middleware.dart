import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';

class TRouteMiddleware extends GetMiddleware {

  @override
  RouteSettings? redirect(String? route) {
    const isAuthenticated = false;
    return isAuthenticated ? null : const RouteSettings(name: TRoutes.firstScreen);
  }
  

}
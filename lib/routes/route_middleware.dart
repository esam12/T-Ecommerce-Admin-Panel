import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:t_ecommerce_admin_panel/routes/routes.dart';

class TRouteMiddleware extends GetMiddleware {

  @override
  RouteSettings? redirect(String? route) {
    const isAuthenticated = false;
    return isAuthenticated ? null : const RouteSettings(name: TRoutes.firstScreen);
  }
  

}
=======
import 'package:t_ecommerce_admin_panel/data/repositories/authentication/authentication_repository.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';

class TRouteMiddleware extends GetMiddleware {
  
  @override
  RouteSettings? redirect(String? route) {
    return AuthenticationRepository.instance.isAuthenticated
        ? null
        : const RouteSettings(name: TRoutes.login);
  }
}
>>>>>>> master

import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:t_ecommerce_admin_panel/app.dart';
=======
import 'package:t_ecommerce_admin_panel/features/media/screens/media.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/dashboard/dashboard_screen.dart';
import 'package:t_ecommerce_admin_panel/features/authentication/screens/forget_password/forget_password_screen.dart';
import 'package:t_ecommerce_admin_panel/features/authentication/screens/login/login_screen.dart';
import 'package:t_ecommerce_admin_panel/features/authentication/screens/reset_password/reset_password_screen.dart';
import 'package:t_ecommerce_admin_panel/routes/route_middleware.dart';
>>>>>>> master
import 'package:t_ecommerce_admin_panel/routes/routes.dart';

class TAppRoutes {
  static final List<GetPage> pages = [
    GetPage(
<<<<<<< HEAD
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
=======
      name: TRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: TRoutes.forgetPassword,
      page: () => const ForgetPasswordScreen(),
    ),
    GetPage(
      name: TRoutes.resetPassword,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(
      name: TRoutes.dashboard,
      page: () => const DashboardScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.media,
      page: () => const MediaScreen(),
      middlewares: [TRouteMiddleware()],
>>>>>>> master
    ),
  ];
}

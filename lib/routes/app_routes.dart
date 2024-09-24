import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/features/authentication/screens/dashboard/dashboard_screen.dart';
import 'package:t_ecommerce_admin_panel/features/authentication/screens/forget_password/forget_password_screen.dart';
import 'package:t_ecommerce_admin_panel/features/authentication/screens/login/login_screen.dart';
import 'package:t_ecommerce_admin_panel/features/authentication/screens/reset_password/reset_password_screen.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';

class TAppRoutes {
  static final List<GetPage> pages = [
    GetPage(
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
    )
  ];
}

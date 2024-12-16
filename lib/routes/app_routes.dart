import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/features/media/screens/media.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/category/all_categories/categories.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/category/create_category/create_category.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/category/edit_category/edit_category.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/dashboard/dashboard_screen.dart';
import 'package:t_ecommerce_admin_panel/features/authentication/screens/forget_password/forget_password_screen.dart';
import 'package:t_ecommerce_admin_panel/features/authentication/screens/login/login_screen.dart';
import 'package:t_ecommerce_admin_panel/features/authentication/screens/reset_password/reset_password_screen.dart';
import 'package:t_ecommerce_admin_panel/routes/route_middleware.dart';
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
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.media,
      page: () => const MediaScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // Categories
    GetPage(
      name: TRoutes.categories,
      page: () => const CategoriesScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.createCategory,
      page: () => const CreateCategoryScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.editCategory,
      page: () => const EditCategoryScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // Brands
  ];
}

import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/features/personalization/controllers/settings_controller.dart';
import 'package:t_ecommerce_admin_panel/features/personalization/controllers/user_controller.dart';
import 'package:t_ecommerce_admin_panel/utils/helpers/network_manager.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    /// -- Core
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => SettingsController());
  }
}

import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/features/authentication/controllers/user_controller.dart';
import 'package:t_ecommerce_admin_panel/utils/helpers/network_manager.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    /// -- Core
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
  }
}

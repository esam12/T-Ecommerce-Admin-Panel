import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:t_ecommerce_admin_panel/features/authentication/models/user_model.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/loaders.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  RxBool isLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }

  /// Fetches user details from the repository
  Future<UserModel> fetchUserDetails() async {
    try {
      isLoading.value = true;
      final userData = await userRepository.fetchAdminDetails();
      user.value = userData;
      isLoading.value = false;
      return userData;
    } catch (e) {
      isLoading.value = false;
      TLoaders.errorSnackBar(
          title: 'Something went wrong.', message: e.toString());
      return UserModel.empty();
    }
  }
}

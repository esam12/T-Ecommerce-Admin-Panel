import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:t_ecommerce_admin_panel/data/repositories/user/user_repository.dart';
import 'package:t_ecommerce_admin_panel/features/authentication/models/user_model.dart';

class CustomerController extends TBaseController<UserModel> {
  static CustomerController get instance => Get.find();

  final _customerRepository = Get.put(UserRepository());

  @override
  Future<List<UserModel>> fetchItems() async {
    return await _customerRepository.getAllUsers();
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (UserModel user) => user.fullName.toString().toLowerCase());
  }

  @override
  bool containSearchQuery(UserModel item, String query) {
    return item.fullName.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(UserModel item) async {
    await _customerRepository.deleteUser(item.id ?? '');
  }
}

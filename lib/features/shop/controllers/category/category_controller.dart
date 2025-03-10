import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:t_ecommerce_admin_panel/data/repositories/category/category_repository.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/category_model.dart';

class CategoryController extends TBaseController<CategoryModel> {
  static CategoryController get instance => Get.find();

  // Category Repository
  final _categoryRepository = Get.put(CategoryRepository());

  @override
  bool containSearchQuery(CategoryModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(CategoryModel item) async {
    await _categoryRepository.deleteCategory(item.id!);
  }

  @override
  Future<List<CategoryModel>> fetchItems() async {
    return await _categoryRepository.getAllCategories();
  }

  /// Sorting related code
  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (CategoryModel category) => category.name.toLowerCase());
  }
}

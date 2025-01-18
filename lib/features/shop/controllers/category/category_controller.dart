import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/data/repositories/category/category_repository.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  // Variables
  RxBool isLoading = true.obs;
  RxList<CategoryModel> allItems = <CategoryModel>[].obs;
  RxList<CategoryModel> filteredItems = <CategoryModel>[].obs;

  // Category Repository
  final _categoryRepository = Get.put(CategoryRepository());

  // Sorting
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<CategoryModel> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await _categoryRepository.getAllCategories();
      }
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);

      // Stop loading
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Sorting Methods
  void sortByName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    filteredItems.sort((a, b) {
      if (ascending) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      } else {
        return b.name.toLowerCase().compareTo(a.name.toLowerCase());
      }
    });
  }

  void sortByParentCategory(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    filteredItems.sort((a, b) {
      if (ascending) {
        return a.parentId.toLowerCase().compareTo(b.parentId.toLowerCase());
      } else {
        return b.parentId.toLowerCase().compareTo(a.parentId.toLowerCase());
      }
    });
  }
}

import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/category_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  // Variables
  RxBool isLoading = true.obs;
  RxList<CategoryModel> allItems = <CategoryModel>[].obs;
  RxList<CategoryModel> filteredItems = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void fetchData() {
    try {
      isLoading.value = true;
      if (allItems.isEmpty) {
        
      }
    } catch (e) {

    }
  }
}

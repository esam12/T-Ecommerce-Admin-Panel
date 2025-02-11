import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:t_ecommerce_admin_panel/data/repositories/brand/brand_repository.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/brand_model.dart';

class BrandsController extends TBaseController<BrandModel> {
  static BrandsController get instance => Get.find();
  final _brandRepository = Get.put(BrandRepository());
  final categoryController = Get.put(CategoryController());

  @override
  bool containSearchQuery(BrandModel item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(BrandModel item) async {
    await _brandRepository.deleteBrand(item);
  }

  @override
  Future<List<BrandModel>> fetchItems() async {
    // Fetch All Brands from Firestore
    final fetchBrands = await _brandRepository.fetchAllBrands();

    // Fetch all brand categories from the 'BrandCategories' collection
    final fetchBrandCategories = await _brandRepository.getAllBrandCategories();

    // Fetch all categories is data does not already exist
    if (categoryController.allItems.isNotEmpty) {
      await categoryController.fetchItems();
    }

    // Loop all brands and fetch categories of each
    for (var brand in fetchBrands) {
      // Extract categoryIds from the documents
      List<String> categoryIds = fetchBrandCategories
          .where((brandCategory) => brandCategory.brandId == brand.id)
          .map((brandCategory) => brandCategory.categoryId)
          .toList();

      brand.brandCategories = categoryController.allItems
          .where((element) => categoryIds.contains(element.id))
          .toList();
    }

    return fetchBrands;
  }

  /// Sorting related by name
  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (BrandModel brand) => brand.name.toLowerCase());
  }
}

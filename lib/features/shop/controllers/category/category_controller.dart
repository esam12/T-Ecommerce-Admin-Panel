import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/data/repositories/category/category_repository.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
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

  // Searching Text Field Controller
  final TextEditingController searchController = TextEditingController();

  // Selected Rows
  RxList<bool> selectedRows = <bool>[].obs;

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
      selectedRows.assignAll(List.generate(allItems.length, (_) => false));
      // Stop loading
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Search Methods
  void searchItems(String query) {
    if (query.isEmpty) {
      filteredItems.assignAll(allItems);
    } else {
      filteredItems.assignAll(allItems
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList());
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

  // Confirm and Remove Item
  void removeItemConfirmation(CategoryModel category) {
    Get.defaultDialog(
      title: 'Delete Item',
      content: const Text('Are you sure you want to delete this item?'),
      confirm: SizedBox(
          width: 60,
          child: ElevatedButton(
            style: OutlinedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: TSizes.buttonHeight / 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(TSizes.buttonRadius * 5),
              ),
            ),
            child: const Text('Ok'),
            onPressed: () async => await deleteOnConfirm(category),
          )),
      cancel: SizedBox(
        width: 60,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: TSizes.buttonHeight / 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(TSizes.buttonRadius * 5),
            ),
          ),
          child: const Text('Cancel'),
          onPressed: () => Get.back(),
        ),
      ),
    );
  }

  // Delete Item
  Future<void> deleteOnConfirm(CategoryModel category) async {
    try {
      // Remove the Confirmation Dialog
      TFullScreenLoader.stopLoading();

      // Show Loader
      TFullScreenLoader.popUpCircular();

      await _categoryRepository.deleteCategory(category.id!);

      removeItemFromLists(category);
      // Stop Loader
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Item Deleted',
        message: 'Your item has been successfully deleted.',
      );
    } catch (e) {
      // Stop Loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Method for removing an item from the lists.
  void removeItemFromLists(CategoryModel item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(allItems.length, (_) => false));
  }

  // Method for adding an item to the lists.
  void addItemToList(CategoryModel item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));

    filteredItems.refresh();
    allItems.refresh();
  }

  // Method for updating an item from the lists.
  void updateItemFromLists(CategoryModel item) {
    final itemIndex = allItems.indexWhere((element) => element == item);
    final filteredItemIndex =
        filteredItems.indexWhere((element) => element == item);

    if (itemIndex != -1) {
      allItems[itemIndex] = item;
    }
    if (filteredItemIndex != -1) {
      filteredItems[filteredItemIndex] = item;
    }
    filteredItems.refresh();
  }
}

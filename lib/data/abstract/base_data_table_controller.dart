import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/loaders.dart';

abstract class TBaseController<T> extends GetxController {
  RxBool isLoading = true.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<T> allItems = <T>[].obs;
  RxList<T> filteredItems = <T>[].obs;
  RxList<bool> selectRows = <bool>[].obs;
  final searchTextController = TextEditingController();

  /// Abstract method to be implemented by subclasses to fetching items.
  Future<List<T>> fetchItems();

  /// Abstract method to be implemented by subclasses to deleting an item.
  Future<void> deleteItem(T item);

  /// Abstract method to be implemented by subclasses for checking if an item contains the search query.
  bool containSearchQuery(T item, String query);

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  /// Common method for fetching data
  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<T> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await fetchItems();
      }
      allItems.assignAll(fetchedItems); // Assign fetched data to allItems
      filteredItems.assignAll(allItems); // Assign fetched data to filteredItems
      selectRows.assignAll(List.generate(
          allItems.length, (index) => false)); // Initialize selectRows
    } catch (e) {
      isLoading.value = false;
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Common method for searching based on a query
  void searchItems(String query) {
    filteredItems
        .assignAll(allItems.where((item) => containSearchQuery(item, query)));
  }

  // Common method for sorting items by a property
  void sortByProperty(
      int sortColumnIndex, bool ascending, Function(T) property) {
    sortAscending.value = ascending;
    this.sortColumnIndex.value = sortColumnIndex;
    filteredItems.sort((a, b) {
      if (ascending) {
        return property(a).compareTo(property(b));
      } else {
        return property(b).compareTo(property(a));
      }
    });
  }

  /// Method for adding an item to the lists.
  void addItemToList(T item) {
    allItems.add(item);
    filteredItems.add(item);
    selectRows.assignAll(List.generate(allItems.length, (index) => false));
  }

  /// Method for updating an item in the lists.
  void updateItemFromLists(T item) {
    final itemIndex = allItems.indexWhere((i) => i == item);
    final filteredItemIndex = filteredItems.indexWhere((i) => i == item);

    if (itemIndex != -1) {
      allItems[itemIndex] = item;
    }
    if (filteredItemIndex != -1) {
      filteredItems[filteredItemIndex] = item;
    }
  }

  /// Method for removing an item from the lists.
  void removeItemFromLists(T item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectRows.assignAll(List.generate(allItems.length, (index) => false));
  }

  /// Common Method for confirming deletion and performing the deletion
  Future<void> confirmAndDeleteItem(T item) async {
    // Show a confirmation dialog
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
          onPressed: () async => await deleteOnConfirm(item),
        ),
      ),
      cancel: SizedBox(
        width: 60,
        child: OutlinedButton(
          onPressed: () => Get.back(),
          style: OutlinedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: TSizes.buttonHeight / 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(TSizes.buttonRadius * 5),
            ),
          ),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  /// Method to be implemented by subclasses for handling confirmation before deleting an item
  Future<void> deleteOnConfirm(T item) async {
    try {
      // Remove the confirmation dialog
      TFullScreenLoader.stopLoading();

      // Start the loader
      TFullScreenLoader.popUpCircular();

      // Delete the item
      await deleteItem(item);

      removeItemFromLists(item);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
        title: 'Item Deleted',
        message: 'Your item has been successfully deleted.',
      );
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/data/repositories/category/category_repository.dart';
import 'package:t_ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:t_ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:t_ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/loaders.dart';

class EditCategoryController extends GetxController {
  static EditCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  /// Init Data
  void initData(CategoryModel category) {
    name.text = category.name;
    isFeatured.value = category.isFeatured;
    imageURL.value = category.image;
    if (category.parentId.isNotEmpty) {
      selectedParent.value = CategoryController.instance.allItems
          .where((element) => element.id == category.parentId)
          .single;
    }
  }

  /// Pick Thumbnail Image from Media

  /// Edit Category
  Future<void> updateCategory(CategoryModel category) async {
    try {
      // Show Loader
      TFullScreenLoader.popUpCircular();

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Stop Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        // Stop Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      // Map Data
      category.name = name.text.trim();
      category.image = imageURL.value;
      category.isFeatured = isFeatured.value;
      category.parentId = selectedParent.value.id!;
      category.updatedAt = DateTime.now();

      // Update Record
      await CategoryRepository.instance.updateCategory(category);

      //Update All Data List
      CategoryController.instance.updateItemFromLists(category);

      // Reset Fields
      resetFields();

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Success Message & Redirect
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'Edit Record has been completed.');
    } catch (e) {
      // Stop Loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Set the Selected image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Update the main image using the selectedImage
      imageURL.value = selectedImage.url;
    }
  }

  /// Reset Fields
  void resetFields() {
    name.clear();
    selectedParent(CategoryModel.empty());
    isFeatured(false);
    loading(false);
    imageURL.value = '';
  }
}

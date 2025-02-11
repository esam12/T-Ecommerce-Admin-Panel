import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/data/repositories/brand/brand_repository.dart';
import 'package:t_ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:t_ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/brand_category_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:t_ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/loaders.dart';

class CreateBrandController extends GetxController {
  static CreateBrandController get instance => Get.find();

  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  /// Toggle Category Selection
  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  /// Methods to reset fields
  void resetFields() {
    name.clear();
    loading(false);
    isFeatured(false);
    selectedCategories.clear();
    imageURL.value = '';
  }

  /// Pick Thumbnail Image from Media
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

  /// Register new Brand
  Future<void> createBrand() async {
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
      final newRecord = BrandModel(
        id: '',
        productCount: 0,
        name: name.text.trim(),
        image: imageURL.value,
        createdAt: DateTime.now(),
        isFeatured: isFeatured.value,
      );

      // Create Brand
      newRecord.id = await BrandRepository.instance.createBrand(newRecord);

      // Register brand categories if any
      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) {
          throw 'Error storing relational data, please try again';
        }

        // Loop Selected brand categories
        for (var category in selectedCategories) {
          // Map Data
          final brandCategory = BrandCategoryModel(
              brandId: newRecord.id, categoryId: category.id!);
          await BrandRepository.instance.createBrandCategory(brandCategory);
        }

        newRecord.brandCategories ??= [];
        newRecord.brandCategories!.addAll(selectedCategories);
      }

      // Update All data list
      BrandsController.instance.addItemToList(newRecord);

      // Reset Fields
      resetFields();

      // Stop Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnackBar(
          message: 'Success', title: 'New Record has been added.');
    } catch (e) {
      // Stop Loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(message: e.toString(), title: 'Error');
    }
  }
}

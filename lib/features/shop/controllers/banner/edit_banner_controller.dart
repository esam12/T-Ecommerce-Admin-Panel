import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/data/repositories/banner/banner_repository.dart';
import 'package:t_ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:t_ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/banner/banner_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:t_ecommerce_admin_panel/routes/app_screens.dart';
import 'package:t_ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/loaders.dart';

class EditBannerController extends GetxController {
  static EditBannerController instance = Get.find();

  final formKey = GlobalKey<FormState>();
  final imageUrl = ''.obs;
  final loading = false.obs;
  final isActive = false.obs;
  final RxString targetScreen = AppScreens.allAppScreens[0].obs;


  /// Init Data
  void init(BannerModel banner) {
    imageUrl.value = banner.imageUrl;
    isActive.value = banner.active;
    targetScreen.value = banner.targetScreen;

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
      imageUrl.value = selectedImage.url;
    }
  }

  /// Register new Banner
  Future<void> updateBanner(BannerModel banner) async {
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

      // Validate Form
      if (!formKey.currentState!.validate()) {
        // Stop Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      // Is Data Updated
      if (banner.imageUrl != imageUrl.value ||
          banner.active != isActive.value ||
          banner.targetScreen != targetScreen.value) {
            // Map Data
            banner.imageUrl = imageUrl.value;
            banner.active = isActive.value;
            banner.targetScreen = targetScreen.value;

            // Call Repository to Update
       await BannerRepository.instance.updateBanner(banner);

      }
      // Update All Data list
      BannerController.instance.updateItemFromLists(banner);

      // Stop Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnackBar(
          title: 'Success', message: 'Your Record has been updated.');
    } catch (e) {
      // Stop Loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

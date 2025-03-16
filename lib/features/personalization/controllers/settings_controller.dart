import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/data/repositories/settings/settings_repository.dart';
import 'package:t_ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:t_ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:t_ecommerce_admin_panel/features/personalization/models/settings_model.dart';
import 'package:t_ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/loaders.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  // Observable variables
  RxBool loading = false.obs;
  Rx<SettingsModel> settings = SettingsModel().obs;

  final formKey = GlobalKey<FormState>();
  final appNameController = TextEditingController();
  final taxController = TextEditingController();
  final shippingController = TextEditingController();
  final freeShippingThresholdController = TextEditingController();

  // Dependencies
  final settingRepository = Get.put(SettingsRepository());

  @override
  void onInit() {
    super.onInit();
    // Fetch setting details on controller initialization
    fetchSettingDetails();
  }

  /// Fetch setting details from the repository
  Future<SettingsModel> fetchSettingDetails() async {
    try {
      loading.value = true;
      final settings = await settingRepository.getSettings();
      this.settings.value = settings;

      appNameController.text = settings.appName;
      taxController.text = settings.taxRate.toString();
      shippingController.text = settings.shippingCost.toString();
      freeShippingThresholdController.text =
          settings.freeShippingThreshold == null
              ? ''
              : settings.freeShippingThreshold.toString();

      loading.value = false;

      return settings;
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Something went wrong.', message: e.toString());
      return SettingsModel();
    }
  }

  /// Pick Thumbnail Image from Media
  void updateAppLogo() async {
    try {
      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages =
          await controller.selectImagesFromMedia();

      // Handle the selected images
      if (selectedImages != null && selectedImages.isNotEmpty) {
        // Set the Selected image to the main image or perform any other action
        ImageModel selectedImage = selectedImages.first;

        // Update Profile in Firestore
        await settingRepository
            .updateSettingsSpecificValue({'appLogo': selectedImage.url});

        // Update the main image using the selectedImage
        settings.value.appLogo = selectedImage.url;
        settings.refresh();

        TLoaders.successSnackBar(
            title: 'Success', message: 'App Logo Updated Successfully');
      }

      loading.value = false;
    } catch (e) {
      loading.value = false;

      TLoaders.errorSnackBar(
          title: 'Something went wrong.', message: e.toString());
    }
  }

  void updateSettingInformation() async {
    try {
      loading.value = true;

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      settings.value.appName = appNameController.text.trim();
      settings.value.taxRate =
          double.tryParse(taxController.text.trim()) ?? 0.0;
      settings.value.shippingCost =
          double.tryParse(shippingController.text.trim()) ?? 0.0;
      settings.value.freeShippingThreshold =
          double.tryParse(freeShippingThresholdController.text.trim()) ?? 0.0;

      await settingRepository.updateSettings(settings.value);
      settings.refresh();

      loading.value = false;
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'App Settings Updated Successfully');
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(
          title: 'Something went wrong.', message: e.toString());
    }
  }
}

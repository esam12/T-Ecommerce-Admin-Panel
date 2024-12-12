import 'dart:typed_data';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/loaders/circular_loader.dart';
import 'package:t_ecommerce_admin_panel/data/repositories/media/media_repository.dart';

import 'package:t_ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:t_ecommerce_admin_panel/features/media/screens/media/widgets/media_content.dart';
import 'package:t_ecommerce_admin_panel/features/media/screens/media/widgets/media_uploader.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/text_strings.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/dialogs.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/loaders.dart';

class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  final RxBool loading = false.obs;
  final int initialLoadCount = 20;
  final int loadMoreCount = 25;

  late DropzoneViewController dropzoneViewController;
  final RxBool showImagesUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;

  final RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannerImages = <ImageModel>[].obs;
  final RxList<ImageModel> allProductImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> allUserImages = <ImageModel>[].obs;
  final MediaRepository mediaRepository = MediaRepository();

  // Get Images
  void getMediaImages() async {
    try {
      loading.value = true;

      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners &&
          allBannerImages.isEmpty) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.products &&
          allProductImages.isEmpty) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.brands &&
          allBrandImages.isEmpty) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories &&
          allCategoryImages.isEmpty) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.users &&
          allUserImages.isEmpty) {
        targetList = allUserImages;
      }

      final images = await mediaRepository.fetchImagesFromDatabase(
        selectedPath.value,
        initialLoadCount,
      );
      targetList.assignAll(images);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(
          title: 'Oh Snap!',
          message:
              'Unable to fetch Images, Something went wrong. Please try again later');
    }
  }

  // Load More Images
  void loadMoreMediaImages() async {
    try {
      loading.value = true;

      RxList<ImageModel> targetList = <ImageModel>[].obs;

      if (selectedPath.value == MediaCategory.banners &&
          allBannerImages.isEmpty) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.products &&
          allProductImages.isEmpty) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.brands &&
          allBrandImages.isEmpty) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories &&
          allCategoryImages.isEmpty) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.users &&
          allUserImages.isEmpty) {
        targetList = allUserImages;
      }

      final images = await mediaRepository.loadMoreImagesFromDatabase(
        selectedPath.value,
        initialLoadCount,
        targetList.last.createdAt ?? DateTime.now(),
      );
      targetList.addAll(images);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(
          title: 'Oh Snap!',
          message:
              'Unable to fetch Images, Something went wrong. Please try again later');
    }
  }

  Future<void> selectedLocalImages() async {
    final List<dynamic> files = await dropzoneViewController
        .pickFiles(multiple: true, mime: ['image/jpeg', 'image/png']);

    if (files.isNotEmpty) {
      for (var file in files) {
        final bytes = await dropzoneViewController.getFileData(file);
        final image = ImageModel(
          url: '',
          file: file,
          folder: '',
          filename: file.name,
          localImageToDisplay: Uint8List.fromList(bytes),
        );
        selectedImagesToUpload.add(image);
      }
    }
  }

  void uploadImagesConfirmation() {
    if (selectedPath.value == MediaCategory.folders) {
      TLoaders.warningSnackBar(
          title: 'Select Folder',
          message: 'Please select the Folder in Order to upload the Image');
      return;
    }

    TDialogs.defaultDialog(
      context: Get.context!,
      title: 'Upload Images',
      confirmText: 'Upload',
      onConfirm: () async => await uploadImages(),
      content:
          'Are you sure you want to upload all the Images in ${selectedPath.value.name.toUpperCase()} folder?',
    );
  }

  Future<void> uploadImages() async {
    try {
      // Remove confirmation box
      Get.back();

      // Loader
      uploadImagesLoader();

      // Get the selected category
      MediaCategory selectedCategory = selectedPath.value;

      // Get the corresponding list to update
      RxList<ImageModel> targetList;

      // Check the selected category and update the corresponding list
      switch (selectedCategory) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;
        default:
          return;
      }

      // Upload and add images to the target list
      // Using a reverse loop to avoid 'Concurrent modification during iteration' error
      for (int i = selectedImagesToUpload.length - 1; i >= 0; i--) {
        var selectedImage = selectedImagesToUpload[i];
        final image = selectedImage.file!;

        // Upload image to the Storage
        final ImageModel uploadedImage =
            await mediaRepository.uploadImageFileInStorage(
          file: image,
          path: getSelectedPath(),
          imageName: selectedImage.filename,
        );

        // Upload image to the Firestore
        uploadedImage.mediaCategory = selectedCategory.name;
        final id = await mediaRepository.uploadImagesInDatabase(uploadedImage);

        uploadedImage.id = id;

        selectedImagesToUpload.removeAt(i);
        targetList.add(uploadedImage);
      }
      // Stop Loader after Successful upload
      TFullScreenLoader.stopLoading();
    } catch (e) {
      // Stop Loader in case of an error
      TFullScreenLoader.stopLoading();

      // Show a Warning SnackBar for the error
      TLoaders.warningSnackBar(
        title: 'Error Uploading Images',
        message: 'Something went wrong while uploading your images',
      );
    }
  }

  void uploadImagesLoader() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Uploading Images'),
          content: Column(
            children: [
              Image.asset(TImages.uploadingImageIllustration,
                  height: 300, width: 300),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Text('Sit Tight, Your images are uploading...'),
            ],
          ),
        ),
      ),
    );
  }

  String getSelectedPath() {
    String path = '';
    switch (selectedPath.value) {
      case MediaCategory.banners:
        path = TTexts.bannersStoragePath;
        break;
      case MediaCategory.brands:
        path = TTexts.brandsStoragePath;
        break;
      case MediaCategory.categories:
        path = TTexts.categoriesStoragePath;
        break;
      case MediaCategory.products:
        path = TTexts.productsStoragePath;
        break;
      case MediaCategory.users:
        path = TTexts.usersStoragePath;
        break;
      default:
        path = 'Others';
    }
    return path;
  }

  /// Popup Confirmation to remove cloud image
  void removeCloudImageConfirmation(ImageModel image) {
    // Delete Confirmation
    TDialogs.defaultDialog(
      context: Get.context!,
      content: 'Are you sure you want to delete this image?',
      confirmText: 'Delete',
      onConfirm: () {
        // Close the previous dialog image popup
        Get.back();
        removeCloudImage(image);
      },
    );
  }

  void removeCloudImage(ImageModel image) async {
    try {
      // Close the removeCloudImageConfirmation() dialog
      Get.back();

      // Show Loader
      Get.defaultDialog(
        title: '',
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const PopScope(
          child:
              SizedBox(width: 150.0, height: 150.0, child: TCircularLoader()),
        ),
      );

      // Delete image
      await mediaRepository.deleteFileFromStorage(image);

      // Get the corresponding list to update
      RxList<ImageModel> targetList;

      // Check the selected category and update the corresponding list
      switch (selectedPath.value) {
        case MediaCategory.banners:
          targetList = allBannerImages;
          break;
        case MediaCategory.brands:
          targetList = allBrandImages;
          break;
        case MediaCategory.categories:
          targetList = allCategoryImages;
          break;
        case MediaCategory.products:
          targetList = allProductImages;
          break;
        case MediaCategory.users:
          targetList = allUserImages;
          break;
        default:
          return;
      }

      // Remove from the list
      targetList.remove(image);

      update();

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Image Deleted',
          message: 'Image Successfully Deleted From Your Cloud Storage');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    }
  }

  // Images Selection Bottom Sheet
  Future<List<ImageModel>?> selectImagesFromMedia({
    List<String>? selectedUrls,
    bool allowSelection = true,
    bool multipleSelection = false,
  }) async {
    showImagesUploaderSection.value = true;

    List<ImageModel>? selectedImages = await Get.bottomSheet<List<ImageModel>>(
      isScrollControlled: true,
      backgroundColor: TColors.primaryBackground,
      FractionallySizedBox(
        heightFactor: 1.0,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              TSizes.defaultSpace,
            ),
            child: Column(
              children: [
                const MediaUploader(),
                MediaContent(
                  allowSelection: allowSelection,
                  allowMultipleSelection: multipleSelection,
                  alreadySelectedUrls: selectedUrls ?? [],
                )
              ],
            ),
          ),
        ),
      ),
    );
    return selectedImages;
  }
}

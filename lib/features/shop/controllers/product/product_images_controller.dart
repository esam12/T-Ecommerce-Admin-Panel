import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:t_ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/product_variation_model.dart';

class ProductImagesController extends GetxController {
  static ProductImagesController get instance => Get.find();

  // Rx Observables for the selected thumbnail image
  Rx<String?> selectedThumbnailImage = Rx<String?>(null);

  // Lists to store additional product images
  final RxList<String> additionalProductImagesUrls = <String>[].obs;

  /// Pick Thumbnail Image from Media
  void selectThumbnailImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Set the Selected image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Update the main image using the selectedImage
      selectedThumbnailImage.value = selectedImage.url;
    }
  }

  /// Pick Thumbnail Image from Media
  void selectVariationImage(ProductVariationModel variation) async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Set the Selected image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Update the main image using the selectedImage
      variation.image.value = selectedImage.url;
    }
  }

  /// Pick Multiple Images from Media
  void selectMultipleProductImages() async {
    final controller = Get.put(MediaController());
    final selectedImages = await controller.selectImagesFromMedia(
      multipleSelection: true,
      selectedUrls: additionalProductImagesUrls,
    );

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      additionalProductImagesUrls
          .assignAll(selectedImages.map((image) => image.url));
    }
  }

  /// Function to remove Product image
  Future<void> removeImage(int index) async {
    additionalProductImagesUrls.removeAt(index);
  }
}

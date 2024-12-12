import 'package:get/get.dart';

class ProductImagesController extends GetxController {
  static ProductImagesController get instance => Get.find();

  // Rx Observables for the selected thumbnail image
  Rx<String?> selectedThumbnailImage = Rx<String?>(null);

  // Lists to store additional product images
  final RxList<String> additionalProductImagesUrls = <String>[].obs;

  /// Pick Thumbnail Image from Media
  void selectThumbnailImage() async {}

  /// Pick Multiple Images from Media
  void selectMultipleProductImages() async {}

  /// Function to remove Product image
  Future<void> removeImage(int index) async {}
}

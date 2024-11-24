import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';

class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  late DropzoneViewController dropzoneViewController;
  final RxBool showImagesUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
}

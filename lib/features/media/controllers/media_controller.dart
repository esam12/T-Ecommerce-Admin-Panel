import 'dart:typed_data';
import 'dart:async';

import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

import 'package:t_ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';

class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  late DropzoneViewController dropzoneViewController;
  final RxBool showImagesUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;

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
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/features/media/models/image_model.dart';

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  // Firebase Storage instance
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Upload any Image using File
  Future<ImageModel> uploadImageFileInStorage(
      {required Uint8List? file,
      required String path,
      required String imageName}) async {
    try {
      // Reference to the storage location
      final Reference ref = _storage.ref('$path/$imageName');

      // Upload the file
      await ref.putData(file!);

      // Get the download URL
      final String downloadURL = await ref.getDownloadURL();

      // Fetch metadata
      final FullMetadata fullMetadata = await ref.getMetadata();

      return ImageModel.fromFirebaseMetadata(
          fullMetadata, path, imageName, downloadURL);
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  /// Upload Images to Firestore
  Future<String> uploadImagesInDatabase(ImageModel image) async {
    try {
      await _db.collection('Images').doc().set(image.toJson());

      return image.id;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}

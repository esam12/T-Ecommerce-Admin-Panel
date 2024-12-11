import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';

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

  /// Fetch All Images from Firestore based on media category and load count
  Future<List<ImageModel>> fetchImagesFromDatabase(
      MediaCategory mediaCategory, int loadCount) async {
    try {
      final querySnapshot = await _db
          .collection('Images')
          .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
          .orderBy('createdAt', descending: true)
          .limit(loadCount)
          .get();
      return querySnapshot.docs
          .map((doc) => ImageModel.fromSnapshot(doc))
          .toList();
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

  /// Load more images from Firestore based on media category, load count, and last fetched date
  Future<List<ImageModel>> loadMoreImagesFromDatabase(
      MediaCategory mediaCategory,
      int loadCount,
      DateTime lastFetchedDate) async {
    try {
      final querySnapshot = await _db
          .collection('Images')
          .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
          .where('createdAt', isLessThan: lastFetchedDate)
          .orderBy('createdAt', descending: true)
          .startAfter([lastFetchedDate])
          .limit(loadCount)
          .get();

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
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

  // Delete file from Firebase Storage and corresponding document from Firestore
  Future<void> deleteFileFromStorage(ImageModel image) async {
    try {
      await _storage.ref(image.url).delete();
      await _db.collection('Images').doc(image.id).delete();
    } on FirebaseException catch (e) {
      throw e.message ??
          'Something went wrong while deleting image. Please try again';
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}

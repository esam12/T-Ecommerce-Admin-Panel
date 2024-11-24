import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:t_ecommerce_admin_panel/utils/formatters/formatter.dart';

class ImageModel {
  String id;
  final String url;
  final String folder;
  final int? sizeBytes;
  String mediaCategory;
  final String filename;
  final String? fullPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;

  // Not Mapped
  final String? file;
  RxBool isSelected = false.obs;
  final Uint8List? localImageToDisplay;

  ImageModel({
    this.id = '',
    required this.url,
    required this.folder,
    this.sizeBytes,
    this.mediaCategory = '',
    required this.filename,
    this.fullPath,
    this.createdAt,
    this.updatedAt,
    this.contentType,
    this.file,
    this.localImageToDisplay,
  });

  /// Static method to create a empty ImageModel
  static ImageModel empty() => ImageModel(url: '', folder: '', filename: '');

  String get createdAtFormatted => TFormatter.formatDate(createdAt);
  String get updatedAtFormatted => TFormatter.formatDate(updatedAt);

  /// Convert to Json to Store in DB
  Map<String, dynamic> toJson() => {
        'url': url,
        'folder': folder,
        'sizeBytes': sizeBytes,
        'mediaCategory': mediaCategory,
        'filename': filename,
        'fullPath': fullPath,
        'createdAt': createdAt?.toUtc(),
        'contentType': contentType,
      };

  /// Convert Firestore Document to ImageModel
  factory ImageModel.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // Map Json Record to the Model
      return ImageModel(
        id: document.id,
        url: data['url'] ?? '',
        folder: data['folder'] ?? '',
        sizeBytes: data['sizeBytes'] ?? 0,
        mediaCategory: data['mediaCategory'] ?? '',
        filename: data['filename'] ?? '',
        fullPath: data['fullPath'] ?? '',
        createdAt:
            data.containsKey('createdAt') ? data['createdAt'].toDate() : null,
        updatedAt:
            data.containsKey('updatedAt') ? data['updatedAt'].toDate() : null,
        contentType: data['contentType'] ?? '',
      );
    } else {
      return ImageModel.empty();
    }
  }

  /// Map Firebase Storage Data
  factory ImageModel.fromFirebaseMetadata(
    FullMetadata metadata,
    String folder,
    String filename,
    String downloadUrl,
  ) {
    return ImageModel(
      url: downloadUrl,
      folder: folder,
      filename: filename,
      sizeBytes: metadata.size,
      updatedAt: metadata.updated,
      fullPath: metadata.fullPath,
      createdAt: metadata.timeCreated,
      contentType: metadata.contentType,
    );
  }
}

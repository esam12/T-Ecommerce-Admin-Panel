import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_ecommerce_admin_panel/utils/formatters/formatter.dart';

class CategoryModel {
  final String id;
  final String name;
  final String image;
  final String parentId;
  final bool isFeatured;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured = false,
    this.parentId = '',
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => TFormatter.formatDate(createdAt);
  String get formattedUpdateDate => TFormatter.formatDate(updatedAt);

  /// Create Empty model
  static CategoryModel empty() => CategoryModel(
        id: '',
        name: '',
        image: '',
        isFeatured: false,
        parentId: '',
        createdAt: null,
        updatedAt: null,
      );

  /// Convert model to json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'isFeatured': isFeatured,
        'parentId': parentId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  /// Map Json oriented document snapshot from Firebase to userModel
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return CategoryModel(
        id: document.id,
        name: data['name'] ?? '',
        image: data['image'] ?? '',
        isFeatured: data['isFeatured'] ?? false,
        parentId: data['parentId'] ?? '',
        createdAt:
            data.containsKey('createdAt') ? data['createdAt'].toDate() : null,
        updatedAt:
            data.containsKey('updatedAt') ? data['updatedAt'].toDate() : null,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}

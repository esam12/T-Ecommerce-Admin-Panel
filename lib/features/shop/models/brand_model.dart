import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:t_ecommerce_admin_panel/utils/formatters/formatter.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool isFeatured;
  int? productCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  // Not mapped
  List<CategoryModel>? brandCategories;

  // Constructor
  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured = false,
    this.productCount,
    this.createdAt,
    this.updatedAt,
  });

  /// Empty helper Function
  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  String get formattedDate => TFormatter.formatDate(createdAt);
  String get formattedUpdatedDate => TFormatter.formatDate(updatedAt);

  /// Convert model to json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() => {
        'Id': id,
        'Name': name,
        'Image': image,
        'IsFeatured': isFeatured,
        'ProductCount': productCount = 0,
        'CreatedAt': createdAt,
        'UpdatedAt': updatedAt = DateTime.now(),
      };

  /// Map json oriented document snapshot from Firebase to model
  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return BrandModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        productCount: data['ProductCount'] ?? 0,
        createdAt:
            data.containsKey('CreatedAt') ? data['CreatedAt']?.toDate() : null,
        updatedAt:
            data.containsKey('UpdatedAt') ? data['UpdatedAt']?.toDate() : null,
      );
    } else {
      return BrandModel.empty();
    }
  }

  /// Map Json oriented document snapshot from Firebase to model
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      productCount: data['ProductCount'] ?? 0,
      createdAt:
          data.containsKey('CreatedAt') ? data['CreatedAt']?.toDate() : null,
      updatedAt:
          data.containsKey('UpdatedAt') ? data['UpdatedAt']?.toDate() : null,
    );
  }
}

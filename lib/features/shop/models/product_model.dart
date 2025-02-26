import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/product_attribute_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/product_variation_model.dart';
import 'package:t_ecommerce_admin_panel/utils/formatters/formatter.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? categoryId;
  String productType;
  String? description;
  List<String>? images;
  int soldQuantity;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.stock,
    required this.price,
    required this.title,
    required this.productType,
    required this.thumbnail,
    this.brand,
    this.sku,
    this.date,
    this.salePrice = 0.0,
    this.isFeatured,
    this.categoryId,
    this.description,
    this.images,
    this.soldQuantity = 0,
    this.productAttributes,
    this.productVariations,
  });

  /// Get formatted date
  String get formattedDate => TFormatter.formatDate(date);

  /// Create empty func for clean code
  static ProductModel empty() => ProductModel(
      id: '', stock: 0, price: 0.0, title: '', productType: '', thumbnail: '');

  /// Json Format
  Map<String, dynamic> toJson() => {
        'Stock': stock,
        'Price': price,
        'Title': title,
        'ProductType': productType,
        'Thumbnail': thumbnail,
        'Brand': brand!.toJson(),
        'SKU': sku,
        'Date': date,
        'SalePrice': salePrice,
        'IsFeatured': isFeatured,
        'CategoryId': categoryId,
        'Description': description,
        'Images': images ?? [],
        'SoldQuantity': soldQuantity,
        'ProductAttributes': productAttributes != null
            ? productAttributes!.map((e) => e.toJson()).toList()
            : [],
        'ProductVariations': productVariations != null
            ? productVariations!.map((e) => e.toJson()).toList()
            : [],
      };

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      title: data['Title'],
      price: double.parse((data['Price'] ?? 0.0).toString()),
      sku: data['SKU'],
      stock: data['Stock'] ?? 0,
      soldQuantity:
          data.containsKey('SoldQuantity') ? data['SoldQuantity'] ?? 0 : 0,
      isFeatured: data['IsFeatured'] ?? false,
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: BrandModel.fromJson(data['Brand']),
      images: data['images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }

  /// Map Json-oriented document snapshot from Firebase to Model
  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
      return ProductModel(
      id: document.id,
      title: data['Title'],
      price: double.parse((data['Price'] ?? 0.0).toString()),
      sku: data['SKU'],
      stock: data['Stock'] ?? 0,
      soldQuantity:
          data.containsKey('SoldQuantity') ? data['SoldQuantity'] ?? 0 : 0,
      isFeatured: data['IsFeatured'] ?? false,
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: BrandModel.fromJson(data['Brand']),
      images: data['images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList(),
      productVariations: (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList(),
    );
  }
}

import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ProductVariationModel {
  final String id;
  String sku;
  Rx<String> image;
  String? description;
  double price;
  double salePrice;
  int stock;
  int soldQuantity;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    String image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    this.soldQuantity = 0,
    required this.attributeValues,
  }) : image = image.obs;

  /// Create empty func for clean code
  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

  // Json Format
  Map<String, dynamic> toJson() => {
        'Id': id,
        'SKU': sku,
        'Image': image,
        'Description': description,
        'Price': price,
        'SalePrice': salePrice,
        'Stock': stock,
        'SoldQuantity': soldQuantity,
        'AttributeValues': attributeValues,
      };

  // Map Json oriented document snapshot From Firebase to model
  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductVariationModel.empty();

    return ProductVariationModel(
      id: data['Id'] ?? '',
      sku: data['SKU'] ?? '',
      image: data['Image'] ?? '',
      description: data['Description'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      stock: data['Stock'] ?? 0,
      soldQuantity: data['SoldQuantity'] ?? 0,
      attributeValues: Map<String, String>.from(data['AttributeValues']),
    );
  }
}

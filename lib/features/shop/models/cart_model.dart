class CartItemModel {
  String productId;
  String title;
  String? image;
  int quantity;
  double price;
  String variationId;
  String? brandName;
  Map<String, String>? selectedVariation;

  CartItemModel({
    required this.productId,
    required this.quantity,
    this.title = '',
    this.image,
    this.price = 0.0,
    this.variationId = '',
    this.brandName,
    this.selectedVariation,
  });

  /// Calculate Total Amount
  String get totalAmount => (price * quantity).toStringAsFixed(1);

  /// Empty Cart Item
  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  /// Convert CartItemModel to a JSON Map
  Map<String, dynamic> toJson() => {
        'ProductId': productId,
        'Title': title,
        'Image': image,
        'Quantity': quantity,
        'Price': price,
        'VariationId': variationId,
        'BrandName': brandName,
        'SelectedVariation': selectedVariation,
      };

  /// Create a CartItem from a Json Map
  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        productId: json['ProductId'] ?? '',
        title: json['Title'] ?? '',
        image: json['Image'] ?? '',
        quantity: json['Quantity'] ?? 0,
        price: json['Price']?.toDouble() ?? 0.0,
        variationId: json['VariationId'] ?? '',
        brandName: json['BrandName'] ?? '',
        selectedVariation: json['SelectedVariation'] != null
            ? Map.from(json['SelectedVariation'])
            : null,
      );
}

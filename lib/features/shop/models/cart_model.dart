class CartItemModel {
  final String id;
  final String title;
  final String? image;
  final int quantity;
  final double price;
  final num totalAmount;
  final Map<String, dynamic>? selectedVariation;

  CartItemModel({
    required this.id,
    required this.title,
    this.image,
    required this.quantity,
    required this.price,
    required this.totalAmount,
    this.selectedVariation,
  });
}

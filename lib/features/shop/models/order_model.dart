import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/address_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/cart_model.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String userId;
  final String docId;
  OrderStatus orderStatus;
  final num totalAmount;
  final double shippingCost;
  final double taxCost;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? shippingAddress;
  final AddressModel? billingAddress;
  final List<CartItemModel> items;
  final DateTime? deliveryDate;
  final bool billingAddressSameAsShipping;

  OrderModel({
    required this.id,
    this.userId = '',
    this.docId = '',
    required this.orderStatus,
    required this.items,
    required this.totalAmount,
    required this.shippingCost,
    required this.taxCost,
    required this.orderDate,
    this.paymentMethod = "Cash on Delivery",
    this.shippingAddress,
    this.billingAddress,
    this.deliveryDate,
    this.billingAddressSameAsShipping = true,
  });

  /// Date formatters
  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  /// User-friendly status
  String get orderStatusText {
    switch (orderStatus) {
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.shipped:
        return 'Shipment on the way';
      case OrderStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Processing';
    }
  }

  /// Default empty order
  static OrderModel empty() {
    return OrderModel(
      id: '',
      userId: '',
      docId: '',
      orderStatus: OrderStatus.pending,
      totalAmount: 0,
      shippingCost: 0,
      taxCost: 0,
      orderDate: DateTime.now(),
      items: [],
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'orderStatus': orderStatus.name,
      'totalAmount': totalAmount,
      'shippingCost': shippingCost,
      'taxCost': taxCost,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'shippingAddress': shippingAddress?.toJson(),
      'billingAddress': billingAddress?.toJson(),
      'billingAddressSameAsShipping': billingAddressSameAsShipping,
      'items': items.map((e) => e.toJson()).toList(),
      'deliveryDate': deliveryDate,
    };
  }

  /// Create from Firestore snapshot
  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    print('Order status from DB: ${data['orderStatus']}');
    return OrderModel(
      id: data['id'] ?? '',
      userId: data['userId'] ?? '',
      docId: snapshot.id,
      orderStatus: data.containsKey('orderStatus')
          ? OrderStatus.values.firstWhere(
              (e) => e.toString() == data['orderStatus'],
              orElse: () => OrderStatus.pending,
            )
          : OrderStatus.pending,
      totalAmount: data['totalAmount'] ?? 0,
      shippingCost: (data['shippingCost'] ?? 0).toDouble(),
      taxCost: (data['taxCost'] ?? 0).toDouble(),
      orderDate: (data['orderDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      paymentMethod: data['paymentMethod'] ?? 'Cash on Delivery',
      shippingAddress: data['shippingAddress'] != null
          ? AddressModel.fromMap(data['shippingAddress'])
          : null,
      billingAddress: data['billingAddress'] != null
          ? AddressModel.fromMap(data['billingAddress'])
          : null,
      billingAddressSameAsShipping:
          data['billingAddressSameAsShipping'] ?? true,
      items: (data['items'] as List<dynamic>?)
              ?.map((e) => CartItemModel.fromJson(e))
              .toList() ??
          [],
      deliveryDate: data['deliveryDate'] != null
          ? (data['deliveryDate'] as Timestamp).toDate()
          : null,
    );
  }
}

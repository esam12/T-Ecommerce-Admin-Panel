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

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => orderStatus == OrderStatus.delivered
      ? 'Delivered'
      : orderStatus == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Processing';

  // static function to create an empty order
  static OrderModel empty() {
    return OrderModel(
      id: '',
      userId: '',
      docId: '',
      orderStatus: OrderStatus.pending,
      totalAmount: 0,
      orderDate: DateTime.now(),
      shippingCost: 0,
      taxCost: 0,
      items: [],
      deliveryDate: null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'docId': docId,
        'orderStatus': orderStatus.name,
        'totalAmount': totalAmount,
        'orderDate': orderDate,
        'paymentMethod': paymentMethod,
        'shippingCost': shippingCost,
        'taxCost': taxCost,
        'shippingAddress': shippingAddress?.toJson(),
        'billingAddress': billingAddress?.toJson(),
        'billingAddressSameAsShipping': billingAddressSameAsShipping,
        'items': items.map((e) => e.toJson()).toList(),
        'deliveryDate': deliveryDate,
      };

  // From snapshot
  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return OrderModel(
      id: data['id'],
      userId: data['userId'],
      docId: data['docId'],
      orderStatus: OrderStatus.values.byName(data['orderStatus']),
      totalAmount: data['totalAmount'],
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'],
      shippingCost: data['shippingCost'],
      taxCost: data['taxCost'],
      shippingAddress: data['shippingAddress'] != null
          ? AddressModel.fromSnapshot(data['shippingAddress'])
          : null,
      billingAddress: data['billingAddress'] != null
          ? AddressModel.fromSnapshot(data['billingAddress'])
          : null,
      billingAddressSameAsShipping: data['billingAddressSameAsShipping'],
      items: data['items'] != null
          ? List<CartItemModel>.from(
              data['items'].map((e) => CartItemModel.fromJson(e)))
          : [],
      deliveryDate: data['deliveryDate'] != null
          ? (data['deliveryDate'] as Timestamp).toDate()
          : null,
    );
  }
}


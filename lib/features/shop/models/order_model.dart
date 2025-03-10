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
        'orderStatus': orderStatus.toString(),
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
      id: data.containsKey('id') ? data['id'] as String : '',
      userId: data.containsKey('userId') ? data['userId'] as String : '',
      docId: snapshot.id,
      orderStatus: data.containsKey('orderStatus')
          ? OrderStatus.values.firstWhere(
              (element) => element.toString() == data['orderStatus'])
          : OrderStatus.pending,
      totalAmount:
          data.containsKey('totalAmount') ? data['totalAmount'] as num : 0,
      shippingCost: data.containsKey('shippingCost')
          ? (data['shippingCost'] as num).toDouble()
          : 0,
      taxCost:
          data.containsKey('taxCost') ? (data['taxCost'] as num).toDouble() : 0,
      orderDate: data.containsKey('orderDate')
          ? (data['orderDate'] as Timestamp).toDate()
          : DateTime.now(),
      paymentMethod: data.containsKey('paymentMethod')
          ? data['paymentMethod'] as String
          : "",
      billingAddressSameAsShipping:
          data.containsKey('billingAddressSameAsShipping')
              ? data['billingAddressSameAsShipping'] as bool
              : true,
      shippingAddress: data.containsKey('shippingAddress')
          ? AddressModel.fromMap(
              data['shippingAddress'] as Map<String, dynamic>)
          : AddressModel.empty(),
      billingAddress: data.containsKey('billingAddress')
          ? AddressModel.fromMap(data['billingAddress'] as Map<String, dynamic>)
          : AddressModel.empty(),
      items: data.containsKey('items')
          ? (data['items'] as List<dynamic>)
              .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      deliveryDate:
          data.containsKey('deliveryDate') && data['deliveryDate'] != null
              ? (data['deliveryDate'] as Timestamp).toDate()
              : null,
    );
  }
}

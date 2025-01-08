import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String userId;
  final String docId;

  final OrderStatus orderStatus;
  final num totalAmount;
  final DateTime orderDate;
  final PaymentMethods paymentMethod;
  // final AddressModel address;
  // final List<CartItemModel> items;
  final DateTime? deliveryDate;

  OrderModel({
    required this.id,
    this.userId = '',
    this.docId = '',
    required this.orderStatus,
    // required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = PaymentMethods.paypal,
    // this.address,
    this.deliveryDate,
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
      paymentMethod: PaymentMethods.paypal,
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
        'paymentMethod': paymentMethod.name,
        'deliveryDate': deliveryDate,
      };
}

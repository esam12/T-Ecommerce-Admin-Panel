import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';

class OrderModel {
  final String id;
  final OrderStatus orderStatus;
  final int totalAmount;
  final DateTime orderDate;
  final DateTime deliveryDate;

  OrderModel({
    required this.id,
    required this.orderStatus,
    required this.totalAmount,
    required this.orderDate,
    required this.deliveryDate,
  });
}

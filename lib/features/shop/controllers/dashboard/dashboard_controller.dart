import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/helpers/helper_functions.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final RxList<double> weeklySales = <double>[].obs;

  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> orderStatusAmount =
      <OrderStatus, double>{}.obs;

  /// -- Order
  static final List<OrderModel> orders = [
    OrderModel(
      id: 'CS-0001',
      orderStatus: OrderStatus.processing,
      totalAmount: 256,
      orderDate: DateTime(2024, 10, 29),
      deliveryDate: DateTime(2024, 11, 25),
    ),
    OrderModel(
      id: 'CS-0002',
      orderStatus: OrderStatus.pending,
      totalAmount: 75,
      orderDate: DateTime(2024, 11, 01),
      deliveryDate: DateTime(2024, 11, 21),
    ),
    OrderModel(
      id: 'CS-0003',
      orderStatus: OrderStatus.pending,
      totalAmount: 150,
      orderDate: DateTime(2024, 10, 31),
      deliveryDate: DateTime(2024, 11, 22),
    ),
    OrderModel(
      id: 'CS-0004',
      orderStatus: OrderStatus.delivered,
      totalAmount: 270,
      orderDate: DateTime(2024, 11, 02),
      deliveryDate: DateTime(2024, 11, 25),
    ),
    OrderModel(
      id: 'CS-0005',
      orderStatus: OrderStatus.cancelled,
      totalAmount: 325,
      orderDate: DateTime(2024, 11, 03),
      deliveryDate: DateTime(2024, 11, 25),
    ),
    OrderModel(
      id: 'CS-0006',
      orderStatus: OrderStatus.shipped,
      totalAmount: 150,
      orderDate: DateTime(2024, 11, 04),
      deliveryDate: DateTime(2024, 11, 26),
    ),
  ];

  @override
  void onInit() {
    _calculateWeeklySales();
    _calculateOrderStatusDate();
    super.onInit();
  }

  // Calculates weekly sales
  void _calculateWeeklySales() {
    // Reset weeklySales to zeros
    weeklySales.value = List<double>.filled(7, 0.0);

    for (var order in orders) {
      final DateTime orderWeekStart =
          THelperFunctions.getStartOfWeek(order.orderDate);

      // check if the order is within the current week
      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(const Duration(days: 7)).isAfter(DateTime.now())) {
        int index = (order.orderDate.weekday - 1) % 7;

        // Ensure index is non-negative
        index = index < 0 ? index + 7 : index;

        weeklySales[index] += order.totalAmount;
      }
    }
  }

  /// Call this function to Calculate order status counts
  void _calculateOrderStatusDate() {
    // Reset status data
    orderStatusData.clear();

    // Map to store total amounts for each status
    orderStatusAmount.value = {
      for (var status in OrderStatus.values) status: 0.0
    };

    for (var order in orders) {
      // Count Orders
      final status = order.orderStatus;
      orderStatusData[status] = (orderStatusData[status] ?? 0) + 1;

      // Calculate total amount for each status
      orderStatusAmount[status] =
          (orderStatusAmount[status] ?? 0) + order.totalAmount;
    }
  }

  String getDisplayStatusName(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}

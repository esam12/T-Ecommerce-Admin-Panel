import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:t_ecommerce_admin_panel/data/repositories/order/order_repository.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/loaders.dart';

class OrderController extends TBaseController<OrderModel> {
  static OrderController get instance => Get.find();

  RxBool statusLoader = false.obs;
  var orderStatus = OrderStatus.delivered.obs;
  final _orderRepository = Get.put(OrderRepository());

  @override
  Future<List<OrderModel>> fetchItems() async {
    sortAscending.value = false;
    return await _orderRepository.getAllOrders();
  }

  @override
  bool containSearchQuery(OrderModel item, String query) {
    return item.id.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(OrderModel item) async {
    await _orderRepository.deleteOrder(item.docId);
  }

  void sortById(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (OrderModel order) => order.totalAmount.toString().toLowerCase());
  }

  void sortByDate(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (OrderModel order) => order.orderDate.toString().toLowerCase());
  }

  /// Update Product Status
  Future<void> updateOrderStatus(
      OrderModel order, OrderStatus newStatus) async {
    try {
      statusLoader.value = true;
      order.orderStatus = newStatus;
      await _orderRepository.updateOrderSpecificValue(
          order.docId, {'orderStatus': newStatus.toString()});
      updateItemFromLists(order);
      orderStatus.value = newStatus;
      TLoaders.successSnackBar(
          title: 'Updated', message: 'Order Status Updated');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      statusLoader.value = false;
    }
  }
}

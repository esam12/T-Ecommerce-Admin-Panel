import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/order/order_controller.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/helpers/helper_functions.dart';

class OrdersRows extends DataTableSource {
  final controller = OrderController.instance;
  @override
  DataRow? getRow(int index) {
    final order = controller.filteredItems[index];

    return DataRow2(
      onTap: () => Get.toNamed(TRoutes.orderDetails,
          arguments: order, parameters: {'orderId': order.id}),
      selected: controller.selectRows[index],
      onSelectChanged: (value) => controller.selectRows[index] = value ?? false,
      cells: [
        DataCell(
          Text(
            order.id,
            style: Theme.of(Get.context!)
                .textTheme
                .bodyLarge!
                .apply(color: TColors.primary),
          ),
        ),
        DataCell(Text(order.formattedOrderDate)),
        DataCell(Text('${order.items.length} Items')),
        DataCell(
          TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
                horizontal: TSizes.md, vertical: TSizes.sm),
            backgroundColor:
                THelperFunctions.getOrderStatusColor(order.orderStatus)
                    .withValues(alpha: 0.1),
            child: Text(
              order.orderStatus.name.capitalize.toString(),
              style: TextStyle(
                color: THelperFunctions.getOrderStatusColor(order.orderStatus),
              ),
            ),
          ),
        ),
        DataCell(Text('\$${order.totalAmount}')),
        DataCell(TTableActionButtons(
          view: true,
          edit: false,
          onViewPressed: () => Get.toNamed(TRoutes.orderDetails,
              arguments: order, parameters: {'orderId': order.id}),
          onDeletePressed: () => controller.confirmAndDeleteItem(order),
        ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount =>
      controller.selectRows.where((selected) => selected).length;
}

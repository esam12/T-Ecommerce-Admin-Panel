import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/helpers/helper_functions.dart';

class OrderRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    final order = DashboardController.orders[index];
    return DataRow2(
      cells: [
        DataCell(
          Text(
            order.id,
            style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(
                  color: TColors.primary,
                ),
          ),
        ),
        DataCell(Text(order.formattedOrderDate)),
        const DataCell(Text('5 Items')),
        DataCell(
          TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
                horizontal: TSizes.md, vertical: TSizes.xs),
            backgroundColor:
                THelperFunctions.getOrderStatusColor(order.orderStatus)
                    .withOpacity(0.1),
            child: Text(
              order.orderStatus.name.capitalize.toString(),
              style: TextStyle(
                color: THelperFunctions.getOrderStatusColor(order.orderStatus),
              ),
            ),
          ),
        ),
        DataCell(Text('\$${order.totalAmount}')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => DashboardController.orders.length;

  @override
  int get selectedRowCount => 0;
}

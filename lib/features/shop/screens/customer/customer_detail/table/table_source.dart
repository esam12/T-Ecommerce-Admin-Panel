import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/helpers/helper_functions.dart';

class CustomerOrdersRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    final order = OrderModel(
      id: '1',
      orderStatus: OrderStatus.delivered,
      orderDate: DateTime.now(),
      items: [],
      totalAmount: 0,
      userId: '',
      docId: '',
      shippingCost: 0,
      taxCost: 0,
    );
    const totalAmount = '2563.5';

    return DataRow2(
      selected: false,
      onTap: () => Get.toNamed(TRoutes.customerDetails, arguments: order),
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
        const DataCell(Text('${5} Items')),
        DataCell(
          TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
                vertical: TSizes.sm, horizontal: TSizes.md),
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
        const DataCell(
          Text(
            '\$$totalAmount',
            style: TextStyle(color: TColors.secondary),
          ),
        )
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 5;

  @override
  int get selectedRowCount => 0;
}

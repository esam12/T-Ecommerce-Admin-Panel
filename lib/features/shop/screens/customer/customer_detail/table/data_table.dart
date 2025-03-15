import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/customer/customer_detail_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/customer/customer_detail/table/table_source.dart';
import 'package:t_ecommerce_admin_panel/utils/device/device_utility.dart';

class CustomerOrderTable extends StatelessWidget {
  const CustomerOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;

    return Obx(
      () {
        Text(controller.filteredCustomerOrders.length.toString());
        Text(controller.selectedRows.length.toString());

        return TPaginatedDataTable(
          minWidth: 550,
          tableHeight: 640,

          dataRowHeight: kMinInteractiveDimension,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
             DataColumn2(label:const Text('Order ID'),onSort: (columnIndex, ascending) => controller.sortById(columnIndex, ascending)), 
            const DataColumn2(label: Text('Date')),
            const DataColumn2(label: Text('Items')),
            DataColumn2(
              label: const Text('Status'),
              fixedWidth: TDeviceUtils.isMobileScreen(context) ? 100 : null,
            ),
            const DataColumn2(label: Text('Amount'), numeric: true),
          ],
          source: CustomerOrdersRows(),
        );
      },
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/circular_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/helpers/helper_functions.dart';

class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Orders Status",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Graph
          Obx(
            () => controller.orderStatusData.isNotEmpty
                ? SizedBox(
                    height: 400,
                    child: PieChart(
                      PieChartData(
                        sections:
                            controller.orderStatusData.entries.map((entry) {
                          final status = entry.key;
                          final count = entry.value;
                          return PieChartSectionData(
                            title: count.toString(),
                            value: count.toDouble(),
                            radius: 100,
                            color: THelperFunctions.getOrderStatusColor(status),
                            titleStyle: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: TColors.white,
                            ),
                          );
                        }).toList(),
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            // Handle touch events here if needed
                          },
                          enabled: true,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [TLoaderAnimation()],
                    ),
                  ),
          ),

          // Show status and color meta
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => DataTable(
                columns: const [
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Orders')),
                  DataColumn(label: Text('Total')),
                ],
                rows: controller.orderStatusData.entries.map((entry) {
                  final OrderStatus status = entry.key;
                  final int count = entry.value;
                  final totalAmount = controller.totalAmouts[status] ?? 0.0;
                  final String displayStatus =
                      controller.getDisplayStatusName(status);
                  return DataRow(
                    cells: [
                      DataCell(
                        Row(
                          children: [
                            TCircularContainer(
                              width: 20,
                              height: 20,
                              backgroundColor:
                                  THelperFunctions.getOrderStatusColor(status),
                            ),
                            Expanded(child: Text(' $displayStatus'))
                          ],
                        ),
                      ),
                      DataCell(Text(count.toString())),
                      DataCell(
                        Text(
                          '\$${totalAmount.toStringAsFixed(2)}',
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

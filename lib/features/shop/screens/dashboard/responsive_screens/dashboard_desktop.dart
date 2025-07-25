import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/dashboard/table/data_table.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/dashboard/widgets/dashboard_card.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/dashboard/widgets/order_status_pie_chart.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/dashboard/widgets/weekly_sales_graph.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class DashboardDesktop extends StatelessWidget {
  const DashboardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              Text('Dashboard',
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Cards
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => TDashboardCard(
                        context: context,
                        headingIcon: Iconsax.note,
                        headingIconColor: Colors.blue,
                        headingBgColor: Colors.blue.withValues(alpha: 0.1),
                        title: 'Sales total',
                        subTitle:
                            '\$${controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount).toStringAsFixed(2)}',
                        stats: 25,
                      ),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: Obx(
                      () => TDashboardCard(
                        context: context,
                        headingIcon: Iconsax.external_drive,
                        headingIconColor: Colors.green,
                        headingBgColor: Colors.green.withValues(alpha: 0.1),
                        title: 'Average Order Value',
                        subTitle:
                            '\$${(controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount) / controller.orderController.allItems.length).toStringAsFixed(2)}',
                        stats: 15,
                      ),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: Obx(
                      () => TDashboardCard(
                        context: context,
                        headingIcon: Iconsax.box,
                        headingIconColor: Colors.deepPurple,
                        headingBgColor:
                            Colors.deepPurple.withValues(alpha: 0.1),
                        title: 'Total Orders',
                        subTitle:
                            '${controller.orderController.allItems.length}',
                        stats: 44,
                      ),
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(
                    child: TDashboardCard(
                      context: context,
                      headingIcon: Iconsax.user,
                      headingIconColor: Colors.deepOrange,
                      headingBgColor: Colors.deepOrange.withValues(alpha: 0.1),
                      title: 'Visitors',
                      subTitle: controller.customerController.allItems.length
                          .toString(),
                      stats: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Graphs
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        /// Bar Graph
                        const TWeeklySalesGraph(),

                        const SizedBox(height: TSizes.spaceBtwSections),

                        /// Orders
                        TRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recent Orders',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: TSizes.spaceBtwSections),
                              const DashboardOrderTable(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),

                  /// Pie Chart
                  const Expanded(
                    child: OrderStatusPieChart(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

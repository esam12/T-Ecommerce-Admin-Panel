import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/dashboard/table/data_table.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/dashboard/widgets/dashboard_card.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/dashboard/widgets/order_status_pie_chart.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/dashboard/widgets/weekly_sales_graph.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class DashboardMobile extends StatelessWidget {
  const DashboardMobile({super.key});

  @override
  Widget build(BuildContext context) {
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
              const TDashboardCard(
                title: 'Sales total',
                subTitle: '\$365.6',
                stats: 25,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TDashboardCard(
                title: 'Average Order Value',
                subTitle: '\$25.0',
                stats: 15,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              const TDashboardCard(
                title: 'Total Orders',
                subTitle: '36',
                stats: 44,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TDashboardCard(
                title: 'Visitors',
                subTitle: '25,035',
                stats: 2,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Bar Graph
              const TWeeklySalesGraph(),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// Orders
              TRoundedContainer(
                child: Column(
                  children: [
                    Text(
                      'Recent Orders',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),
                    const DashboardOrderTable(),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Pie Chart
              const OrderStatusPieChart(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/order/order_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/order/all_orders/table/data_table.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class OrderMobileScreen extends StatelessWidget {
  const OrderMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbWithHeading(
                heading: 'Orders',
                breadcrumbItems: ['Orders'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              
              // Table Body
              TRoundedContainer(
                child: Column(
                  children: [
                    const TTableHeader(showLeftWidget: false),
                    const SizedBox(height: TSizes.spaceBtwItems),

                   // Table
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const TLoaderAnimation();
                      }
                      return const OrderTable();
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
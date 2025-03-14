import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/customer/customer_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/customer/all_customers/table/data_table.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class CustomerDesktopScreen extends StatelessWidget {
  const CustomerDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbWithHeading(
                heading: 'Customers',
                breadcrumbItems: ['Customers'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              TRoundedContainer(
                child: Column(
                  children: [
                    TTableHeader(
                      showLeftWidget: false,
                      searchController: controller.searchTextController,
                      searchOnChanged: (query) => controller.searchItems(query),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    // Table
                    const CustomerTable(),
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

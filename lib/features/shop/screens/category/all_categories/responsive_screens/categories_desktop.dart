import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/category/all_categories/table/data_table.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class CategoriesDesktop extends StatelessWidget {
  const CategoriesDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbWithHeading(
                heading: 'Categories',
                breadcrumbItems: ['Categories'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Table Body
              //   Obx(() {
              // Show Loader
              //return
              TRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    TTableHeader(
                      buttonText: 'Create New Category',
                      onPressed: () => Get.toNamed(TRoutes.createCategory),

                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    // Table
                    const CategoryTable()
                  ],
                ),
              ),
              //  })
            ],
          ),
        ),
      ),
    );
  }
}

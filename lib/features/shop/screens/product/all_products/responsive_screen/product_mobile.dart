import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/product/all_products/table/data_table.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/product/product_controller.dart';


class ProductMobileScreen extends StatelessWidget {
  const ProductMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbWithHeading(
                heading: 'Products',
                breadcrumbItems: ['Products'],
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              //return
              Obx(
                () {
                  // Show Loader
                  if (controller.isLoading.value) {
                    return const TLoaderAnimation();
                  }

                  return TRoundedContainer(
                    child: Column(
                      children: [
                        // Table Header
                        TTableHeader(
                          buttonText: 'Create New Product',
                          onPressed: () => Get.toNamed(TRoutes.createProduct),
                          searchController: controller.searchTextController,
                          searchOnChanged: (query) =>
                              controller.searchItems(query),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        // Table
                        const ProductTable()
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );  }
}
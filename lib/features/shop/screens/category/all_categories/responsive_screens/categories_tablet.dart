import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/category/all_categories/table/data_table.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class CategoriesTablet extends StatelessWidget {
  const CategoriesTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

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
                      searchController: controller.searchTextController,
                      searchOnChanged: (query) => controller.searchItems(query),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    // Table
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const TLoaderAnimation();
                      }
                      return const CategoryTable();
                    })
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

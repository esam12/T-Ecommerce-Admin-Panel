import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/brand/all_brands/table/data_table.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class BrandsTabletScreen extends StatelessWidget {
  const BrandsTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandsController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbWithHeading(
                heading: 'Brands',
                breadcrumbItems: ['Brands'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Table Body

              TRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    TTableHeader(
                      buttonText: 'Create New Brand',
                      onPressed: () => Get.toNamed(TRoutes.createBrand),
                      searchController: controller.searchTextController,
                      searchOnChanged: (query) => controller.searchItems(query),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),

                    // Table
                    Obx(() {
                      // Show Loader
                      if (controller.isLoading.value) {
                        return const TLoaderAnimation();
                      }
                      return const BrandTable();
                    }),
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

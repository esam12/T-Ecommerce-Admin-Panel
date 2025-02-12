import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/banner/banner_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/banner/all_banners/table/data_table.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class BannersDesktopScreen extends StatelessWidget {
  const BannersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbWithHeading(
                heading: 'Banners',
                breadcrumbItems: ['Banners'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              Obx(() {
                // Show Loader
                if (controller.isLoading.value) {
                  return const TLoaderAnimation();
                }
                // Table Body
                return TRoundedContainer(
                  child: Column(
                    children: [
                      // Table Header
                      TTableHeader(
                        buttonText: 'Create New Banner',
                        onPressed: () => Get.toNamed(TRoutes.createBanner),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      // Table
                      const BannerTable()
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

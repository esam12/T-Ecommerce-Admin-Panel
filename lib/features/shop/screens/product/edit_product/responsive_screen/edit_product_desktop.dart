import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';

import '../widgets/bottom_navigation_widget.dart';
import '../widgets/stock_pricing_widget.dart';
import '../widgets/title_description.dart';
import '../widgets/variations_widget.dart';
import '../widgets/visibility_widget.dart';
import '../widgets/product_type_widget.dart';
import '../widgets/attributes_widget.dart';
import '../widgets/thumbnail_widget.dart';
import '../widgets/additional_images.dart';
import '../widgets/brand_widget.dart';
import '../widgets/categories_widget.dart';

class EditProductDesktopScreen extends StatelessWidget {
  const EditProductDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const ProductBottomNavigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Edit Product',
                breadcrumbItems: [TRoutes.products, 'Edit Product'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Create Product
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: TDeviceUtils.isTabletScreen(context) ? 2 : 3,
                    child: Column(
                      children: [
                        // Basic Information
                        const ProductTitleAndDescription(),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Stock & Pricing
                        TRoundedContainer(
                          child: Column(
                            children: [
                              // Heading
                              Text('Stock & Pricing',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              const SizedBox(height: TSizes.spaceBtwItems),

                              // Product Type
                              const ProductTypeWidget(),
                              const SizedBox(height: TSizes.spaceBtwItems),

                              // Stock
                              const ProductStockAndPricing(),
                              const SizedBox(height: TSizes.spaceBtwSections),

                              // Attributes
                              const ProductAttributes(),
                              const SizedBox(height: TSizes.spaceBtwSections),
                            ],
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Variations
                        const ProductVariations(),
                      ],
                    ),
                  ),
                  const SizedBox(width: TSizes.defaultSpace),

                  // Sidebar
                  Expanded(
                    child: Column(
                      children: [
                        // Product Thumbnail
                        const ProductThumbnailImage(),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Product Images
                        TRoundedContainer(
                          child: Column(
                            children: [
                              Text('All Product Images',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              const SizedBox(height: TSizes.spaceBtwItems),
                              ProductAdditionalImages(
                                additionalProductImagesURLs:
                                    RxList<String>.empty(),
                                onTapToAddImages: () {},
                                onTapToRemoveImage: (index) {},
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Product Brand
                        const ProductBrand(),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Product Categories
                        const ProductCategories(),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Product Visibility
                        const ProductVisibilityWidget(),
                        const SizedBox(height: TSizes.spaceBtwSections),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

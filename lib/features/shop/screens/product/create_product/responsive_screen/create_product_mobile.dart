import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/product/create_product/widgets/product_type_widget.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/product/create_product/widgets/title_description.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class CreateProductMobileScreen extends StatelessWidget {
  const CreateProductMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: const ProductBottomNavigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Create Product',
                breadcrumbItems: [TRoutes.products, 'Create Product'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Create Product
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        // Product Type
                         const ProductTypeWidget(),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        // Stock
                        // const ProductStockAndPricing(),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Attributes
                        // const ProductAttributes(),
                        const SizedBox(height: TSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Variations
                  // const ProductVariations(),
                  const SizedBox(height: TSizes.defaultSpace),

                  // Product Thumbnail
                  // const ProductThumbnailImage(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Product Images
                  TRoundedContainer(
                    child: Column(
                      children: [
                        Text('All Product Images',
                            style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        // ProductAdditionalImages(
                        //   additionalProductImages: RxList<String>.empty(),
                        //   onTapToAddImages(){},
                        //   onTapToRemoveImages(index){},
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Product Brand
                  // const ProductBrand(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Product Categories
                  // const ProductCategories(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Product Visibility
                  // const ProductVisibility(),
                  const SizedBox(height: TSizes.spaceBtwSections)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

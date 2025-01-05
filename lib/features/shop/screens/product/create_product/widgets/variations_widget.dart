import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Variations Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Product Variations',
                  style: Theme.of(context).textTheme.headlineSmall),
              TextButton(
                onPressed: () {},
                child: const Text('Remove Variations'),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Variations List
          ListView.separated(
            itemCount: 2,
            shrinkWrap: true,
            separatorBuilder: (_, __) =>
                const SizedBox(height: TSizes.spaceBtwItems),
            itemBuilder: (_, index) {
              return _buildVariationTile();
            },
          ),

          // No Variation Message
          _buildNoVariationMessage(),
        ],
      ),
    );
  }

  // Helper Method to build a variation tile
  Widget _buildVariationTile() {
    return ExpansionTile(
      backgroundColor: TColors.lightGrey,
      collapsedBackgroundColor: TColors.lightGrey,
      childrenPadding: const EdgeInsets.all(TSizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
      ),
      title: const Text('Color: Green'),
      children: [
        // Upload Variation Image
        Obx(
          () => TImageUploader(
            right: 0,
            left: null,
            imageType: ImageType.asset,
            image: TImages.defaultImage,
            onIconButtonPressed: () {},
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // Variation Stock & Price
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                    labelText: 'Stock',
                    hintText: 'Add Stock, only numbers are allowed'),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),

            // Price
            Expanded(
              child: TextFormField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,2}'),
                  ),
                ],
                decoration: const InputDecoration(
                    labelText: 'Price',
                    hintText: 'Price with up-to 2 decimals'),
              ),
            ),
          ],
        ),
        const SizedBox(width: TSizes.spaceBtwInputFields),

        // Variation Description
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Description',
            hintText: 'Add Description of this variation...',
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwSections),
      ],
    );
  }

  // Helper Method to build no variation message
  Widget _buildNoVariationMessage() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TRoundedImage(
                width: 200,
                height: 200,
                imageType: ImageType.asset,
                image: TImages.defaultVariationImageIcon),
          ],
        ),
         SizedBox(width: TSizes.spaceBtwItems),
         Text('There are no variations added for this product'),

      ],
    );
  }
}

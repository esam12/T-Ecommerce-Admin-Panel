import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: TSizes.sm),
            Text('Create New Banner',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Image Uploader & Featured Checkbox
            Column(
              children: [
                GestureDetector(
                  child: const TRoundedImage(
                    width: 400,
                    height: 200,
                    backgroundColor: TColors.primaryBackground,
                    image: TImages.defaultImage,
                    imageType: ImageType.asset,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                TextButton(onPressed: () {}, child: const Text('Select Image')),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            Text('Make your Banner Active or Inactive',
                style: Theme.of(context).textTheme.bodyMedium),
            CheckboxMenuButton(
              value: true,
              onChanged: (value) {},
              child: const Text('Active'),
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            // Dropdown Menu Screens
            DropdownButton<String>(
              value: 'search',
              onChanged: (String? newValue) {},
              items: const [
                DropdownMenuItem(value: 'home', child: Text('Home')),
                DropdownMenuItem(value: 'search', child: Text('Search')),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwItems * 2),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Create'),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwItems * 2),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/chips/rounded_choice_chips.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/validators/validation.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key});

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
            Text('Create New Brand',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Name Text Field
            TextFormField(
              validator: (value) => TValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                labelText: 'Brand Name',
                prefixIcon: Icon(
                  Iconsax.box,
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Categories
            Text('Select Categories',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),
            Wrap(
              spacing: TSizes.sm,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: TSizes.sm,
                  ),
                  child: TChoiceChip(
                    text: 'Shoes',
                    selected: true,
                    onSelected: (value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: TSizes.sm,
                  ),
                  child: TChoiceChip(
                    text: 'Track Suits',
                    selected: false,
                    onSelected: (value) {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields * 2),

            // Image Uploader & Featured Checkbox
            TImageUploader(
              width: 80,
              height: 80,
              image: TImages.defaultImage,
              imageType: ImageType.asset,
              onIconButtonPressed: () {},
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            CheckboxMenuButton(
              value: true,
              onChanged: (value) {},
              child: const Text('Featured'),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields * 2),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Create'),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}

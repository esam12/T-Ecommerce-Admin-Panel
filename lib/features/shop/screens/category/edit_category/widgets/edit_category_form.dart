import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/category/edit_category_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/validators/validation.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final editController = Get.put(EditCategoryController());
    final categoryController = CategoryController.instance;
    editController.initData(category);

    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: editController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: TSizes.sm),
            Text('Update Category',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Name Text Field
            TextFormField(
              controller: editController.name,
              validator: (value) => TValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                labelText: 'Category Name',
                prefixIcon: Icon(
                  Iconsax.category,
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            Obx(
              () => DropdownButtonFormField(
                decoration: const InputDecoration(
                  hintText: 'Parent Category',
                  labelText: 'Parent Category',
                  prefixIcon: Icon(Iconsax.bezier),
                ),
                value: editController.selectedParent.value.id!.isNotEmpty
                    ? editController.selectedParent.value
                    : category,
                items: categoryController.allItems.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(category.name),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (newValue) =>
                    editController.selectedParent.value = newValue!,
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields * 2),
            Obx(
              () => TImageUploader(
                width: 80,
                height: 80,
                image: editController.imageURL.value.isNotEmpty
                    ? editController.imageURL.value
                    : TImages.defaultImage,
                imageType: editController.imageURL.value.isNotEmpty
                    ? ImageType.network
                    : ImageType.asset,
                onIconButtonPressed: () => editController.pickImage(),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            Obx(
              () => CheckboxMenuButton(
                value: editController.isFeatured.value,
                onChanged: (value) =>
                    editController.isFeatured.value = value ?? false,
                child: const Text('Featured'),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields * 2),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => editController.updateCategory(category),
                child: const Text('Update'),
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}

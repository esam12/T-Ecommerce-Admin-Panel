import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/product/create_product_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:t_ecommerce_admin_panel/utils/validators/validation.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers
    final productController = CreateProductController.instance;
    final attributeController = Get.put(ProductAttributesController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return productController.productType.value == ProductType.single
              ? const Column(
                  children: [
                    Divider(color: TColors.primaryBackground),
                    SizedBox(height: TSizes.spaceBtwSections),
                  ],
                )
              : const SizedBox.shrink();
        }),

        Text('Add Product Attributes',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: TSizes.spaceBtwItems),

        // Form to add new attributes
        Form(
          key: attributeController.attributesFormKey,
          child: TDeviceUtils.isDesktopScreen(context)
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildAttributeName(attributeController),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    Expanded(
                      flex: 2,
                      child: _buildAttributeTextField(attributeController),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    _buildAttributeAddButton(attributeController),
                  ],
                )
              : Column(
                  children: [
                    _buildAttributeName(attributeController),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    _buildAttributeTextField(attributeController),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    _buildAttributeAddButton(attributeController),
                  ],
                ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        // List of added attributes
        Text('All Attributes',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: TSizes.spaceBtwItems),

        // Display added attributes in a rounded container
        TRoundedContainer(
          backgroundColor: TColors.primaryBackground,
          child: Obx(
            () => attributeController.productAttributes.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    itemCount: attributeController.productAttributes.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: TSizes.spaceBtwItems),
                    itemBuilder: (_, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: TColors.white,
                          borderRadius:
                              BorderRadius.circular(TSizes.borderRadiusLg),
                        ),
                        child: ListTile(
                          title: Text(attributeController
                                  .productAttributes[index].name ??
                              ''),
                          subtitle: Text(attributeController
                              .productAttributes[index].values!
                              .map((e) => e.trim())
                              .toString()),
                          trailing: IconButton(
                            onPressed: () => attributeController
                                .removeAttribute(index, context),
                            icon: const Icon(
                              Iconsax.trash,
                              color: TColors.error,
                            ),
                          ),
                        ),
                      );
                    })
                : const Column(
                    children: [
                      // buildAttributesList(context),
                      // buildEmptyAttributes(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TRoundedImage(
                            width: 150,
                            height: 80,
                            imageType: ImageType.asset,
                            image: TImages.defaultAttributeColorsImageIcon,
                          )
                        ],
                      ),
                      SizedBox(height: TSizes.spaceBtwItems),
                      Text("There are no attributes added for this product"),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        // Generate Variations Button
        Obx(
          () => productController.productType.value == ProductType.variable ? Center(
            child: SizedBox(
              width: 200,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Iconsax.activity),
                label: const Text('Generate Variations'),
              ),
            ),
          ) : const SizedBox.shrink(),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }

  // Build text form field for attribute name
  TextFormField _buildAttributeName(ProductAttributesController controller) {
    return TextFormField(
      controller: controller.attributeName,
      validator: (value) =>
          TValidator.validateEmptyText('Attribute Name', value),
      decoration: const InputDecoration(
        labelText: 'Attribute Name',
        hintText: 'Colors, Sizes, etc.',
      ),
    );
  }

  // Build text form field for attribute value
  SizedBox _buildAttributeTextField(ProductAttributesController controller) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        expands: true,
        maxLines: null,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        controller: controller.attributes,
        validator: (value) =>
            TValidator.validateEmptyText('Attribute Field', value),
        decoration: const InputDecoration(
          labelText: 'Attributes',
          hintText: 'Add attributes separated by |  Ex: Red | Blue | Green',
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  // Build button to add a new a attribute
  SizedBox _buildAttributeAddButton(ProductAttributesController controller) {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () => controller.addNewAttribute(),
        icon: const Icon(Iconsax.add),
        style: ElevatedButton.styleFrom(
          foregroundColor: TColors.black,
          backgroundColor: TColors.secondary,
          side: const BorderSide(color: TColors.secondary),
        ),
        label: const Text('Add'),
      ),
    );
  }

  // Build Empty Attributes List
  Widget buildEmptyAttributes() {
    return const Column(
      children: [
        Row(
          children: [
            TRoundedImage(
                width: 150,
                height: 80,
                imageType: ImageType.asset,
                image: TImages.defaultAttributeColorsImageIcon)
          ],
        ),
        SizedBox(height: TSizes.spaceBtwItems),
        Text('There are no attributes added for this product'),
      ],
    );
  }

  // Build Attributes List
  ListView buildAttributesList(BuildContext context) {
    return ListView.separated(
      itemCount: 3,
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
            color: TColors.white,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          ),
          child: ListTile(
            title: const Text('Color'),
            subtitle: const Text('Green, Blue, Red'),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Iconsax.trash,
                color: TColors.error,
              ),
            ),
          ),
        );
      },
    );
  }
}

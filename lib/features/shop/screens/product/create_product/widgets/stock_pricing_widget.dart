import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/product/create_product_controller.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/validators/validation.dart';

class ProductStockAndPricing extends StatelessWidget {
  const ProductStockAndPricing({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;
    return Obx(
      () => controller.productType.value == ProductType.single
          ? Form(
              key: controller.stockPriceFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stock
                  FractionallySizedBox(
                    widthFactor: 0.45,
                    child: TextFormField(
                      controller: controller.stock,
                      decoration: const InputDecoration(
                        labelText: 'Stock',
                        hintText: 'Add Stock, only numbers are allowed',
                      ),
                      validator: (value) =>
                          TValidator.validateEmptyText('Stock', value),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  // Pricing
                  Row(
                    children: [
                      // Price
                      Expanded(
                        child: TextFormField(
                          controller: controller.price,
                          decoration: const InputDecoration(
                            labelText: 'Price',
                            hintText: 'Price with up-to 2 decimals',
                          ),
                          validator: (value) =>
                              TValidator.validateEmptyText('Price', value),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                        ),
                      ),

                      const SizedBox(height: TSizes.spaceBtwItems),

                      // Sale Price
                      Expanded(
                        child: TextFormField(
                          controller: controller.salePrice,
                          decoration: const InputDecoration(
                            labelText: 'Discounted Price',
                            hintText: 'Price with up-to 2 decimals',
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

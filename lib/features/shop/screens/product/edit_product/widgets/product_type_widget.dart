import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Product Type', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(width: TSizes.spaceBtwItems),

        // Radio Button For Single Product Type
        RadioMenuButton(
          value: ProductType.single,
          groupValue: ProductType.single,
          onChanged: (value) {},
          child: const Text('Single'),
        ),

        // Radio Button For Variable Product Type
        RadioMenuButton(
          value: ProductType.variable,
          groupValue: ProductType.single,
          onChanged: (value) {},
          child: const Text('Variable'),
        ),
      ],
    );
  }
}

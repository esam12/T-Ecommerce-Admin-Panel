import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class ProductVisibilityWidget extends StatelessWidget {
  const ProductVisibilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        children: [
          // Visibility Label
          Text(
            'Visibility',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Radio Buttons for product visibility
          Column(
            children: [
              _buildVisibilityRadioButtons(
                  ProductVisibility.published, 'Published'),
              _buildVisibilityRadioButtons(ProductVisibility.hidden, 'Hidden'),
            ],
          )
        ],
      ),
    );
  }

  // Helper method to build radio buttons for product visibility
  Widget _buildVisibilityRadioButtons(ProductVisibility value, String label) {
    return RadioMenuButton(
      value: value,
      groupValue: ProductVisibility.published,
      onChanged: (selection) {},
      child: Text(label),
    );
  }
}

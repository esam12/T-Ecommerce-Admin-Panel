import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/features/personalization/controllers/settings_controller.dart';

import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.symmetric(
              vertical: TSizes.lg, horizontal: TSizes.md),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('App Settings',
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: TSizes.spaceBtwSections),

                // App Name
                TextFormField(
                  controller: controller.appNameController,
                  decoration: const InputDecoration(
                    hintText: 'App Name',
                    label: Text('App Name'),
                    prefixIcon: Icon(
                      Iconsax.user,
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                Row(
                  children: [
                    // Tax Rate
                    Expanded(
                      child: TextFormField(
                        controller: controller.taxController,
                        decoration: const InputDecoration(
                          hintText: 'Tax %',
                          label: Text('Tax Rate (%)'),
                          prefixIcon: Icon(
                            Iconsax.tag,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),

                    // Shipping Cost
                    Expanded(
                      child: TextFormField(
                        controller: controller.shippingController,
                        decoration: const InputDecoration(
                          hintText: 'Shipping Cost',
                          label: Text('Shipping Cost (\$)'),
                          prefixIcon: Icon(
                            Iconsax.ship,
                          ),
                        ),
                      ),
                    ),

                    // Free Shipping
                    Expanded(
                      child: TextFormField(
                        controller: controller.freeShippingThresholdController,
                        decoration: const InputDecoration(
                          hintText: 'Free Shipping After',
                          label: Text('Free Shipping Threshold (\$)'),
                          prefixIcon: Icon(
                            Iconsax.ship,
                          ),
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: TSizes.spaceBtwInputFields),
              ],
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        // Update Button
        SizedBox(
          width: double.infinity,
          child: Obx(
            () => ElevatedButton(
              onPressed: () => controller.loading.value
                  ? () {}
                  : controller.updateSettingInformation(),
              child: controller.loading.value
                  ? const CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2)
                  : const Text('Update Profile'),
            ),
          ),
        ),
      ],
    );
  }
}

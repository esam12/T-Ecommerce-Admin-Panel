import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/features/personalization/controllers/user_controller.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/validators/validation.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    controller.firstNameController.text = controller.user.value.firstName;
    controller.lastNameController.text = controller.user.value.lastName;
    controller.phoneController.text = controller.user.value.phoneNumber;

    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.symmetric(
              vertical: TSizes.lg, horizontal: TSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Profile Details',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: TSizes.spaceBtwSections),

              // First and Last Name
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        // First Name
                        Expanded(
                          child: TextFormField(
                            controller: controller.firstNameController,
                            decoration: const InputDecoration(
                              hintText: 'First Name',
                              labelText: 'First Name',
                              prefixIcon: Icon(
                                Iconsax.user,
                              ),
                            ),
                            validator: (value) => TValidator.validateEmptyText(
                                'First Name', value),
                          ),
                        ),
                        const SizedBox(width: TSizes.spaceBtwInputFields),

                        // Last Name
                        Expanded(
                          child: TextFormField(
                            controller: controller.lastNameController,
                            decoration: const InputDecoration(
                              hintText: 'Last Name',
                              labelText: 'Last Name',
                              prefixIcon: Icon(
                                Iconsax.user,
                              ),
                            ),
                            validator: (value) => TValidator.validateEmptyText(
                                'Last Name', value),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: TSizes.spaceBtwInputFields),

                    // Email and Phone
                    Row(
                      children: [
                        // Email
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              labelText: 'Email',
                              prefixIcon: Icon(Iconsax.forward),
                              enabled: false,
                            ),
                          ),
                        ),
                        const SizedBox(width: TSizes.spaceBtwItems),

                        // Phone
                        Expanded(
                          child: TextFormField(
                            controller: controller.phoneController,
                            decoration: const InputDecoration(
                              hintText: 'Phone Number',
                              labelText: 'Phone Number',
                              prefixIcon: Icon(
                                Iconsax.mobile,
                              ),
                            ),
                            validator: (value) => TValidator.validateEmptyText(
                                'Phone Number', value),
                          ),
                        ),
                      ],
                    ),
                  ],
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
                        : controller.updateUserInformation(),
                    child: controller.loading.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Update Profile'),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

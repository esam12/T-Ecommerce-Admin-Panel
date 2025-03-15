import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:t_ecommerce_admin_panel/features/authentication/models/user_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/customer/customer_detail_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/address_model.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    controller.getCustomerAddresses();
    return Obx(() {
      if (controller.addressesLoading.value) {
        return const TLoaderAnimation();
      }

      AddressModel selectedAddress = AddressModel.empty();

      if (controller.customer.value.addresses != null) {
        if (controller.customer.value.addresses!.isNotEmpty) {
          selectedAddress = controller.customer.value.addresses!.where((address) => address.selectedAddress).single;
        }
      }
      
      return TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shipping Address',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwSections),
            Row(
              children: [
                const SizedBox(
                  width: 120,
                  child: Text('Name'),
                ),
                const Text(':'),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(
                    selectedAddress.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Row(
              children: [
                const SizedBox(
                  width: 120,
                  child: Text('Country'),
                ),
                const Text(':'),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(
                    selectedAddress.country,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Row(
              children: [
                const SizedBox(
                  width: 120,
                  child: Text('Phone Number'),
                ),
                const Text(':'),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(
                    selectedAddress.phoneNumber,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Row(
              children: [
                const SizedBox(
                  width: 120,
                  child: Text('Address'),
                ),
                const Text(':'),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(
                    selectedAddress.id.isNotEmpty ? selectedAddress.toString() : '',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

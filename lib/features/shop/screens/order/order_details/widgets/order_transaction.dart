import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/helpers/helper_functions.dart';

class OrderTransaction extends StatelessWidget {
  const OrderTransaction({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Transactions',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.spaceBtwSections),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const TRoundedImage(
                        imageType: ImageType.asset, image: TImages.paypal),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Payment via ${THelperFunctions.capitalize(
                              order.paymentMethod.toString(),
                            )}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            '${THelperFunctions.capitalize(order.paymentMethod.toString())} fee \$25',
                            style: Theme.of(context).textTheme.labelMedium,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('Date',
                        style: Theme.of(context).textTheme.labelMedium),
                    Text('April 20, 2025',
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('Total',
                        style: Theme.of(context).textTheme.labelMedium),
                    Text('\$${order.totalAmount}',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

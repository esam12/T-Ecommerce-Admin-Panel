import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/device/device_utility.dart';
import 'package:t_ecommerce_admin_panel/utils/helpers/helper_functions.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Information',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.spaceBtwSections),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date'),
                    Text(order.formattedOrderDate,
                        style: Theme.of(context).textTheme.bodyLarge)
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Items'),
                    Text('5 Items',
                        style: Theme.of(context).textTheme.bodyLarge)
                  ],
                ),
              ),
              Expanded(
                flex: TDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Status'),
                    TRoundedContainer(
                      radius: TSizes.cardRadiusSm,
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: 0),
                      backgroundColor: THelperFunctions.getOrderStatusColor(
                              order.orderStatus)
                          .withValues(alpha: 0.1),
                      child: DropdownButton<OrderStatus>(
                        value: order.orderStatus,
                        onChanged: (OrderStatus? newValue) {},
                        items: OrderStatus.values.map((OrderStatus status) {
                          return DropdownMenuItem<OrderStatus>(
                            value: status,
                            child: Text(
                              status.name.capitalize.toString(),
                              style: TextStyle(
                                color: THelperFunctions.getOrderStatusColor(
                                    order.orderStatus),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Text('Total'),
                    Text('\$${order.totalAmount}',
                        style: Theme.of(context).textTheme.bodyLarge)
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

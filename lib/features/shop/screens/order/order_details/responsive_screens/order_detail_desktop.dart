import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/order_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/order/order_details/widgets/order_customer.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/order/order_details/widgets/order_info.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/order/order_details/widgets/order_items.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/order/order_details/widgets/order_transaction.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class OrderDetailDesktopScreen extends StatelessWidget {
  const OrderDetailDesktopScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              TBreadcrumbWithHeading(
                heading: order.id,
                returnToPreviousScreen: true,
                breadcrumbItems: const [TRoutes.orders, 'Details'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side Order Information
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // Order Information
                        OrderInfo(order: order),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Order Items
                        OrderItems(order: order),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Transactions
                        OrderTransaction(order: order),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Right Side Order Orders
                  Expanded(
                    child: Column(
                      children: [
                        // Customer Information
                        OrderCustomer(order: order),
                        const SizedBox(height: TSizes.spaceBtwSections),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

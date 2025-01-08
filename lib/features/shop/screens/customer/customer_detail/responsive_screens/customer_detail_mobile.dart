import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/features/authentication/models/user_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/customer/customer_detail/widgets/customer_info.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/customer/customer_detail/widgets/customer_orders.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/customer/customer_detail/widgets/shipping_address.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class CustomerDetailMobileScreen extends StatelessWidget {
  const CustomerDetailMobileScreen({super.key, required this.customer});
  final UserModel customer;

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
                returnToPreviousScreen: true,
                heading: customer.fullName,
                breadcrumbItems: const [TRoutes.customers, 'Detail'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Customer Information
              CustomerInfo(customer: customer),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Shipping Address
              ShippingAddress(customer: customer),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Customer Orders
              const CustomerOrders(),
            ],
          ),
        ),
      ),
    );
  }
}

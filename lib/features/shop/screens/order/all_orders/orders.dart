import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/layouts/templates/site_template.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/order/all_orders/responsive_screens/order_desktop.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/order/all_orders/responsive_screens/order_mobile.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/order/all_orders/responsive_screens/order_tablet.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: OrderDesktopScreen(),
      tablet: OrderTabletScreen(),
      mobile: OrderMobileScreen(),
    );
  }
}

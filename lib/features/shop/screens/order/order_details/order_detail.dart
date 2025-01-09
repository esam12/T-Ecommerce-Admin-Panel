import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/layouts/templates/site_template.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/order/order_details/responsive_screens/order_detail_desktop.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/order/order_details/responsive_screens/order_detail_mobile.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/order/order_details/responsive_screens/order_detail_tablet.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments;
    return TSiteTemplate(
      desktop: OrderDetailDesktopScreen(order: order),
      tablet: OrderDetailTabletScreen(order: order),
      mobile: OrderDetailMobileScreen(order: order),
    );
  }
}

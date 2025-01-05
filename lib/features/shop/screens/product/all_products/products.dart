import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/layouts/templates/site_template.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/product/all_products/responsive_screen/product_desktop.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/product/all_products/responsive_screen/product_mobile.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/product/all_products/responsive_screen/product_tablet.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: ProductDesktopScreen(),
      tablet: ProductTabletScreen(),
      mobile: ProductMobileScreen(),
    );
  }
}
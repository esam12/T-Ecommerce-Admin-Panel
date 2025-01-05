import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/layouts/templates/site_template.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/product/create_product/responsive_screen/create_product_desktop.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/product/create_product/responsive_screen/create_product_mobile.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/product/create_product/responsive_screen/create_product_tablet.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: CreateProductDesktopScreen(),
      tablet: CreateProductTabletScreen(),
      mobile: CreateProductMobileScreen(),
     
    );
  }
}
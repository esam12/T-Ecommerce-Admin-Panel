import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/layouts/templates/site_template.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/brand/all_brands/responsive_screens/brands_desktop.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: BrandsDesktopScreen(),
      // tablet: BrandsTablet(),
      // mobile: BrandsMobile(),
    );
  }
}

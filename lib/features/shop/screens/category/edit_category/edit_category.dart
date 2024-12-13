import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/layouts/templates/site_template.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/category/edit_category/responsive_screens/edit_category_desktop.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/category/edit_category/responsive_screens/edit_category_mobile.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/category/edit_category/responsive_screens/edit_category_tablet.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: EditCategoryDesktop(),
      tablet: EditCategoryTablet(),
      mobile: EditCategoryMobile(),
    );
  }
}
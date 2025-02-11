import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/brand/edit_brand/widgets/edit_brand_form.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class EditBrandTabletScreen extends StatelessWidget {
  const EditBrandTabletScreen({super.key, required this.brand});
    final BrandModel brand;


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
         const     TBreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Update Brand',
                breadcrumbItems: [TRoutes.categories, 'Update Brand'],
              ),
          const    SizedBox(height: TSizes.spaceBtwSections),

              // Form
              EditBrandForm(brand: brand)
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/brand/create_brand/widgets/create_brand_form.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class CreateBrandDesktopScreen extends StatelessWidget {
  const CreateBrandDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              TBreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Create Brand',
                breadcrumbItems: [TRoutes.brands, 'Create Brand'],
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              // Form
              CreateBrandForm()
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/banner/edit_banner/widgets/edit_banner_form.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class EditBannersDesktopScreen extends StatelessWidget {
  const EditBannersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              TBreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Update Banner',
                breadcrumbItems: [TRoutes.banners, 'Update Banner'],
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              // Form
              EditBannerForm()
            ],
          ),
        ),
      ),
    );
  }
}
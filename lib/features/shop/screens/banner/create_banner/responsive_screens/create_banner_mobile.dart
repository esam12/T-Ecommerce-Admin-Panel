import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/banner/create_banner/widgets/create_banner_form.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class CreateBannersMobileScreen extends StatelessWidget {
  const CreateBannersMobileScreen({super.key});

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
                heading: 'Create Banner',
                breadcrumbItems: [TRoutes.banners, 'Create Banner'],
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              // Form
              CreateBannerForm()
            ],
          ),
        ),
      ),
    );
  }
}

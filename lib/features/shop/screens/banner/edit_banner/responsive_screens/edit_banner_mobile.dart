import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/banner_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/screens/banner/edit_banner/widgets/edit_banner_form.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class EditBannersMobileScreen extends StatelessWidget {
  const EditBannersMobileScreen({super.key, required this.banner});
  final BannerModel banner;


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadcrumbWithHeading(
                returnToPreviousScreen: true,
                heading: 'Update Banner',
                breadcrumbItems: [TRoutes.banners, 'Update Banner'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Form
              EditBannerForm(banner: banner)
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/features/personalization/screens/profile/widgets/image_and_meta.dart';
import 'package:t_ecommerce_admin_panel/features/personalization/screens/profile/widgets/profile_form.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class ProfileMobileScreen extends StatelessWidget {
  const ProfileMobileScreen({super.key});

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
                heading: 'Profile',
                breadcrumbItems: ['Profile'],
              ),
              SizedBox(height: TSizes.spaceBtwSections),


              // Body
              ImageAndMeta(),
              SizedBox(width: TSizes.spaceBtwSections),
              
              // Form
              ProfileForm()

            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/features/personalization/screens/settings/widgets/image_and_meta.dart';
import 'package:t_ecommerce_admin_panel/features/personalization/screens/settings/widgets/settings_form.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class SettingsDesktopScreen extends StatelessWidget {
  const SettingsDesktopScreen({super.key});

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
                heading: 'Settings',
                breadcrumbItems: ['Settings'],
              ),
              SizedBox(height: TSizes.spaceBtwSections),


              // Body
              Row(
                children: [
                  // Profile Pic and Meta 
                  Expanded(child: ImageAndMeta()),
                  SizedBox(width: TSizes.spaceBtwSections),

                  // Form
                  Expanded(flex: 2,child: SettingsForm()),


                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
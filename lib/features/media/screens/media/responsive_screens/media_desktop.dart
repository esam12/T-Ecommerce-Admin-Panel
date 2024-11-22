import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/appbar/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class MediaDesktopScreen extends StatelessWidget {
  const MediaDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Breadcrumbs
                  const TBreadcrumbWithHeading(
                    heading: 'Media',
                    breadcrumbItems: [],
                  ),

                  SizedBox(
                    width: TSizes.buttonWidth * 1.5,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Iconsax.cloud_add),
                      label: const Text('Upload Images'),
                    ),
                  )
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Upload Area

              /// Media
            ],
          ),
        ),
      ),
    );
  }
}

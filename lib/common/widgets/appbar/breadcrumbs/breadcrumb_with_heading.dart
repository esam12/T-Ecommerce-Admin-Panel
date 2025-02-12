import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/texts/page_heading.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/helpers/helper_functions.dart';

class TBreadcrumbWithHeading extends StatelessWidget {
  const TBreadcrumbWithHeading({
    super.key,
    required this.heading,
    required this.breadcrumbItems,
    this.returnToPreviousScreen = false,
  });

  // The heading for the page
  final String heading;

  // List of breadcrumb items representing the navigation path
  final List<String> breadcrumbItems;

  // Flag indicating whether to include a button to return to the previous screen
  final bool returnToPreviousScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Breadcrumb trail
        Row(
          children: [
            // Dashboard Link
            InkWell(
              onTap: () => Get.offAllNamed(TRoutes.dashboard),
              child: Padding(
                padding: const EdgeInsets.all(TSizes.xs),
                child: Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.bodySmall!.apply(
                        fontWeightDelta: -1,
                      ),
                ),
              ),
            ),

            for (int i = 0; i < breadcrumbItems.length; i++)
              Row(
                children: [
                  const Text('/'),
                  InkWell(
                    // Last item should not be clickable
                    onTap: i == breadcrumbItems.length - 1
                        ? null
                        : () => Get.toNamed(breadcrumbItems[i]),
                    child: Padding(
                      padding: const EdgeInsets.all(TSizes.xs),
                      // Format breadcrumb item: capitalize and remove leading '/'
                      child: Text(
                        i == breadcrumbItems.length - 1
                            ? breadcrumbItems[i].capitalize.toString()
                            : THelperFunctions.capitalize(
                                breadcrumbItems[i].substring(1),
                              ),
                        style: Theme.of(context).textTheme.bodySmall!.apply(
                              fontWeightDelta: -1,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
        const SizedBox(height: TSizes.sm),

        // Heading of the page
        Row(
          children: [
            if (returnToPreviousScreen)
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Iconsax.arrow_left),
              ),
            if (returnToPreviousScreen)
              const SizedBox(width: TSizes.spaceBtwItems),
            TPageHeading(heading: heading),
          ],
        )
      ],
    );
  }
}

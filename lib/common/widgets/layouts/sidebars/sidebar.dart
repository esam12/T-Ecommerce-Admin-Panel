import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/images/t_circular_image.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/layouts/sidebars/menu/menu_item.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class TSidebar extends StatelessWidget {
  const TSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          color: TColors.white,
          border: Border(
            right: BorderSide(color: TColors.grey, width: 1),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image
              const TCircularImage(
                width: 100,
                height: 100,
                image: TImages.darkAppLogo,
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.all(TSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Menu',
                      style: Theme.of(context).textTheme.bodySmall!.apply(
                            letterSpacingDelta: 1.2,
                          ),
                    ),

                    // Menu Items
                    const TMenuItem(
                      title: 'Dashboard',
                      icon: Iconsax.status,
                      route: TRoutes.dashboard,
                    ),
                    const TMenuItem(
                      title: 'Media',
                      icon: Iconsax.image,
                      route: TRoutes.media,
                    ),
                    const TMenuItem(
                      title: 'Categories',
                      icon: Iconsax.category_2,
                      route: TRoutes.categories,
                    ),
                    const TMenuItem(
                      title: 'Brands',
                      icon: Iconsax.dcube,
                      route: TRoutes.brands,
                    ),
                    const TMenuItem(
                      title: 'Banners',
                      icon: Iconsax.picture_frame,
                      route: TRoutes.banners,
                    ),
                    const TMenuItem(
                      title: 'Products',
                      icon: Iconsax.shopping_bag,
                      route: TRoutes.products,
                    ),
                    const TMenuItem(
                      title: 'Customers',
                      icon: Iconsax.profile_2user,
                      route: TRoutes.customers,
                    ),
                    const TMenuItem(
                      title: 'Orders',
                      icon: Iconsax.box,
                      route: TRoutes.orders,
                    ),

                    // Other Menu Items
                    Text(
                      'OTHER',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(letterSpacingDelta: 1.2),
                    ),
                    const TMenuItem(
                      title: 'Profile',
                      icon: Iconsax.user,
                      route: TRoutes.profile,
                    ),
                    const TMenuItem(
                      title: 'Settings',
                      icon: Iconsax.setting_2,
                      route: TRoutes.settings,
                    ),

                    const TMenuItem(
                      title: 'Logout',
                      icon: Iconsax.logout,
                      route: 'logout',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

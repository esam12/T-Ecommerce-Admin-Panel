import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/layouts/sidebars/sidebar_controller.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:url_launcher/link.dart';

class TMenuItem extends StatelessWidget {
  const TMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.route,
  });

  final String title;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(SidebarController());
    return Link(
      uri: route != 'logout' ? Uri.parse(route) : null,
      builder: (_, __) => InkWell(
        onTap: () => menuController.menuOnTap(route),
        onHover: (hovering) => hovering
            ? menuController.changeHoverItem(route)
            : menuController.changeHoverItem(''),
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
            child: Container(
              decoration: BoxDecoration(
                color: menuController.isHovering(route) ||
                        menuController.isActive(route)
                    ? TColors.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(
                  TSizes.cardRadiusMd,
                ),
              ),
              child: Row(
                children: [
                  // Icon
                  Padding(
                    padding: const EdgeInsets.only(
                      left: TSizes.lg,
                      right: TSizes.md,
                      top: TSizes.md,
                      bottom: TSizes.md,
                    ),
                    child: menuController.isActive(route)
                        ? Icon(
                            icon,
                            size: 22,
                            color: TColors.white,
                          )
                        : Icon(
                            icon,
                            size: 22,
                            color: menuController.isHovering(route)
                                ? TColors.white
                                : TColors.darkGrey,
                          ),
                  ),
                  // Text
                  if (menuController.isHovering(route) ||
                      menuController.isActive(route))
                    Flexible(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: TColors.white,
                            ),
                      ),
                    )
                  else
                    Flexible(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: TColors.darkGrey,
                            ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

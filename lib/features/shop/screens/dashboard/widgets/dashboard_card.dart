import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/icons/t_circular_icon.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/texts/section_heading.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class TDashboardCard extends StatelessWidget {
  const TDashboardCard({
    super.key,
    required this.title,
    required this.subTitle,
    this.icon = Iconsax.arrow_up_3,
    this.color = TColors.success,
    required this.stats,
    this.onTap,
    required this.context,
    required this.headingIcon,
    required this.headingIconColor,
    required this.headingBgColor,
  });
  final BuildContext context;
  final String title, subTitle;
  final IconData icon, headingIcon;
  final Color color, headingIconColor, headingBgColor;
  final int stats;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      onTap: onTap,
      padding: const EdgeInsets.all(TSizes.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Heading
          Row(
            children: [
              TCircularIcon(
                icon: headingIcon,
                backgroundColor: headingBgColor,
                color: headingIconColor,
                size: TSizes.md,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              TSectionHeading(title: title, textColor: TColors.textSecondary),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subTitle, style: Theme.of(context).textTheme.headlineMedium),

              /// Right Side Stats
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        /// Indicator
                        Icon(icon, color: color, size: TSizes.iconSm),
                        Text(
                          '$stats%',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: color,
                                  overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 135,
                    child: Text(
                      "Compared to Dec 2025",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

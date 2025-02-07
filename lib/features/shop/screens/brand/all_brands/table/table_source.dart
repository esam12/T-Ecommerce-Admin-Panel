import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/image_rounded.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/device/device_utility.dart';

class BrandRows extends DataTableSource {
  final controller = BrandsController.instance;

  @override
  DataRow? getRow(int index) {
    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              const TRoundedImage(
                width: 50,
                height: 50,
                padding: TSizes.sm,
                imageType: ImageType.asset,
                image: TImages.adidasLogo,
                borderRaduis: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  controller.filteredItems[index].name,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodyLarge!
                      .apply(color: TColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: TSizes.sm,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                spacing: TSizes.xs,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: TDeviceUtils.isMobileScreen(Get.context!)
                          ? 0
                          : TSizes.xs,
                    ),
                    child: const Chip(
                      label: Text('Shoes'),
                      padding: EdgeInsets.all(TSizes.xs),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: TDeviceUtils.isMobileScreen(Get.context!)
                          ? 0
                          : TSizes.xs,
                    ),
                    child: const Chip(
                      label: Text('TrackSuits'),
                      padding: EdgeInsets.all(TSizes.xs),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: TDeviceUtils.isMobileScreen(Get.context!)
                          ? 0
                          : TSizes.xs,
                    ),
                    child: const Chip(
                      label: Text('Joggers'),
                      padding: EdgeInsets.all(TSizes.xs),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const DataCell(Icon(Iconsax.heart5, color: TColors.primary)),
        DataCell(Text(controller.filteredItems[index].createdAt.toString())),
        DataCell(TTableActionButtons(
          onEditPressed: () => Get.toNamed(TRoutes.editBrand, arguments: ''),
          onDeletePressed: () {},
        ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => 0;
}

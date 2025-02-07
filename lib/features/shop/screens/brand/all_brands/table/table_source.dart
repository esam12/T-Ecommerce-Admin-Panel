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
    final brand = controller.filteredItems[index];
    return DataRow2(
      selected: controller.selectRows[index],
      onSelectChanged: (value) => controller.selectRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                width: 50,
                height: 50,
                padding: TSizes.sm,
                imageType: brand.image.isNotEmpty
                    ? ImageType.network
                    : ImageType.asset,
                image:
                    brand.image.isNotEmpty ? brand.image : TImages.adidasLogo,
                borderRaduis: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  brand.name,
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
                direction: TDeviceUtils.isMobileScreen(Get.context!)
                    ? Axis.vertical
                    : Axis.horizontal,
                children: brand.brandCategories != null
                    ? brand.brandCategories!.map((e) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: TDeviceUtils.isMobileScreen(Get.context!)
                                  ? 0
                                  : TSizes.xs),
                          child: Chip(
                              label: Text(e.name),
                              padding: const EdgeInsets.all(TSizes.xs)),
                        );
                      }).toList()
                    : [const SizedBox()],
              ),
            ),
          ),
        ),
        DataCell(brand.isFeatured
            ? const Icon(Iconsax.heart5, color: TColors.primary)
            : const Icon(Iconsax.heart)),
        DataCell(Text(brand.createdAt != null ? brand.formattedDate : '')),
        DataCell(TTableActionButtons(
          onEditPressed: () => Get.toNamed(TRoutes.editBrand, arguments: brand),
          onDeletePressed: () => controller.confirmAndDeleteItem(brand),
        ))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount =>
      controller.selectRows.where((selected) => selected).length;
}

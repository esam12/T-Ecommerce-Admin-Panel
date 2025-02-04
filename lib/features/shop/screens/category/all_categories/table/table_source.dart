import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/image_rounded.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class CategoryRows extends DataTableSource {
  final controller = CategoryController.instance;

  @override
  DataRow? getRow(int index) {
    final category = controller.filteredItems[index];
    final parentCategory = controller.allItems
        .firstWhereOrNull((item) => item.id == category.parentId);
    return DataRow2(
      selected: controller.selectRows[index],
      onSelectChanged: (value) =>
          controller.selectRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                width: 50,
                height: 50,
                padding: TSizes.sm,
                imageType: ImageType.network,
                image: category.image,
                borderRaduis: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  category.name,
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
        DataCell(Text(parentCategory != null ? parentCategory.name : '')),
        DataCell(category.isFeatured
            ? const Icon(Iconsax.heart5, color: TColors.primary)
            : const Icon(Iconsax.heart)),
        DataCell(
            Text(category.createdAt == null ? '' : category.formattedDate)),
        DataCell(
          TTableActionButtons(
            onEditPressed: () =>
                Get.toNamed(TRoutes.editCategory, arguments: category),
            onDeletePressed: () => controller.removeItemFromLists(category),
          ),
        )
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

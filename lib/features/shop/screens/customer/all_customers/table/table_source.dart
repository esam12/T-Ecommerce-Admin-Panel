import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/customer/customer_controller.dart';
import 'package:t_ecommerce_admin_panel/routes/routes.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class CustomerRows extends DataTableSource {
  final controller = CustomerController.instance;
  @override
  DataRow? getRow(int index) {
    final customer = controller.filteredItems[index];
    return DataRow2(
      onTap: () => Get.toNamed(TRoutes.customerDetails,
          arguments: customer, parameters: {'customerId': customer.id ?? ''}),
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
                image: customer.profilePicture.isNotEmpty
                    ? customer.profilePicture
                    : TImages.defaultImage,
                imageType: customer.profilePicture.isNotEmpty
                    ? ImageType.network
                    : ImageType.asset,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  customer.fullName,
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
        DataCell(Text(customer.email)),
        DataCell(Text(customer.phoneNumber)),
        DataCell(
            Text(customer.createdAt == null ? '' : customer.formattedDate)),
        DataCell(
          TTableActionButtons(
            view: true,
            edit: false,
            onViewPressed: () => Get.toNamed(
              TRoutes.customerDetails,
              arguments: customer,
              parameters: {'customerId': customer.id ?? ''},
            ),
            onDeletePressed: () => controller.confirmAndDeleteItem(customer),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectRows.where((element) => element).length;
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/image_rounded.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/features/media/models/image_model.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/device/device_utility.dart';

class ImagePopup extends StatelessWidget {
  const ImagePopup({super.key, required this.imageModel});

  // The Image model to display detailed information about.
  final ImageModel imageModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        // Define the shape of the dialog.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.borderRadiusLg),
        ),
        child: TRoundedContainer(
          // Set the width an option to close the dialog.
          width: TDeviceUtils.isDesktopScreen(context)
              ? MediaQuery.sizeOf(context).width * 0.4
              : double.infinity,
          padding: const EdgeInsets.all(TSizes.spaceBtwItems),
          child: Column(
            children: [
              // Display the image with an option to close the dialog
              SizedBox(
                child: Stack(
                  children: [
                    // Display the image with rounded container
                    TRoundedContainer(
                      backgroundColor: TColors.primaryBackground,
                      child: TRoundedImage(
                        imageType: ImageType.network,
                        image: imageModel.url,
                        applyImageRadius: true,
                        height: MediaQuery.sizeOf(context).height * 0.4,
                        width: TDeviceUtils.isDesktopScreen(context)
                            ? MediaQuery.sizeOf(context).width * 0.4
                            : double.infinity,
                      ),
                    ),
                    // Close icon button positioned at the top-right corner
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(Iconsax.close_circle),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}

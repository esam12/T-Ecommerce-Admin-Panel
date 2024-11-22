import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/image_rounded.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/features/media/controllers/media_controller.dart';
import 'package:t_ecommerce_admin_panel/features/media/screens/media/widgets/folder_dropdown.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/device/device_utility.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return Obx(
      () => controller.showImagesUploaderSection.value
          ? Column(
              children: [
                /// Drag and Drop Area
                TRoundedContainer(
                  height: 250,
                  showBorder: true,
                  borderColor: TColors.borderPrimary,
                  backgroundColor: TColors.primaryBackground,
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            DropzoneView(
                              mime: ['image/jpeg', 'image/png'],
                              cursor: CursorType.Default,
                              operation: DragOperation.copy,
                              onLoaded: () => print('Zone Loaded'),
                              onHover: () => print('Zone Hover'),
                              onLeave: () => print('Zone Leave'),
                              onError: (value) => print('Zone Error: $value'),
                              onCreated: (ctrl) =>
                                  controller.dropzoneViewController = ctrl,
                              onDropFile: (file) {
                                print(file.name);
                              },
                              onDropInvalid: (ev) =>
                                  print('Zone Invalid File: $ev'),
                              onDropFiles: (ev) async {
                                print('Zone drope multiple: $ev');
                              },
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  TImages.defaultMultiImageIcon,
                                  width: 50,
                                  height: 50,
                                ),
                                const SizedBox(height: TSizes.spaceBtwItems),
                                const Text('Drag and Drop Images here'),
                                const SizedBox(height: TSizes.spaceBtwItems),
                                OutlinedButton(
                                  onPressed: () {},
                                  child: const Text('Select Images'),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// Locally Selected Images
                TRoundedContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Folders Dropdown

                          Row(
                            children: [
                              Text("Select Folder",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              const SizedBox(width: TSizes.spaceBtwItems),
                              MediaFolderDropdown(
                                onChanged: (MediaCategory? newValue) {
                                  if (newValue != null) {
                                    controller.selectedPath.value = newValue;
                                  }
                                },
                              )
                            ],
                          ),

                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: const Text("Remove All")),
                              const SizedBox(width: TSizes.spaceBtwItems),
                              TDeviceUtils.isMobileScreen(context)
                                  ? const SizedBox.shrink()
                                  : SizedBox(
                                      width: TSizes.buttonWidth,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Upload'),
                                      ),
                                    )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      const Wrap(
                        alignment: WrapAlignment.start,
                        spacing: TSizes.spaceBtwItems / 2,
                        runSpacing: TSizes.spaceBtwItems / 2,
                        children: [
                          TRoundedImage(
                            width: 90,
                            height: 90,
                            padding: TSizes.sm,
                            imagetType: ImageType.asset,
                            image: TImages.darkAppLogo,
                            backgroundColor: TColors.primaryBackground,
                          ),
                          TRoundedImage(
                            width: 90,
                            height: 90,
                            padding: TSizes.sm,
                            imagetType: ImageType.asset,
                            image: TImages.darkAppLogo,
                            backgroundColor: TColors.primaryBackground,
                          ),
                          TRoundedImage(
                            width: 90,
                            height: 90,
                            padding: TSizes.sm,
                            imagetType: ImageType.asset,
                            image: TImages.darkAppLogo,
                            backgroundColor: TColors.primaryBackground,
                          ),
                          TRoundedImage(
                            width: 90,
                            height: 90,
                            padding: TSizes.sm,
                            imagetType: ImageType.asset,
                            image: TImages.darkAppLogo,
                            backgroundColor: TColors.primaryBackground,
                          ),
                          TRoundedImage(
                            width: 90,
                            height: 90,
                            padding: TSizes.sm,
                            imagetType: ImageType.asset,
                            image: TImages.darkAppLogo,
                            backgroundColor: TColors.primaryBackground,
                          ),
                          TRoundedImage(
                            width: 90,
                            height: 90,
                            padding: TSizes.sm,
                            imagetType: ImageType.asset,
                            image: TImages.darkAppLogo,
                            backgroundColor: TColors.primaryBackground,
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      TDeviceUtils.isMobileScreen(context)
                          ? SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Upload'),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                )
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}

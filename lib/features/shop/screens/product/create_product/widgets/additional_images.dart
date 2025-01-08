import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/colors.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages({
    super.key,
    required this.additionalProductImagesURLs,
    this.onTapToAddImages,
    this.onTapToRemoveImage,
  });

  final RxList<String> additionalProductImagesURLs;
  final void Function()? onTapToAddImages;
  final void Function(int index)? onTapToRemoveImage;

  @override
  Widget build(BuildContext context) {
    return
        // Obx(
        //   () =>
        SizedBox(
      height: 300,
      child: Column(
        children: [
          // Section To Add Additional Product Images
          Expanded(
            child: GestureDetector(
              onTap: onTapToAddImages,
              child: TRoundedContainer(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        TImages.defaultMultiImageIcon,
                        width: 50,
                        height: 50,
                      ),
                      const Text('Add Additional Product Images'),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Section to Display Uploaded Images
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 80,
                  child: _uploadedImagesOrEmptyList(),
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems / 2),

              // Add More Images Button
              TRoundedContainer(
                width: 80,
                height: 80,
                showBorder: true,
                borderColor: TColors.grey,
                backgroundColor: TColors.white,
                onTap: onTapToAddImages,
                child: const Center(
                  child: Icon(Iconsax.add),
                ),
              )
            ],
          ))
        ],
      ),
    );
    // );
  }

  // Widget to Display Either Uploaded Images or Empty List
  Widget _uploadedImagesOrEmptyList() {
    return _emptyList();
    // return additionalProductImagesURLs.isEmpty
    //     ? _uploadedImages()
    //     : _emptyList();
  }

  // Widget to Display Empty List Placeholder
  Widget _emptyList() {
    return ListView.separated(
      itemCount: 6,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, __) =>
          const SizedBox(width: TSizes.spaceBtwItems / 2),
      itemBuilder: (context, index) => const TRoundedContainer(
        width: 80,
        height: 80,
        backgroundColor: TColors.primaryBackground,
      ),
    );
  }

  // Widget to Display Uploaded Images
  // ignore: unused_element
  Widget _uploadedImages() {
    return ListView.separated(
      itemCount: additionalProductImagesURLs.length,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, __) =>
          const SizedBox(width: TSizes.spaceBtwItems / 2),
      itemBuilder: (context, index) {
        final image = additionalProductImagesURLs[index];
        return TImageUploader(
          top: 0,
          left: null,
          right: 0,
          bottom: null,
          width: 80,
          height: 80,
          imageType: ImageType.network,
          image: image,
          icon: Iconsax.trash,
          onIconButtonPressed: () => onTapToRemoveImage!(index),
        );
      },
    );
  }
}

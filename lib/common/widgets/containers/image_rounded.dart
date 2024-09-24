import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_ecommerce_admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    required this.imagetType,
    this.width = 56,
    this.height = 56,
    required this.image,
    this.applyImageRadius = true,
    this.fit = BoxFit.contain,
    this.padding = TSizes.sm,
    this.borderRaduis = TSizes.md,
    this.backgroundColor,
    this.border,
    this.file,
    this.overlayColor,
    this.memoryImage,
    this.margin,
  });

  final bool applyImageRadius;
  final BoxBorder? border;
  final double borderRaduis;
  final String? image;
  final BoxFit? fit;
  final File? file;
  final ImageType imagetType;
  final Color? backgroundColor;
  final Color? overlayColor;
  final Uint8List? memoryImage;
  final double width, height, padding;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      margin: margin != null ? EdgeInsets.all(margin!) : null,
      decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRaduis)),
      child: _buildImageWidget(),
    );
  }

  Widget _buildImageWidget() {
    Widget imageWidget;

    switch (imagetType) {
      case ImageType.network:
        imageWidget = _buildNetworkImage();
        break;

      case ImageType.memory:
        imageWidget = _buildMemoryImage();
        break;

      case ImageType.file:
        imageWidget = _buildFileImage();
        break;

      case ImageType.asset:
        imageWidget = _buildAssetImage();
        break;
    }

    // Apply ClipRRect directly on the image
    return ClipRRect(
      borderRadius: applyImageRadius
          ? BorderRadius.circular(borderRaduis)
          : BorderRadius.zero,
      child: imageWidget,
    );
  }

  // Function to build network image
  Widget _buildNetworkImage() {
    if (image != null) {
      // Use Cashed network image for efficiency loading and caching of network images // Not working in web but just for loading
      return CachedNetworkImage(
        imageUrl: image!,
        fit: fit,
        color: overlayColor,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        progressIndicatorBuilder: (context, url, progress) =>
            TShimmerEffect(width: width, height: height),
      );
    } else {
      return const SizedBox();
    }
  }

  // Function to build memory image
  Widget _buildMemoryImage() {
    if (memoryImage != null) {
      return Image(
          image: MemoryImage(memoryImage!), color: overlayColor, fit: fit);
    } else {
      return const SizedBox();
    }
  }

  // Function to build file image
  Widget _buildFileImage() {
    if (file != null) {
      return Image.file(file!, color: overlayColor, fit: fit);
    } else {
      return const SizedBox();
    }
  }

  // Function to build asset image
  Widget _buildAssetImage() {
    if (image != null) {
      return Image(image: AssetImage(image!), fit: fit, color: overlayColor);
    } else {
      return const SizedBox();
    }
  }
}

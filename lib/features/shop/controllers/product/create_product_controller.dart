import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/data/repositories/product/product_repository.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/product/product_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/product/product_images_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/controllers/product/product_variation_controller.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/category_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/product_category_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:t_ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/loaders.dart';

class CreateProductController extends GetxController {
  // Singleton Instance
  static CreateProductController get instance => Get.find();

  // Observables for loading state and product details
  final isLoading = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  // Controllers and Keys
  final stockPriceFormKey = GlobalKey<FormState>();
  final productRepository = Get.put(ProductRepository());
  final titleDescriptionFormKey = GlobalKey<FormState>();

  // Text Editing Controllers for input fields
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  // Rx observables for selected brand and categories
  Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  // Flags for tracking different tasks
  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  // Function to create a new product
  Future<void> createProduct() async {
    try {
      // Show progress dialog
      showProgressDialog();

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Validate title and description form
      if (!titleDescriptionFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Validate stock and pricing form if product type is single
      if (productType.value == ProductType.single &&
          !stockPriceFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Ensure a brand is selected
      if (selectedBrand.value == null) throw 'Select Brand for this Product';

      // Check variation data if Product Type is Variable
      if (productType.value == ProductType.variable &&
          ProductVariationController.instance.productVariations.isEmpty) {
        throw 'There are no variations for the Product Type Variable. Create some variations or change Product Type.';
      }

      if (productType.value == ProductType.variable) {
        final variationCheckFailed = ProductVariationController
            .instance.productVariations
            .any((element) =>
                element.price.isNaN ||
                element.price < 0 ||
                element.salePrice.isNaN ||
                element.salePrice < 0 ||
                element.stock.isNaN ||
                element.stock < 0 ||
                element.image.value.isEmpty);

        if (variationCheckFailed)
          throw 'Variation data is not accurate. Please recheck variations.';
      }

      // Upload Product Thumbnail Image
      thumbnailUploader.value = true;
      final imagesController = ProductImagesController.instance;
      if (imagesController.selectedThumbnailImage.value == null)
        throw 'Select Product Thumbnail Image';

      // Additional Product Images
      additionalImagesUploader.value = true;

      // Product Variation Images
      final variations = ProductVariationController.instance.productVariations;
      if (productType.value == ProductType.variable && variations.isNotEmpty) {
        // If admin added variations and then changed the Product Type, remove all variations
        ProductVariationController.instance.resetAllValues();
        variations.value = [];
      }

      // Map Product Data to ProductModel
      final newRecord = ProductModel(
        id: '',
        sku: '',
        isFeatured: true,
        title: title.text.trim(),
        brand: selectedBrand.value,
        productVariations: variations,
        description: description.text.trim(),
        productType: productType.value.toString(),
        stock: int.tryParse(stock.text.trim()) ?? 0,
        price: double.tryParse(price.text.trim()) ?? 0.0,
        images: imagesController.additionalProductImagesUrls,
        salePrice: double.tryParse(salePrice.text.trim()) ?? 0.0,
        thumbnail: imagesController.selectedThumbnailImage.value ?? '',
        productAttributes:
            ProductAttributesController.instance.productAttributes,
        date: DateTime.now(),
      );

      // Call Repository to Create New Product
      productDataUploader.value = true;
      newRecord.id = await productRepository.createProduct(newRecord);

      // Register product categories if any
      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) throw 'Error storing data. Try again';

        // Loop through selected Product Categories
        categoriesRelationshipUploader.value = true;
        for (var category in selectedCategories) {
          // Map Data
          final productCategory = ProductCategoryModel(
              productId: newRecord.id, categoryId: category.id!);
          await productRepository.createProductCategory(productCategory);
        }
      }
      // update Product List
      ProductController.instance.addItemToList(newRecord);

      // Close he Progress Dialog
      TFullScreenLoader.stopLoading();

      // Show Success Message Loader
      showCompletionDialog();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Build a Checkbox widget
  Widget buildCheckBox(String lable, RxBool value) {
    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          child: value.value
              ? const Icon(CupertinoIcons.checkmark_alt_circle_fill,
                  color: Colors.blue)
              : const Icon(CupertinoIcons.checkmark_alt_circle),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Text(lable),
      ],
    );
  }

  // Show Conpletion dialog
  void showCompletionDialog() {
    Get.dialog(AlertDialog(
      title: const Text('Congratulations'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          child: const Text('Go to Products'),
        )
        
      ],
      content: Column(children: [
        Image.asset(TImages.productsIllustration,height: 200,width: 200),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text('Congratulations',style: Theme.of(Get.context!).textTheme.headlineSmall),
        const SizedBox(height: TSizes.spaceBtwItems),
        const Text('Your Product has been created.'),

      ],),
    ));
  }

  // 
}

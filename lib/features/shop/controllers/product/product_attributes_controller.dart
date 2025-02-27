import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/product_attribute_model.dart';
import 'package:t_ecommerce_admin_panel/utils/popups/dialogs.dart';

class ProductAttributesController extends GetxController {
  static ProductAttributesController get instance => Get.find();

  // Observables for loading state, form key, and product attributes
  final isLoading = false.obs;
  final attributesFormKey = GlobalKey<FormState>();
  TextEditingController attributeName = TextEditingController();
  TextEditingController attributes = TextEditingController();
  final RxList<ProductAttributeModel> productAttributes =
      <ProductAttributeModel>[].obs;

  // Function to add a new attribute
  void addNewAttribute() {
    // Form Validation
    if (!attributesFormKey.currentState!.validate()) {
      return;
    }

    // Add Attributes to the list of attributes
    productAttributes.add(
      ProductAttributeModel(
        name: attributeName.text.trim(),
        values: attributes.text.trim().split('|').toList(),
      ),
    );

    // Clear text fields after adding
    attributeName.text = '';
    attributes.text = '';
  }

  // Function to remove an attribute
  void removeAttribute(int index, BuildContext context) {
    // Show confirmation dialog
    TDialogs.defaultDialog(
      context: context,
      onConfirm: () {
        // User confirmed, remove attribute
        Navigator.pop(context);
        productAttributes.removeAt(index);

        // Reset productVariations when removing an attribute
        // ProductVariationController.instance.productVariations.value = [];
      },
    );
  }

  // Function to reset product attributes
  void resetProductAttributes() {
    attributes.clear();
  }
}

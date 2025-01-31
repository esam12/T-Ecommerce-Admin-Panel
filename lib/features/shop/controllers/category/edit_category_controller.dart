import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/category_model.dart';

class EditCategoryController extends GetxController {
  static EditCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  /// Init Data
  
  /// Method to reset fields
  
  /// Pick Thumbnail Image from Media
  
  /// Register new Category
}

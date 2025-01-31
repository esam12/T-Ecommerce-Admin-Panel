import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/category_model.dart';

class CreateCategoryController extends GetxController {
  static CreateCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  /// Method to reset fields
  
  /// Pick Thumbnail Image from Media
  
  /// Register new Category
}

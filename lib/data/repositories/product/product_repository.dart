import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/product_category_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/product_model.dart';
import 'package:t_ecommerce_admin_panel/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_ecommerce_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:t_ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  /// Firestore instance for database interactions
  final _db = FirebaseFirestore.instance;

  /// Create Product
  Future<String> createProduct(ProductModel product) async {
    try {
      final result = await _db.collection('Products').add(product.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Create new Product Category
  Future<String> createProductCategory(
      ProductCategoryModel productCategory) async {
    try {
      final result =
          await _db.collection('ProductCategory').add(productCategory.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update Product
  Future<void> updateProduct(ProductModel product) async {
    try {
      await _db.collection('Products').doc(product.id).update(product.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update Product Instance
  Future<void> updateProductSpecificValue(id, Map<String, dynamic> data) async {
    try {
      await _db.collection('Products').doc(id).update(data);
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}

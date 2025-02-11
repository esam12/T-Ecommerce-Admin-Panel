import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/brand_category_model.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:t_ecommerce_admin_panel/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_ecommerce_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:t_ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  // Initialize Firebase
  final _db = FirebaseFirestore.instance;

  /// Fetch All Brands from Firestore
  Future<List<BrandModel>> fetchAllBrands() async {
    try {
      final querySnapshot = await _db.collection('Brands').get();
      return querySnapshot.docs
          .map((doc) => BrandModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Fetch all brand categories from the 'BrandCategories' collection
  Future<List<BrandCategoryModel>> getAllBrandCategories() async {
    try {
      final querySnapshot = await _db.collection('BrandCategory').get();
      return querySnapshot.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Get specific brand category from the 'BrandCategories' collection based on its ID
  Future<List<BrandCategoryModel>> getCategoriesOfSpecificBrand(
      String brandId) async {
    try {
      final brandCategoryQuery = await _db
          .collection('BrandCategory')
          .where('brandId', isEqualTo: brandId)
          .get();
      final brandCategories = brandCategoryQuery.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc))
          .toList();

      return brandCategories;
    } on FirebaseException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Create new brand in the 'Brands' collection
  Future<String> createBrand(BrandModel brand) async {
    try {
      final result = await _db.collection('Brands').add(brand.toJson());
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

  /// Create new brand category in the 'BrandCategories' collection
  Future<String> createBrandCategory(BrandCategoryModel brandCategory) async {
    try {
      final result =
          await _db.collection('BrandCategory').add(brandCategory.toJson());
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

  /// Update an existing brand document and its associated brand categories
  Future<void> updateBrand(BrandModel brand) async {
    try {
      await _db.collection('Brands').doc(brand.id).update(brand.toJson());
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

  /// Delete an existing brand document and its associated brand categories
  Future<void> deleteBrand(BrandModel brand) async {
    try {
      await _db.runTransaction((transaction) async {
        final brandRef = _db.collection("Brands").doc(brand.id);
        final brandSnap = await transaction.get(brandRef);

        if (!brandSnap.exists) {
          throw Exception('Brand not found');
        }

        final brandCategoriesSnapshot = await _db
            .collection('BrandCategory')
            .where('brandId', isEqualTo: brand.id)
            .get();

        final brandCategories = brandCategoriesSnapshot.docs
            .map((doc) => BrandCategoryModel.fromSnapshot(doc));
        if (brandCategories.isNotEmpty) {
          for (final brandCategory in brandCategories) {
            transaction
                .delete(_db.collection('BrandCategory').doc(brandCategory.id));
          }
        }
        transaction.delete(brandRef);
      });
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

  /// Delete  brand category document in the 'BrandCategory' collection
  Future<void> deleteBrandCategory(String brandCategoryId) async {
      try {
      await _db.collection('BrandCategory').doc(brandCategoryId).delete();
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

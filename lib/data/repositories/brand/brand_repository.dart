
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:t_ecommerce_admin_panel/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';

class BrandRepository extends GetxController { 
  static BrandRepository get instance => Get.find();

  // Initialize Firebase
  final _db = FirebaseFirestore.instance;

  // Fetch All Brands from Firestore
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

  

} 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/data/repositories/authentication/authentication_repository.dart';
import 'package:t_ecommerce_admin_panel/features/shop/models/address_model.dart';
import 'package:t_ecommerce_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:t_ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  // Firebase Firestore instance
  final _db = FirebaseFirestore.instance;

  // Fetch user addresses from firestore based on userId
  Future<List<AddressModel>> fetchUserAddresses(String userId) async {
    try {
      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .get();
      return result.docs
          .map(
              (documentSnapshot) => AddressModel.fromSnapshot(documentSnapshot))
          .toList();
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Update the "Selected Address" field for a specific address
  Future<void> updateSelectedAddress(String addressId, bool selected) async {
    try {
      // Get the current user's Id
      final userId = AuthenticationRepository.instance.authUser!.uid;

      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'selectedAddress': selected});
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Add a new address to Firestore
  Future<String> addAddress(AddressModel address) async {
    try {
       // Get the current user's Id
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .add(address.toJson());
      return result.id;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_ecommerce_admin_panel/features/personalization/models/settings_model.dart';
import 'package:t_ecommerce_admin_panel/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_ecommerce_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:t_ecommerce_admin_panel/utils/exceptions/platform_exceptions.dart';

class SettingsRepository extends GetxController {
  static SettingsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Function to save setting data to Firestore.
  Future<void> registerSettings(SettingsModel setting) async {
    try {
      await _db.collection('Settings').doc('GLOBAL_SETTINGS').set(setting.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
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

  /// Function to fetch setting details based on setting ID.
  Future<SettingsModel> getSettings() async {
    try {
      final docSnapshot = await _db.collection('Settings').doc('GLOBAL_SETTINGS').get();
      if (docSnapshot.exists) {
        return SettingsModel.fromSnapshot(docSnapshot);
      } else {
        return SettingsModel();
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to update setting data in Firestore.
  Future<void> updateSettings(SettingsModel updatedSetting) async {
    try {
      await _db.collection('Settings').doc('GLOBAL_SETTINGS').update(updatedSetting.toJson());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  } 

  /// Function to update single field in Settings Collection
  Future<void> updateSettingsSpecificValue(Map<String, dynamic> data) async {
    try {
      await _db.collection('Settings').doc('GLOBAL_SETTINGS').update(data);
    } on FirebaseAuthException catch (e) {
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

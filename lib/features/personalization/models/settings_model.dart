import 'package:cloud_firestore/cloud_firestore.dart';

/// Model class representing user data.
class SettingsModel {
  final String? id;
  double taxRate;
  double shippingCost;
  double? freeShippingThreshold;
  String appName;
  String appLogo;

  /// Constructor for the SettingsModel class.
  SettingsModel({
    this.id,
    this.taxRate = 0.0,
    this.shippingCost = 0.0,
    this.freeShippingThreshold,
    this.appName = '',
    this.appLogo = '',
  });

  /// Convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() => {
        'TaxRate': taxRate,
        'ShippingCost': shippingCost,
        'FreeShippingThreshold': freeShippingThreshold,
        'AppName': appName,
        'AppLogo': appLogo,
      };

  /// Factory Method to create a SettingsModel from a firebase document snapshot
  factory SettingsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return SettingsModel(
        id: document.id,
        taxRate: (data['taxRate'] as num?)?.toDouble() ?? 0.0,
        shippingCost: (data['shippingCost'] as num?)?.toDouble() ?? 0.0,
        freeShippingThreshold:
            (data['freeShippingThreshold'] as num?)?.toDouble(),
        appName: data.containsKey('appName') ? data['appName'] ?? '' : '',
        appLogo: data.containsKey('appLogo') ? data['appLogo'] ?? '' : '',
      );
    } else {
      return SettingsModel();
    }
  }
}

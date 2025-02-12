import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String? id;
  String imageUrl;
  bool active;
  String targetScreen;

  BannerModel({
    this.id,
    required this.imageUrl,
    required this.active,
    required this.targetScreen,
  });

  // Convert to a Map<String, dynamic>
  Map<String, dynamic> toJson() => {
        'imageUrl': imageUrl,
        'active': active,
        'targetScreen': targetScreen,
      };

  // Convert from a Map<String, dynamic> to a BannerModel
  factory BannerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
      id: snapshot.id,
      imageUrl: data['imageUrl'] ?? '',
      active: data['active'] ?? false,
      targetScreen: data['targetScreen'] ?? '',
    );
  }
}

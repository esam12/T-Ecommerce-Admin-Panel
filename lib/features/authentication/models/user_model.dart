// Model class representing user data
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_ecommerce_admin_panel/utils/constants/enums.dart';
import 'package:t_ecommerce_admin_panel/utils/formatters/formatter.dart';

class UserModel {
  final String? id;
  String firstName;
  String lastName;
  String userName;
  String email;
  String phoneNumber;
  String profilePicture;
  AppRole role;
  DateTime? createdAt;
  DateTime? updatedAt;

  // Constructor for UserModel
  UserModel({
    this.id,
    required this.email,
    this.firstName = '',
    this.lastName = '',
    this.userName = '',
    this.phoneNumber = '',
    this.profilePicture = '',
    this.role = AppRole.user,
    this.createdAt,
    this.updatedAt,
  });

  // Helper methods
  String get fullName => '$firstName $lastName';
  String get formattedDate => TFormatter.formatDate(createdAt);
  String get formattedUpdateAtDate => TFormatter.formatDate(updatedAt);
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  // static function to create an empty user model
  static UserModel empty() => UserModel(email: '');

  // Convert model to json structure for sorting data in Firebase
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'userName': userName,
        'email': email,
        'phoneNumber': phoneNumber,
        'profilePicture': profilePicture,
        'role': role.name.toString(),
        'createdAt': createdAt,
        'updatedAt': updatedAt = DateTime.now(),
      };

  /// Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      log(data['role'].toString());
      return UserModel(
        id: document.id,
        firstName: data.containsKey('firstName') ? data['firstName'] ?? '' : '',
        lastName: data.containsKey('lastName') ? data['lastName'] ?? '' : '',
        userName: data.containsKey('userName') ? data['userName'] ?? '' : '',
        email: data.containsKey('email') ? data['email'] ?? '' : '',
        phoneNumber:
            data.containsKey('phoneNumber') ? data['phoneNumber'] ?? '' : '',
        profilePicture: data.containsKey('profilePicture')
            ? data['profilePicture'] ?? ''
            : '',
        role: data.containsKey('role')
            ? (data['role'] ?? AppRole.user) == AppRole.admin.name.toString()
                ? AppRole.admin
                : AppRole.user
            : AppRole.user,
        createdAt: data.containsKey('createdAt')
            ? data['createdAt']?.toDate() ?? DateTime.now()
            : DateTime.now(),
        updatedAt: data.containsKey('updatedAt')
            ? data['updatedAt']?.toDate() ?? DateTime.now()
            : DateTime.now(),
      );
    } else {
      return empty();
    }
  }
}

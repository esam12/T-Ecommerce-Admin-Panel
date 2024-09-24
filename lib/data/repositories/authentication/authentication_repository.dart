import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Firebase Auth Instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  // Get Is Authenticated User
  bool get isAuthenticated => _auth.currentUser != null;

  @override
  void onReady() {
 
  }


  // Sign in with email and password

  // Sign up with email and password

  // Email verification

  // Forgot Password

  // Re Authenticate User

  // Sign out User

  // Delete User
}

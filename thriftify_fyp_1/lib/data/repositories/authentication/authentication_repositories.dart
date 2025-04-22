import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as storage;
import 'package:thriftify_fyp_1/features/authentication/screens/login/login.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/onboarding/onboarding.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/signup/verify_email.dart';
import 'package:thriftify_fyp_1/navigation_menu.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

   screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      if(user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      }else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email,));
      }
    }
    else {

    deviceStorage.writeIfNull('IsFirstTime', true);
    deviceStorage.read('isFirstTime') != true
    ? Get.offAll(() => const LoginScreen())
    : Get.offAll(const OnBoardingScreen());
    
  }
   }

   Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e, stackTrace) {
      debugPrint("[AuthRepository] Registration error: $e\n$stackTrace");
      throw Exception("Something went wrong during registration.");
    }
  }

  /// Registers a user using email and password via FirebaseAuth
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e, stackTrace) {
      debugPrint("[AuthRepository] Registration error: $e\n$stackTrace");
      throw Exception("Something went wrong during registration.");
    }
  }

  Future <void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    }catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
  try {
    if (kIsWeb) {
      // 🔥 Web-specific sign-in
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      return await FirebaseAuth.instance.signInWithPopup(googleProvider);
    } else {
      // 📱 Mobile sign-in
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credentials);
    }
  } catch (e) {
    if (kDebugMode) print('Google sign-in error: $e');
    return null;
  }
}








  Future <void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
      
    }catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }



}


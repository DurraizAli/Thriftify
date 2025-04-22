import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as storage;
import 'package:thriftify_fyp_1/features/authentication/screens/login/login.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/onboarding/onboarding.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    _screenRedirect();
  }

  Future<void> _screenRedirect() async {
    deviceStorage.writeIfNull('IsFirstTime', true);
    final isFirstTime = deviceStorage.read('IsFirstTime') as bool;

    if (isFirstTime) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const OnBoardingScreen());
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
}

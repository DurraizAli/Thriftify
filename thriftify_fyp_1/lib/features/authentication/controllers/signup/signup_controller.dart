import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thriftify_fyp_1/data/repositories/authentication/authentication_repositories.dart';
import 'package:thriftify_fyp_1/data/repositories/user/user_repository.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/signup/verify_email.dart';
import 'package:thriftify_fyp_1/features/personalization/models/user_model.dart';
import 'package:thriftify_fyp_1/utils/constants/image_strings.dart';
import 'package:thriftify_fyp_1/utils/popups/full_screen_loader.dart';
import 'package:thriftify_fyp_1/utils/helpers/network_manager.dart';
import 'package:thriftify_fyp_1/utils/popups/loader.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Controllers
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();

  final signupFormKey = GlobalKey<FormState>();

  // Sign Up Function
  Future<void> signup() async {
    try {
      // Show loading dialog
      TFullScreenLoader.openLoadingDialog(
        "We are processing your information",
        TImages.success_animation,
      );

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackbar(
          title: "No Internet Connection",
          message: "Please check your connection and try again.",
        );
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackbar(
          title: "Accept the privacy policy to continue",
          message:
              "In order to create an account, you must accept the privacy policy and terms of service.",
        );
        return;
      }

      // Register user with Firebase Auth
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      if (userCredential.user == null) {
        TFullScreenLoader.stopLoading();
        throw Exception("User registration failed");
      }

      // Create UserModel and save in Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Success feedback
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackbar(
        title: 'Congratulations!',
        message: "Your account has been created. Verify your email address.",
      );

      // Navigate to Verify Email Screen
      Get.to(() =>  VerifyEmailScreen(email: email.text.trim(),));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackbar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    }
  }
}


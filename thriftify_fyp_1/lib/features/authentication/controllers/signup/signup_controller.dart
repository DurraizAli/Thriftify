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
  //Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  //SignUp
  void signup() async {
    try {
      //start loading
      TFullScreenLoader.openLoadingDialog(
          "We are processing your information", TImages.onboarding2);

      //Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      //Form Validation
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //Check privacy policy
      if (!privacyPolicy.value) {
        TLoaders.warningSnackbar(
            title: "Accept the privacy policy to continue",
            message:
                "In order to create account you must have to accept the privacy policy and terms of service");
        return;
      }

      // add data in firebase, REgister user
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(email.text.trim(), password.text.trim())
          .then((value) {});

      //save data in Firebase Firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '');

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      //success msg
      TLoaders.successSnackbar(
          message: "Your Account has been created, Verify Email Address",
          title: 'Congratulations!');
      //Move to verify email screen
      Get.to(() => const VerifyEmailScreen());
      
      
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackbar(message: e.toString(), title: 'Oh Snap!');
    } 
  }
}

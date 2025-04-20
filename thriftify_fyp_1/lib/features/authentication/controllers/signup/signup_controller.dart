import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  Future<void> signup() async {
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

      // add data in firebase
      
    } catch (e) {
      TLoaders.errorSnackbar(message: e.toString(), title: 'Oh Snap!');
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }
}

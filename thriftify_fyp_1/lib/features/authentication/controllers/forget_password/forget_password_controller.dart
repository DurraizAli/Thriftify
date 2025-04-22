import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:thriftify_fyp_1/data/repositories/authentication/authentication_repositories.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:thriftify_fyp_1/utils/constants/image_strings.dart';
import 'package:thriftify_fyp_1/utils/helpers/network_manager.dart';
import 'package:thriftify_fyp_1/utils/popups/full_screen_loader.dart';
import 'package:thriftify_fyp_1/utils/popups/loader.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  sendPasswordResetEmail() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing your request...', TImages.productImage1);

      final isConnected =await NetworkManager.instance.isConnected();
      if (!isConnected) {TFullScreenLoader.stopLoading(); return;}

      if(!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance.sendPasswordResetEmial(email.text.trim());


      TFullScreenLoader.stopLoading();

      TLoaders.successSnackbar(title: 'Email Sent',
        message: 'Email link sent to reset your password'.tr);

        Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackbar(title: 'Oh Snap', message: e.toString());
    }
  }
  resendPasswordResetEmail(String email) async {
     try {
      TFullScreenLoader.openLoadingDialog('Processing your request...', TImages.productImage1);

      final isConnected =await NetworkManager.instance.isConnected();
      if (!isConnected) {TFullScreenLoader.stopLoading(); return;}

     
      await AuthenticationRepository.instance.sendPasswordResetEmial(email);


      TFullScreenLoader.stopLoading();

      TLoaders.successSnackbar(title: 'Email Sent',
        message: 'Email link sent to reset your password'.tr);

        
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackbar(title: 'Oh Snap', message: e.toString());
    }
  }
} 
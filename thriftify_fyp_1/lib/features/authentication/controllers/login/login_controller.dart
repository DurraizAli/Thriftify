import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thriftify_fyp_1/data/repositories/authentication/authentication_repositories.dart';
import 'package:thriftify_fyp_1/utils/constants/image_strings.dart';
import 'package:thriftify_fyp_1/utils/helpers/network_manager.dart';
import 'package:thriftify_fyp_1/utils/popups/full_screen_loader.dart';
import 'package:thriftify_fyp_1/utils/popups/loader.dart';

class LoginController extends GetxController{
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final locaLStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  void onInit() {
    email.text = locaLStorage.read('REMEBER_ME_EMAIL');
    password.text = locaLStorage.read('REMEMBER_ME_PASSWORD');
    super.onInit();
  }


  Future<void> emailAndPasswordSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.success_animation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        locaLStorage.write('REMEBER_ME_EMAIL', email.text.trim());
        locaLStorage.write('REMEBER_ME_PASSWORD', password.text.trim());
      }


      final UserCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      TFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    
    
    
    
    
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackbar(title: 'Oh Snap', message: e.toString());
    }
  }
  

}
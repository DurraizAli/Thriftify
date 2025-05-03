import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:thriftify_fyp_1/common/widgets/success_screen/success_screen.dart';
import 'package:thriftify_fyp_1/data/repositories/authentication/authentication_repositories.dart';
import 'package:thriftify_fyp_1/utils/constants/image_strings.dart';
import 'package:thriftify_fyp_1/utils/constants/text_strings.dart';
import 'package:thriftify_fyp_1/utils/popups/loader.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();


@override
void onInit() {
  sendEmailVerification();
  setTimerForAutoRedirect();
  super.onInit();
}


sendEmailVerification() async {
  try {
    await AuthenticationRepository.instance.sendEmailVerification();
    TLoaders.successSnackbar(title: 'Email Sent', message: 'Please check your inbox and verify your email.');
  }  catch (e) {
    TLoaders.errorSnackbar(title: 'Oh Snap!', message: e.toString());
  }
}

setTimerForAutoRedirect(){
  Timer.periodic(
    const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
          () => SuccessScreen(image: TImages.success_animation, title: TTexts.yourAccountCreated, subTitle: TTexts.yourAccountCreatedSubTitle, 
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),),
        );
      } 
    
  },
  );
}

checkEmailVerifictaionStatus() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if(currentUser != null && currentUser.emailVerified) {
    Get.off(
      () => SuccessScreen(
        image: TImages.success_animation, title: TTexts.yourAccountCreated, subTitle: TTexts.yourAccountCreatedSubTitle, 
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),)
    );
  }
}

}
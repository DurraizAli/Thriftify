import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thriftify_fyp_1/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/login/login.dart';
import 'package:thriftify_fyp_1/utils/constants/image_strings.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';
import 'package:thriftify_fyp_1/utils/constants/text_strings.dart';
import 'package:thriftify_fyp_1/utils/helpers/helper_functions.dart';


class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Appbar to go back OR close all screens and Goto LoginScreen()
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [ IconButton(onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.clear),)],
        
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Image with 60% of screen width
              Image(
                image: const AssetImage(TImages.onboarding1),
                width: THelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Title & SubTitle
              Text(TTexts.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),
              
              Text(
                TTexts.changeYourPasswordSubTitle1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Buttons
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.offAll(()=> const LoginScreen()), child:  Text(TTexts.done,))),
              const SizedBox(height: TSizes.spaceBtwItems,),


              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email), child:  Text(TTexts.done,))),
              
              
            ],
          ),
        ),
      ),
    );
  }
}
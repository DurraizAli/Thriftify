import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thriftify_fyp_1/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';
import 'package:thriftify_fyp_1/utils/constants/text_strings.dart';
import 'package:thriftify_fyp_1/utils/validators/validation.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController()); 
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            Text(
              TTexts.forgotPassword, style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox( height: TSizes.spaceBtwItems,),
            Text( TTexts.forgotPasswordSubtitle, style: Theme.of(context).textTheme.headlineSmall,),
            const SizedBox(height: TSizes.spaceBtwItems),
// Now the form to add the email
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: TValidator.validateEmail, decoration: const InputDecoration(labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct_right)),)),
            const SizedBox(height: TSizes.spaceBtwItems,),
           SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.sendPasswordResetEmail(),
              child: const Text(TTexts.forgotPassword),
            ),
           )
          ],
        ),
      ),
      
    );
  }
}

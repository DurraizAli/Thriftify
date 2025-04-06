import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';
import 'package:thriftify_fyp_1/utils/constants/text_strings.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
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
            const TextField( decoration: InputDecoration(labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct_right)),),
            const SizedBox(height: TSizes.spaceBtwItems,),
           SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Get.to(const ResetPassword()),
              child: const Text(TTexts.forgotPassword),
            ),
           )
          ],
        ),
      ),
      
    );
  }
}

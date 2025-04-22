import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:iconsax/iconsax.dart";
import "package:thriftify_fyp_1/common/styles/spacing_styles.dart";
import "package:thriftify_fyp_1/features/authentication/controllers/login/login_controller.dart";
import "package:thriftify_fyp_1/features/authentication/screens/password_configuration/forget_password.dart";
import "package:thriftify_fyp_1/features/authentication/screens/signup/signup.dart";
import "package:thriftify_fyp_1/navigation_menu.dart";
import "package:thriftify_fyp_1/utils/constants/colors.dart";
import "package:thriftify_fyp_1/utils/constants/image_strings.dart";
import "package:thriftify_fyp_1/utils/constants/sizes.dart";
import "package:thriftify_fyp_1/utils/constants/text_strings.dart";
import "package:thriftify_fyp_1/utils/helpers/helper_functions.dart";
import "package:thriftify_fyp_1/utils/validators/validation.dart";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            children: [
              TLoginHeader(dark: dark),

              const TLoginForm(),
              //Divider
              const TFormDivider(dividerText: TTexts.orsignInWith,),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Footer
             const  TSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}

class TSocialButtons extends StatelessWidget {
  const TSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //google logo
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: TColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () {},
              icon: const Image(
                width: TSizes.iconMd,
                height: TSizes.iconMd,
                image: AssetImage(TImages.google),
              )),
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        //facebook logo
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: TColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
              onPressed: () {},
              icon: const Image(
                width: TSizes.iconMd,
                height: TSizes.iconMd,
                image: AssetImage(TImages.facebook),
              )),
        ),
      ],
    );
  }
}

class TFormDivider extends StatelessWidget {
  const TFormDivider({
    super.key,
    required this.dividerText,
  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Divider(
          color: dark ? TColors.darkGrey : TColors.grey,
          thickness: 0.5,
          indent: 60,
          endIndent: 5,
        )),
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
            child: Divider(
          color: dark ? TColors.darkGrey : TColors.grey,
          thickness: 0.5,
          indent: 5,
          endIndent: 60,
        )),
      ],
    );
  }
}

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
      child: Column(
        children: [
          TextFormField(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email),
          ),
          const SizedBox(
            height: TSizes.spaceBtwInputFields,
          ),

           Obx(
            ()=> TextFormField(
              validator: (value) => TValidator.validatePassword(value),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              decoration:  InputDecoration(
                labelText: TTexts.password,
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: IconButton(onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                 icon:  Icon(controller.hidePassword.value? Iconsax.eye_slash : Iconsax.eye)),
              ),
            ),
          ),

          
          const SizedBox(
            height: TSizes.spaceBtwInputFields / 2,
          ),

          //Remeber me and forgot password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //remember me
              Row(
                children: [
                  Obx(()=> Checkbox(value: controller.rememberMe.value, onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value)),
                  const Text(TTexts.rememberMe),
                ],
              ),
              //forget password
              TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()), child: const Text(TTexts.forgotPassword))
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.emailAndPasswordSignIn(), child: const Text(TTexts.loginButton))),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          //create account button
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => Get.to(()=> const SignupScreen()), child: const Text(TTexts.createAccount))),
        ],
      ),
    ));
  }
}

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(dark ? TImages.lightApplogo : TImages.darkApplogo),
        ),
        Text(TTexts.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(
          height: TSizes.sm,
        ),
        Text(TTexts.loginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thriftify_fyp_1/common/widgets/appbar/appbar.dart';
import 'package:thriftify_fyp_1/common/widgets/images/t_circular_image.dart';
import 'package:thriftify_fyp_1/common/widgets/texts/section_heading.dart';

import 'package:thriftify_fyp_1/features/personalization/controllers/user_controller.dart';
import 'package:thriftify_fyp_1/features/personalization/screens/profile/update_data_UI/update_email.dart';
import 'package:thriftify_fyp_1/features/personalization/screens/profile/update_data_UI/update_phone_number.dart';
import 'package:thriftify_fyp_1/features/personalization/screens/profile/update_data_UI/update_username.dart';
import 'package:thriftify_fyp_1/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:thriftify_fyp_1/features/personalization/screens/profile/update_data_UI/change_name.dart';
import 'package:thriftify_fyp_1/utils/constants/image_strings.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Change Name',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const TCircularImage(
                        image: TImages.user, width: 80, height: 80),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Change Profile Picture')),
                  ],
                ),
              ),


              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),


              const TSectionHeading(
                  title: 'Profile Information', showActionButton: false),
                  

              TProfileMenu(
                  onPressed: ()=> Get.to(()=> const ChangeName()),
                  title: 'Name',
                  value: controller.user.value.fullName),

              TProfileMenu(
                  onPressed: () => Get.to(()=> const ChangeUserName() ),
                  title: 'Username',
                  value: controller.user.value.username),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              const TSectionHeading(
                  title: 'Personal Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                  onPressed: () {},
                  title: 'User ID',
                  value: controller.user.value.id,
                  icon: Iconsax.copy),

              TProfileMenu(
                  onPressed: ()=> Get.to(()=> const ChangeEmail()),
                  title: 'E-mail',
                  value: controller.user.value.email),

              TProfileMenu(
                  onPressed: () =>Get.to(()=> const ChangePhoneNumber()),
                  title: 'Phone Number',
                  value: controller.user.value.phoneNumber),

              TProfileMenu(onPressed: () {}, title: 'Gender', value: 'Male'),

              TProfileMenu(
                  onPressed: () {},
                  title: 'Date of Birth',
                  value: '1 Jan, 1900'),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              Center(
                child: TextButton(
                    onPressed: () => controller.deleteAccountWarningPopup(),
                    child: const Text('Close Account',
                        style: TextStyle(color: Colors.red))),
              )
            ],
          ),
        ),
      ),
    );
  }
}

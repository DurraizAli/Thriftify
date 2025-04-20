import 'package:flutter/material.dart';
import 'package:thriftify_fyp_1/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';
import 'package:thriftify_fyp_1/utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(top: TDeviceUtils.getAppBarHeight(),right: TSizes.defaultSpace,
    child: TextButton(onPressed: ()=> OnBoardingController.instance.skipPage(), child: const Text('Skip'), ) //In summary, onPressed: ()=> OnBoardingController.instance.skipPage() is used to ensure that the skipPage method is called on the singleton instance of OnBoardingController, which is necessary for proper state management and functionality.
    );
  }
}


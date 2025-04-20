import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:thriftify_fyp_1/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:thriftify_fyp_1/utils/constants/colors.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';
import 'package:thriftify_fyp_1/utils/device/device_utility.dart';
import 'package:thriftify_fyp_1/utils/helpers/helper_functions.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance; //we are getting the instance of the controller
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
        bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
        left: TSizes.defaultSpace,
        child: SmoothPageIndicator(
            controller: controller.pageController,
            onDotClicked: controller.dotNavigationClick,
            count: 3,
            effect: ExpandingDotsEffect(
                activeDotColor: dark ? TColors.light : TColors.dark,
                dotHeight: 6)));
  }
}

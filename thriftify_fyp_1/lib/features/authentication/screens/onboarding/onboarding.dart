import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thriftify_fyp_1/features/authentication/controllers/onboarding/onboarding_controller.dart';

import 'package:thriftify_fyp_1/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:thriftify_fyp_1/utils/constants/image_strings.dart';
import 'package:thriftify_fyp_1/utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Get instance of onboarding controller by using GETX
    final controller = Get.put(OnBoardingController());
    //Get.put is the method used to initialize a dependency for the first time. This method makes a dependency available throughout the widget tree, which can then be accessed via Get.find. Get.put internally calls Get.find, which injects the dependency immediately into the class.
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          
          controller: controller.pageController,
          onPageChanged: controller.updatePageIndicator,
          children: const [
          OnBoardingPage(
            image: TImages.onboarding1,
            title: TTexts.onBoardingTitle1,
            subTitle: TTexts.onBoardingSubTitle1,
          ),
          OnBoardingPage(
            image: TImages.onboarding2,
            title: TTexts.onBoardingTitle2,
            subTitle: TTexts.onBoardingSubTitle2,
          ),
          OnBoardingPage(
            image: TImages.onboarding3,
            title: TTexts.onBoardingTitle3,
            subTitle: TTexts.onBoardingSubTitle3,
          ),
        ]),
        const OnBoardingSkip(),

        //Dot navigation SmoothPageIndicator
        const OnBoardingDotNavigation(),

        const OnBoardingNextButton()
      ],
    ));
  }
}


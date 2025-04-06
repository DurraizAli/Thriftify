import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/login/login.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance =>
      Get.find(); //This line will be called when this line runs
  //final controller = OnBoardingController.instance;
  //variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0
      .obs; //Rx type which is the getx method to define variables that can easily be change and state is going to be changed and the design as well.

  //update current Index when page scroll

  void updatePageIndicator(index) {
    currentPageIndex.value = index;
  }

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage() {
  if (currentPageIndex.value == 2) {
    // If the current page index is 2, navigate to the next page
    Get.offAll(const LoginScreen());
  } else {
    int nextPageIndex = currentPageIndex.value + 1;
    pageController.animateToPage(
      nextPageIndex,
      duration: const Duration(milliseconds: 300), // Smooth animation duration
      curve: Curves.easeInOut, // Animation curve
    );
    currentPageIndex.value = nextPageIndex; // Update the current page index
  }
}

  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpTo(2);
  }
}

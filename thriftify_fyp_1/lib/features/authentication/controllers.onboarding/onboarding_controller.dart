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
      //if the current page index is 2 then we will navigate to the next page
      //navigate to the next page
      Get.offAll(const LoginScreen());
    } else {
      double page = currentPageIndex.value + 1;
      pageController.jumpTo(page);
    }
  }

  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpTo(2);
  }
}

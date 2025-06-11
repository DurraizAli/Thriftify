import 'package:get/get.dart';

class ProductImageSliderController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final int size = 10;

  void updateIndex(int index) {
    currentIndex.value = index;
  }
}

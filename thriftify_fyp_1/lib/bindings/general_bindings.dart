import 'package:get/get.dart';
import 'package:thriftify_fyp_1/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    // Add your dependencies here
    // For example:
    // Get.lazyPut<YourController>(() => YourController());
    Get.put(NetworkManager());
  }
}

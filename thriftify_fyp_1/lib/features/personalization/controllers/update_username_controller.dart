import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:thriftify_fyp_1/data/repositories/user/user_repository.dart';
import 'package:thriftify_fyp_1/features/personalization/controllers/user_controller.dart';
import 'package:thriftify_fyp_1/features/personalization/screens/profile/profile.dart';
import 'package:thriftify_fyp_1/utils/constants/image_strings.dart';
import 'package:thriftify_fyp_1/utils/helpers/network_manager.dart';
import 'package:thriftify_fyp_1/utils/popups/full_screen_loader.dart';
import 'package:thriftify_fyp_1/utils/popups/loader.dart';

class UpdateUserName extends GetxController {
  static UpdateUserName get instance => Get.find();

  final username = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateusername = GlobalKey<FormState>();

  //init user data when home screen appears

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  Future<void> initializeNames() async {
    username.text = userController.user.value.username;
  }

  //update user name in firestore
  Future<void> updateUserName() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "We are updating your information", TImages.onboarding3);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!updateusername.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      //update user's first name and last name in firebase
      Map<String, dynamic> user = {
        'username': username.text.trim(),
      };
      await userRepository.updateSingleField(user);

      //Show success message
      TLoaders.successSnackbar(
          message: 'Your username has been updated', title: 'Congrats!');

      //Move to next screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackbar(title: 'Oh Snap!', message: e.toString());
    }
  }
}

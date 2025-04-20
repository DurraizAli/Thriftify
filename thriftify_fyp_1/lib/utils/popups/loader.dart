import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:thriftify_fyp_1/utils/constants/colors.dart';

class TLoaders {
  static void successSnackbar({String? title = 'Success', required String message}) {
    Get.snackbar(
      title!,
      message,
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      borderRadius: 10,
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
    );
  }

  static void errorSnackbar({required title, message =''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      borderRadius: 10,
      icon: const Icon(Iconsax.warning_2, color: TColors.white),
    );
  }

  static void warningSnackbar({String? title = 'Warning', String? message = 'Something went wrong'}) {
    Get.snackbar(
      title!,
      message!,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      icon: const Icon(Iconsax.warning_2, color: TColors.white),
    );
  }

  static void infoSnackbar({String? title = 'Info', required String message}) {
    Get.snackbar(
      title!,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      icon: const Icon(Icons.info_outline, color: Colors.white),
    );
  }

  static void showLoading() {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
      name: 'loading_dialog',
    );
  }

  static void hideLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  static void showCustomLoading({String? animationAsset}) {
    Get.dialog(
      Center(
        child: SizedBox(
          width: 120,
          height: 120,
          child: Lottie.asset(
            animationAsset ?? 'assets/animations/loading.json', // You might need to create or add a default loading animation
            repeat: true,
            reverse: false,
            animate: true,
          ),
        ),
      ),
      barrierDismissible: false,
      name: 'custom_loading_dialog',
    );
  }

  static void showAlertDialog({
    String? title = 'Alert',
    required String content,
    String? confirmText = 'Okay',
    VoidCallback? onConfirm,
    String? cancelText,
    VoidCallback? onCancel,
  }) {
    Get.defaultDialog(
      title: title!,
      content: Text(content),
      textConfirm: confirmText,
      onConfirm: onConfirm,
      textCancel: cancelText,
      onCancel: onCancel,
    );
  }

  // You can add more custom loaders or dialogs as needed for your app
}
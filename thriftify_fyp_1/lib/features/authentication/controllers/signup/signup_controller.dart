import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:thriftify_fyp_1/utils/constants/image_strings.dart';
import 'package:thriftify_fyp_1/utils/popups/full_screen_loader.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();



  final email = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();


  Future<void> signup() async {
    try {
      TFullScreenLoader.openLoadingDialog('We are proccesing your information....', TImages.google);


      
    // ignore: empty_catches
    } catch (e){}
   

    }
  }

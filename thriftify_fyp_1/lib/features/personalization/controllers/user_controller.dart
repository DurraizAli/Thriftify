import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:thriftify_fyp_1/data/repositories/user/user_repository.dart';
import 'package:thriftify_fyp_1/features/personalization/models/user_model.dart';
import 'package:thriftify_fyp_1/utils/popups/loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userRepository = Get.put(UserRepository());



  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if(userCredentials != null){
        final nameParts = UserModel.nameParts(userCredentials.user!.displayName?? '');
        final username = UserModel.generateUsername(userCredentials.user!.displayName?? '');

        final user = UserModel(
          id: userCredentials.user!.uid,
          firstName: nameParts[0],
           lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' '): '',
            username: username,
             email: userCredentials.user!.email ?? '',
              phoneNumber: userCredentials.user!.phoneNumber ?? '',
               profilePicture: userCredentials.user!.photoURL ?? '',
               );

               await userRepository.saveUserRecord(user);



      } 
      
      }catch (e) {
        TLoaders.warningSnackbar(title: 'Data not saved', message: 'Something went wrong while saving your information. You can re-save your data in your Profile');
    }
  }
}
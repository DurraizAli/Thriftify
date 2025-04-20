import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as storage;
import 'package:thriftify_fyp_1/features/authentication/screens/login/login.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/onboarding/onboarding.dart';
import 'package:thriftify_fyp_1/features/personalization/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //RgisterUser 
  Future<void> saveUserRecord(
      UserModel user) async {
    try {
       await _db.collection("Users").doc(user.id).set(user.toJson());
    } 
    // on FirebaseAuthException catch (e) {
    //   throw TFirebaseAuthException(e.code).message;
    // } on FirebaseException catch (e) {
    //   throw TFirebaseException(e.code).message;
    // } on FormatException catch (_) {
    //   throw TFormatException();
    // } on PlatformException catch (e) {
    //   throw TPlatformException(e.code).message;
    // } 
    catch (e) {
      throw "Some thing went wrong";
    }
  }
}

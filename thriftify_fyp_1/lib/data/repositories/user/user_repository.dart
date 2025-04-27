import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as storage;
import 'package:thriftify_fyp_1/data/exception/t_firebase_exception.dart';
import 'package:thriftify_fyp_1/data/repositories/authentication/authentication_repositories.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/login/login.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/onboarding/onboarding.dart';
import 'package:thriftify_fyp_1/features/personalization/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Save a new user record to Firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } catch (e, stackTrace) {
      debugPrint("[UserRepository] Error saving user: $e\n$stackTrace");
      throw Exception("Something went wrong while saving user record.");
    }
  }

  //Fetch user data from Firestore
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } catch (e, stackTrace) {
      debugPrint("[UserRepository] Error fetching user: $e\n$stackTrace");
      throw Exception("Something went wrong while fetching user record.");
    }
  }

  //update user data in Firestore
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    } catch (e, stackTrace) {
      debugPrint("[UserRepository] Error updating user: $e\n$stackTrace");
      throw Exception("Something went wrong while updating user record.");
    }
  }

  //update anyfield in user data in Firestore
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).update(json);
    } catch (e, stackTrace) {
      debugPrint("[UserRepository] Error updating single field $e\n$stackTrace");
      throw Exception("Something went wrong while updating single field user record.");
    }
  }

  //remove user data from Firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
      
    } catch (e, stackTrace) {
      debugPrint("[UserRepository] Error deleting user: $e\n$stackTrace");
      throw Exception("Something went wrong while deleting user record.");
    }
  }
}

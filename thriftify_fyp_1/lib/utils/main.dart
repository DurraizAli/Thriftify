import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:thriftify_fyp_1/app.dart';
import 'package:thriftify_fyp_1/firebase_options.dart';

Future<void> main() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform).then((FirebaseApp value) => Get.put
    );

  
  runApp(const App());
}


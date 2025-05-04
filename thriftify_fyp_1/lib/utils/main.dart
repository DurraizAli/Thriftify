import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:thriftify_fyp_1/app.dart';
import 'package:thriftify_fyp_1/data/repositories/authentication/authentication_repositories.dart';
import 'package:thriftify_fyp_1/features/shop/controllers/category_controller.dart';
import 'package:thriftify_fyp_1/features/shop/controllers/home_controller.dart';
import 'package:thriftify_fyp_1/firebase_options.dart';

Future<void> main() async {

  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform).then((FirebaseApp value) => Get.put(AuthenticationRepository()));
    
  
  Get.put(HomeController());

  Get.put(CategoryController());
  
  runApp(const App());
}


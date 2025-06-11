import 'dart:io';
import 'package:image_cropper_platform_interface/image_cropper_platform_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:thriftify_fyp_1/features/shop/controllers/product_controller.dart';
import 'package:thriftify_fyp_1/features/shop/screens/home.dart';
import 'package:thriftify_fyp_1/routes/routes.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class PostAdController extends GetxController {
  final uuid = Uuid();
  final name = ''.obs;
  final price = ''.obs;
  final description = ''.obs;
  final category = ''.obs;
  final brand = ''.obs;
  final phone = ''.obs;
  final images = <XFile>[].obs;
  final isLoading = false.obs;

  final _picker = ImagePicker();
  final RxList<XFile> croppedImages = <XFile>[].obs;

  /// Pick multiple images
  Future<void> pickImages() async {
    try {
      final pickedFiles = await _picker.pickMultiImage(imageQuality: 80);
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        images.assignAll(pickedFiles);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick images: $e");
    }
  }

  /// Upload ad data to Firebase
  Future<void> uploadAd() async {
    final parsedPrice = double.tryParse(price.value);
    if (name.value.isEmpty ||
        price.value.isEmpty ||
        description.value.isEmpty ||
        category.value.isEmpty ||
        brand.value.isEmpty ||
        phone.value.isEmpty ||
        (images.isEmpty && croppedImages.isEmpty) ||
        parsedPrice == null) {
      Get.snackbar("Error", "Enter all values correctly");
      return;
    }

    try {
      isLoading.value = true;

      // Upload all cropped images and normal images
      final croppedImageUrls = await Future.wait(
        croppedImages.map((xfile) => removeBackgroundAndUpload(xfile)),
      );
      final imageUrls = await Future.wait(
        images.map((xfile) => uploadImage(xfile)),
      );
      final allImageUrls = [...imageUrls, ...croppedImageUrls];

      await FirebaseFirestore.instance.collection('ads').add({
        'name': name.value,
        'price': parsedPrice,
        'description': description.value,
        'category': category.value,
        'brand': brand.value,
        'phone': phone.value,
        'imageUrls': allImageUrls,
        'createdAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar("Success", "Ad posted successfully!");
      _clearForm();
      final productController = Get.find<ProductController>();
      await productController.fetchProducts();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Upload a single image to Firebase Storage
  Future<String> uploadImage(XFile image) async {
    try {
      final filename = '${uuid.v4()}_${basename(image.path)}';
      final ref = FirebaseStorage.instance.ref('product_images/$filename');
      final file = File(image.path);
      final uploadTask = await ref.putFile(file);
      final url = await uploadTask.ref.getDownloadURL();
      return url;
    } catch (e) {
      throw 'Error uploading image to Firebase Storage: $e';
    }
  }

  /// Remove background and upload to Firebase Storage
  Future<String> removeBackgroundAndUpload(XFile cropped) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse('http://192.168.137.1:3000/remove-bg'));
      request.files
          .add(await http.MultipartFile.fromPath('image', cropped.path));
      final response = await request.send();

      if (response.statusCode == 200) {
        final bytes = await response.stream.toBytes();
        if (bytes.isEmpty) throw 'Received empty image bytes from server';
        final filename = '${uuid.v4()}_bg_removed.png';
        final ref = FirebaseStorage.instance.ref('product_images/$filename');
        final uploadTask = await ref.putData(bytes);
        final url = await uploadTask.ref.getDownloadURL();
        return url;
      } else {
        throw 'Background removal failed: ${response.statusCode}';
      }
    } catch (e) {
      print('removeBackgroundAndUpload error: $e');
      rethrow;
    }
  }

  /// Reset all fields after success
  void _clearForm() {
    name.value = '';
    price.value = '';
    description.value = '';
    category.value = '';
    brand.value = '';
    phone.value = '';
    images.clear();
    croppedImages.clear();
  }

  Future<void> pickAndCropImage() async {
    bool granted = false;

    if (Platform.isAndroid) {
      if (await Permission.photos.isGranted) {
        granted = true;
      } else {
        var status = await Permission.photos.request();
        granted = status.isGranted;
      }
      if (!granted && await Permission.storage.isDenied) {
        var status = await Permission.storage.request();
        granted = status.isGranted;
      }
    } else if (Platform.isIOS) {
      var status = await Permission.photos.request();
      granted = status.isGranted;
    }

    if (!granted) {
      Get.snackbar("Permission Denied", "Please allow photo access.");
      return;
    }

    Get.defaultDialog(
      title: "Crop Image",
      middleText: "Please crop the image to the edges of the product.",
      textConfirm: "OK",
      onConfirm: () async {
        Get.back();
        final picked = await _picker.pickImage(source: ImageSource.gallery);
        print('Picked: $picked');
        if (picked != null) {
          final cropped = await ImageCropper().cropImage(
            sourcePath: picked.path,
            uiSettings: [
              AndroidUiSettings(
                toolbarTitle: 'Crop Product Image',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                lockAspectRatio: false,
              ),
              IOSUiSettings(
                title: 'Crop Product Image',
                aspectRatioLockEnabled: false,
              ),
            ],
          );
          if (cropped != null) {
            croppedImages.add(XFile(cropped.path));
          }
        }
      },
    );
  }
}

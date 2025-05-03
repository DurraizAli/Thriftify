import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:thriftify_fyp_1/features/shop/models/category_model.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();
  //variable to store the instance of firestore
  final _db = FirebaseFirestore.instance;

  /// Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } catch (e) {
      throw 'Something went wrong while fetching categories. $e';
    }
  }

  // Future<void> uploadDummyData(List<CategoryModel> categories) async {
  //   try {
  //     // Upload all the Categories along with their Images
  //     final storage = Get.put(TFirebaseStorageService());

  //     // Loop through each category
  //     for (var category in categories) {
  //       // Get ImageData link from the local assets
  //       final file = await storage.getImageDataFromAssets(category.image);

  //       // Upload Image and Get its URL
  //       final url =
  //           await storage.uploadImageData('Categories', file, category.name);

  //       // Assign URL to Category.image attribute
  //       category.image = url;

  //       // Store Category in Firestore
  //       await _db
  //           .collection("Categories")
  //           .doc(category.id)
  //           .set(category.toJson());
  //     }
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again';
  //   }
  // }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:thriftify_fyp_1/features/shop/models/banner_model.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

 Future<List<BannerModel>> fetchBanners() async {
    try {
      final result =
          await _db.collection('Banners').where('Active', isEqualTo: true).get();
      return result.docs
          .map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching Banners.$e';
    }
  }
}

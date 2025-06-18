import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thriftify_fyp_1/features/shop/models/product_model.dart';


class ProductController extends GetxController {
  
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxnString selectedBrand = RxnString();

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final snapshot = await FirebaseFirestore.instance.collection('ads').orderBy('createdAt', descending: false).get();
      print('Fetched ${snapshot.docs.length} products');
      final fetchedProducts = snapshot.docs.map((doc) {
        print(doc.data()); // <-- Add this
        return ProductModel.fromSnapshot(doc);
      }).toList();
      products.assignAll(fetchedProducts);
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

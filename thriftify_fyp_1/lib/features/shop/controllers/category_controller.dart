import 'package:get/get.dart';
import 'package:thriftify_fyp_1/data/repositories/categories/category_repository.dart';
import 'package:thriftify_fyp_1/utils/popups/loader.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  final _categoryRepository = Get.put(CategoryRepository());
  final isLoading = false.obs;

  // Now these are lists of category names (strings)
  RxList<String> allCategories = <String>[].obs;
  RxList<String> featuredCategories = <String>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// Load category data
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      // Fetch unique category names from Firestore 'ads'
      final categories = await _categoryRepository.getAllCategoriesFromAds();

      // Update the categories list
      allCategories.assignAll(categories);

      // For now, just show all as featured (or you can filter/take top N)
      featuredCategories.assignAll(allCategories);
    } catch (e) {
      TLoaders.errorSnackbar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

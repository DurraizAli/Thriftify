import 'package:get/get.dart';
import 'package:thriftify_fyp_1/data/repositories/banners/banner_repository.dart';
import 'package:thriftify_fyp_1/features/shop/models/banner_model.dart';
import 'package:thriftify_fyp_1/utils/popups/loader.dart';

class BannerController extends GetxController {
  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;
  void UpdatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
    
  }
  Future<void> fetchBanners() async {
    try {
      // Show loader while loading categories
      isLoading.value = true;

      // Fetch Banners
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      // Assign Banners
      this.banners.assignAll(banners);
    } catch (e) {
      TLoaders.errorSnackbar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove Loader
      isLoading.value = false;
    }
  }
}

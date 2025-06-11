import 'package:thriftify_fyp_1/features/shop/models/banner_model.dart';
import 'package:thriftify_fyp_1/routes/routes.dart';
import 'package:thriftify_fyp_1/utils/constants/image_strings.dart';

class TDummyData{
  static final List<BannerModel> banners = [
    BannerModel(
        imageUrl: TImages.banner1, targetScreen: TRoutes.allProducts, active: true),
    BannerModel(
        imageUrl: TImages.banner2, targetScreen: TRoutes.allProducts, active: true),
    BannerModel(
        imageUrl: TImages.banner3,
        targetScreen: TRoutes.allProducts,
        active: true),
    // BannerModel(
    //     imageUrl: TImages.banner4, targetScreen: TRoutes.search, active: true),
    // BannerModel(
    //     imageUrl: TImages.banner5,
    //     targetScreen: TRoutes.settings,
    //     active: true),
    // BannerModel(
    //     imageUrl: TImages.banner6,
    //     targetScreen: TRoutes.userAddress,
    //     active: true),
    // BannerModel(
    //     imageUrl: TImages.banner7,
    //     targetScreen: TRoutes.checkout,
    //     active: false),
  ];
}
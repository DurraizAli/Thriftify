import 'package:get/get.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/login/login.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/onboarding/onboarding.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/signup/signup.dart';
import 'package:thriftify_fyp_1/features/authentication/screens/signup/verify_email.dart';
import 'package:thriftify_fyp_1/features/personalization/screens/profile/profile.dart';
import 'package:thriftify_fyp_1/features/shop/screens/home.dart';
import 'package:thriftify_fyp_1/features/shop/screens/store/store.dart';
import 'package:thriftify_fyp_1/routes/routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.store, page: () =>  StoreScreen()),
    // GetPage(name: TRoutes.favourites, page: () => const FavouritesScreen()),
    // GetPage(name: TRoutes.settings, page: () => const SettingsScreen()),
    // GetPage(
    //     name: TRoutes.productReviews, page: () => const ProductReviewsScreen()),
    // GetPage(name: TRoutes.order, page: () => const OrderScreen()),
    // GetPage(name: TRoutes.checkout, page: () => const CheckoutScreen()),
    // GetPage(name: TRoutes.cart, page: () => const CartScreen()),
    GetPage(name: TRoutes.userProfile, page: () => const ProfileScreen()),
    // GetPage(name: TRoutes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: TRoutes.signup, page: () => const SignupScreen()),
    GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: TRoutes.signIn, page: () => const LoginScreen()),
    GetPage(
        name: TRoutes.forgetPassword, page: () => const ForgetPassword()),
    GetPage(name: TRoutes.onBoarding, page: () => const OnBoardingScreen()),
    // Add more GetPage entries as needed
  ];
}

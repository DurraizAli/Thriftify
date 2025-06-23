import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:thriftify_fyp_1/common/widgets/layouts/grid_layout.dart';
import 'package:thriftify_fyp_1/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:thriftify_fyp_1/common/widgets/texts/section_heading.dart';
import 'package:thriftify_fyp_1/features/shop/controllers/product_controller.dart';
import 'package:thriftify_fyp_1/features/shop/screens/all_products/all_products.dart';
import 'package:thriftify_fyp_1/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:thriftify_fyp_1/features/shop/screens/home/widgets/home_categories.dart';
import 'package:thriftify_fyp_1/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:thriftify_fyp_1/features/shop/screens/product_details/product_detail.dart';
import 'package:thriftify_fyp_1/features/shop/screens/store/store.dart';
import 'package:thriftify_fyp_1/navigation_menu.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();
    final navController = Get.find<NavigationController>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 245),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections),
                  TSearchContainer(text: 'Search in Store'),
                  SizedBox(height: TSizes.spaceBtwSections),
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),
                        THomeCategories()
                      ],
                    ),
                  ),
                  SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TPromoSlider(),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  TSectionHeading(
                    title: 'Popular Products',
                    onPressed: () {
                      navController.selectedIndex.value =
                          1; // 1 is the Store tab
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
//---------------------------------------------------------------
                  /// 🔥 StreamBuilder to fetch real-time Firestore ads
                  // StreamBuilder<QuerySnapshot>(
                  //   stream: FirebaseFirestore.instance
                  //       .collection('ads')
                  //       .orderBy('createdAt', descending: true)
                  //       .snapshots(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return const CircularProgressIndicator();
                  //     }
                  //     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  //       return const Text("No products found");
                  //     }

                  //     final ads = snapshot.data!.docs;

                  //     return TGridLayout(
                  //       itemCount: ads.length,
                  //       itemBuilder: (_, index) {
                  //         final ad = ads[index];
                  //         return TProductCardVertical(
                  //           title: ad['name'] ?? '',
                  //           brand: ad['category'] ?? '',
                  //           price: ad['price'] ?? '',
                  //           imageUrl: (ad['imageUrls'] as List).isNotEmpty
                  //               ? ad['imageUrls'][0]
                  //               : '',
                  //         );
                  //       },
                  //     );
                  //   },
                  // ),

                  //-----------------------------------------------------------------------------------------

                  Obx(() {
                    if (productController.isLoading.value) {
                      return const CircularProgressIndicator();
                    }
                    if (productController.products.isEmpty) {
                      return const Text("No products found");
                    }
                    return TGridLayout(
                      itemCount: 4,
                      itemBuilder: (_, index) {
                        final product = productController.products[index];
                        return TProductCardVertical(
                          title: product.name,
                          brand: product.category,
                          price: product.price,
                          imageUrl: product.imageUrls.isNotEmpty
                              ? product.imageUrls[0]
                              : '',
                          onTap: () {
                            Get.to(() => ProductDetailScreen(product: product));
                          },
                        );
                      },
                    );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

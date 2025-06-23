import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thriftify_fyp_1/common/widgets/appbar/appbar.dart';
import 'package:thriftify_fyp_1/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';
import '../../controllers/product_controller.dart';

class SubCategoriesScreen extends StatelessWidget {
  final String categoryName;
  const SubCategoriesScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();

    return Scaffold(
      appBar: TAppBar(title: Text(categoryName), showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(() {
          if (productController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // Filter products by category (case-insensitive, trimmed)
          final filteredProducts = productController.products
              .where((product) =>
                  (product.category ?? '').trim().toLowerCase() ==
                  categoryName.trim().toLowerCase())
              .toList();

          if (filteredProducts.isEmpty) {
            return const Center(
                child: Text("No products found for this category"));
          }

          return ListView.separated(
            itemCount: filteredProducts.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: TSizes.spaceBtwItems),
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return TProductCardHorizontal(product: product);
            },
          );
        }),
      ),
    );
  }
}

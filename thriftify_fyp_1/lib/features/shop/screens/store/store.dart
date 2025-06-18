import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thriftify_fyp_1/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:thriftify_fyp_1/common/widgets/layouts/grid_layout.dart';
import 'package:thriftify_fyp_1/features/shop/controllers/product_controller.dart';
import 'package:thriftify_fyp_1/features/shop/screens/home.dart';
import 'package:thriftify_fyp_1/features/shop/screens/product_details/product_detail.dart';
import 'package:thriftify_fyp_1/navigation_menu.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';

class StoreScreen extends StatelessWidget {
  StoreScreen({super.key});

  final ProductController productController = Get.find<ProductController>();
  final RxnString selectedBrand = RxnString();
  final RxnString selectedCategory = RxnString();
  final RxString selectedSort = 'Newest'.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Get.back(),
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Obx(() {
          if (productController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (productController.products.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          final brands = productController.products
              .map((product) => product.brand)
              .toSet()
              .toList();
          final categories = productController.products
              .map((product) => product.category)
              .toSet()
              .toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brands heading
                const Text(
                  'Brands',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 12),
                // Brands as buttons
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: brands.map((brand) {
                    final bool isActive = selectedBrand.value == null ||
                        selectedBrand.value == brand;
                    return TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: isActive
                            ? Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.15)
                            : Colors.grey.shade200,
                        foregroundColor: isActive
                            ? Theme.of(context).colorScheme.primary
                            : Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textStyle: const TextStyle(fontSize: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        if (selectedBrand.value == brand) {
                          selectedBrand.value = null;
                        } else {
                          selectedBrand.value = brand;
                        }
                      },
                      child: Text(brand),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                // Categories heading
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 12),
                // Categories as buttons
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: categories.map((category) {
                    final bool isActive = selectedCategory.value == null ||
                        selectedCategory.value == category;
                    return TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: isActive
                            ? Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.15)
                            : Colors.grey.shade200,
                        foregroundColor: isActive
                            ? Theme.of(context).colorScheme.secondary
                            : Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textStyle: const TextStyle(fontSize: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        if (selectedCategory.value == category) {
                          selectedCategory.value = null;
                        } else {
                          selectedCategory.value = category;
                        }
                      },
                      child: Text(category),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                // Sort dropdown
                Obx(() => Row(
                      children: [
                        const Text(
                          'Sort by: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        DropdownButton<String>(
                          value: selectedSort.value,
                          items: [
                            'Name',
                            'Higher Price',
                            'Lower Price',
                            'Newest',
                          ]
                              .map((sort) => DropdownMenuItem(
                                    value: sort,
                                    child: Text(sort),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null) selectedSort.value = value;
                          },
                        ),
                      ],
                    )),
                const SizedBox(height: 16),
                // Products heading
                const Text(
                  'Products',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 16),
                // Products grid
                Obx(() {
                  var filteredProducts =
                      productController.products.where((product) {
                    final brandMatch = selectedBrand.value == null ||
                        product.brand == selectedBrand.value;
                    final categoryMatch = selectedCategory.value == null ||
                        product.category == selectedCategory.value;
                    return brandMatch && categoryMatch;
                  }).toList();

                  switch (selectedSort.value) {
                    case 'Name':
                      filteredProducts.sort((a, b) => (a.name ?? '')
                          .toLowerCase()
                          .compareTo((b.name ?? '').toLowerCase()));
                      break;
                    case 'Higher Price':
                      filteredProducts.sort((a, b) {
                        final double priceA =
                            double.tryParse(a.price.toString()) ?? 0.0;
                        final double priceB =
                            double.tryParse(b.price.toString()) ?? 0.0;
                        return priceB.compareTo(priceA);
                      });
                      break;
                    case 'Lower Price':
                      filteredProducts.sort((a, b) {
                        final double priceA =
                            double.tryParse(a.price.toString()) ?? 0.0;
                        final double priceB =
                            double.tryParse(b.price.toString()) ?? 0.0;
                        return priceA.compareTo(priceB);
                      });
                      break;
                    case 'Newest':
                      filteredProducts.sort((a, b) {
                        final aDate = a.createdAt ??
                            DateTime.fromMillisecondsSinceEpoch(0);
                        final bDate = b.createdAt ??
                            DateTime.fromMillisecondsSinceEpoch(0);
                        return bDate.compareTo(aDate);
                      });
                      break;
                  }

                  return filteredProducts.isEmpty
                      ? const Center(
                          child: Padding(
                              padding: EdgeInsets.all(32.0),
                              child: Text("No products for this selection")))
                      : TGridLayout(
                          itemCount: filteredProducts.length,
                          itemBuilder: (_, index) {
                            final product = filteredProducts[index];
                            return TProductCardVertical(
                              title: product.name,
                              brand: product.brand,
                              price: product.price,
                              imageUrl: product.imageUrls.isNotEmpty
                                  ? product.imageUrls[0]
                                  : '',
                              onTap: () {
                                Get.to(() =>
                                    ProductDetailScreen(product: product));
                              },
                            );
                          },
                        );
                }),
              ],
            ),
          );
        }),
      ),
    );
  }
}

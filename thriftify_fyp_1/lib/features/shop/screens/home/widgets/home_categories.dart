import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:thriftify_fyp_1/common/widgets/shimmers/category_shimmer.dart';
import 'package:thriftify_fyp_1/features/shop/controllers/category_controller.dart';
import 'package:thriftify_fyp_1/features/shop/screens/home/widgets/image_text_widgets/vertiacl_image_text.dart';
import 'package:thriftify_fyp_1/features/shop/screens/sub_category/sub_categories.dart';
import 'package:thriftify_fyp_1/utils/constants/image_strings.dart';

class THomeCategories extends StatelessWidget {
  final List<String> categoryIcons = [
    TImages.google,
    TImages.facebook,
    TImages.apple,
    TImages.mango
    // Add more asset/network image paths as needed
  ];
  THomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      if (categoryController.isLoading.value) return const TCategoryShimmer();
      if (categoryController.featuredCategories.isEmpty) {
        return Center(
            child: Text('No Data Found!',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: Colors.white)));
      }
      return SizedBox(
        height: 100,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            final random = Random();
            final iconImage =
                categoryIcons[random.nextInt(categoryIcons.length)];
            return TVerticalImageText(
              image: iconImage,
              title: " $category",
              isNetworkImage: false,
              onTap: () =>
                  Get.to(() => SubCategoriesScreen(categoryName: category)),
            );
          },
        ),
      );
    });
  }
}

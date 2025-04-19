import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:thriftify_fyp_1/features/shop/screens/home/widgets/image_text_widgets/vertiacl_image_text.dart';
import 'package:thriftify_fyp_1/features/shop/screens/sub_category/sub_categories.dart';
import 'package:thriftify_fyp_1/utils/constants/image_strings.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return  TVerticalImageText(image: TImages.facebook, title: 'Shoes', onTap:() => Get.to(()=> const SubCategoriesScreen()) , );
      
        }),
    );
  }
}
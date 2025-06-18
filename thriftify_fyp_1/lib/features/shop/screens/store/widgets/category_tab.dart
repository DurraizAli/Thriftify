import 'package:flutter/material.dart';
import 'package:thriftify_fyp_1/common/widgets/brands/brand_show_case.dart';
import 'package:thriftify_fyp_1/common/widgets/layouts/grid_layout.dart';
import 'package:thriftify_fyp_1/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:thriftify_fyp_1/common/widgets/texts/section_heading.dart';
import 'package:thriftify_fyp_1/features/shop/models/category_model.dart';
import 'package:thriftify_fyp_1/utils/constants/image_strings.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                const TBrandShowcase(
                  images: [
                    TImages.productImage1,
                    TImages.productImage1,
                    TImages.productImage1
                  ],
                ),
                const TBrandShowcase(
                  images: [
                    TImages.productImage1,
                    TImages.productImage1,
                    TImages.productImage1
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
               const  Text("You might also like", style: TextStyle(fontSize: TSizes.fontSizemd, fontWeight: FontWeight.bold),),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TGridLayout(
                    itemCount: 4,
                    itemBuilder: (_, index) => const TProductCardVertical(
                          title: 'Jordan 1',
                          brand: 'Nike',
                          price: '200',
                          imageUrl: 'https://speedsports.pk/cdn/shop/files/AURORA_FJ9509-401_PHSLH000-2000.jpg?v=1728973702',
                        )),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            ),
          ),
        ]);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thriftify_fyp_1/common/styles/shadows.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:thriftify_fyp_1/common/widgets/images/t_rounded_image.dart';
import 'package:thriftify_fyp_1/common/widgets/texts/product_price_text.dart';
import 'package:thriftify_fyp_1/common/widgets/texts/product_title_text.dart';
import 'package:thriftify_fyp_1/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:thriftify_fyp_1/features/shop/screens/product_details/product_detail.dart';
import 'package:thriftify_fyp_1/utils/constants/colors.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';
import 'package:thriftify_fyp_1/utils/helpers/helper_functions.dart';

class TProductCardVertical extends StatelessWidget {
  final String title;
  final String brand;
  final String price;
  final String imageUrl;
  final VoidCallback? onTap;

  const TProductCardVertical({
    super.key,
    required this.title,
    required this.brand,
    required this.price,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      // onTap: () => Get.to(() => ProductDetailScreen(
      //       title: title,
      //       price: price,
      //       imageURl: imageUrl,
      //     )),
      onTap: onTap,  //added this line to allow onTap functionality🔧
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          children: [
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  TRoundedImage(
                    isNetworkImage: true,
                    imageUrl: imageUrl,
                    applyImageRadius: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductTitleText(title: title, smallSize: true),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: TSizes.sm),
                  child: TProductPriceText(price: price),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: TColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(TSizes.cardRadiusMd),
                      bottomRight: Radius.circular(TSizes.productImageRadius),
                    ),
                  ),
                  child: const SizedBox(
                    width: TSizes.iconLg * 1.2,
                    height: TSizes.iconLg * 1.2,
                    child: Center(
                      child: Icon(Iconsax.add, color: TColors.white),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

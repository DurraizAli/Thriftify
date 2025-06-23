import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:thriftify_fyp_1/common/widgets/icons/t_circular_icon.dart';
import 'package:thriftify_fyp_1/common/widgets/images/t_rounded_image.dart';
import 'package:thriftify_fyp_1/common/widgets/texts/product_price_text.dart';
import 'package:thriftify_fyp_1/common/widgets/texts/product_title_text.dart';
import 'package:thriftify_fyp_1/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:thriftify_fyp_1/features/shop/models/product_model.dart';
import 'package:thriftify_fyp_1/features/shop/screens/product_details/product_detail.dart';
import 'package:thriftify_fyp_1/utils/constants/colors.dart';
import 'package:thriftify_fyp_1/utils/constants/image_strings.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';
import 'package:thriftify_fyp_1/utils/helpers/helper_functions.dart';

class TProductCardHorizontal extends StatelessWidget {
  final ProductModel product;
  const TProductCardHorizontal({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final imageUrl =
        (product.imageUrls != null && product.imageUrls!.isNotEmpty)
            ? product.imageUrls.first
            : TImages.productImage1; // fallback image

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            color: dark ? TColors.darkerGrey : TColors.softGrey,
          ),
          child: Row(
            children: [
              TRoundedContainer(
                height: 120,
                padding: const EdgeInsets.all(TSizes.sm),
                backgroundColor: dark ? TColors.dark : TColors.light,
                child: Stack(
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: TRoundedImage(
                        imageUrl: imageUrl,
                        isNetworkImage: true,
                        applyImageRadius: true,
                      ),
                    ),
                    // const Positioned(
                    //   top: 0,
                    //   right: 0,
                    //   child: TCircularIcon(
                    //     icon: Iconsax.heart5,
                    //     color: Colors.red,
                    //   ),
                    // )
                  ],
                ),
              ),
              SizedBox(
                width: 172,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TProductTitleText(
                        title: product.name ?? 'No Name',
                        smallSize: true,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      TBrandTitleWithVerifiedIcon(
                        title: product.brand ?? 'No Brand',
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TProductPriceText(
                            price: product.price ?? '0',
                          ),
                          // Container(
                          //   decoration: const BoxDecoration(
                          //     color: TColors.dark,
                          //     borderRadius: BorderRadius.only(
                          //       topLeft: Radius.circular(TSizes.cardRadiusMd),
                          //       bottomRight:
                          //           Radius.circular(TSizes.productImageRadius),
                          //     ),
                          //   ),
                          //   child: const SizedBox(
                          //     width: TSizes.iconLg * 1.2,
                          //     height: TSizes.iconLg * 1.2,
                          //     child: Center(
                          //       child: Icon(
                          //         Iconsax.add,
                          //         color: TColors.white,
                          //       ),
                          //     ),
                          //   ),
                          // )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thriftify_fyp_1/common/styles/shadows.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:thriftify_fyp_1/common/widgets/icons/t_circular_icon.dart';
import 'package:thriftify_fyp_1/common/widgets/images/t_rounded_image.dart';
import 'package:thriftify_fyp_1/common/widgets/texts/product_title_text.dart';
import 'package:thriftify_fyp_1/utils/constants/colors.dart';
import 'package:thriftify_fyp_1/utils/constants/image_strings.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';
import 'package:thriftify_fyp_1/utils/helpers/helper_functions.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key});


  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: 180,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(boxShadow: [TShadowStyle.verticalProductShadow],
      borderRadius: BorderRadius.circular(TSizes.productImageRadius),
      color: dark ? TColors.darkerGrey :TColors.white,),
      child: Column(
        children: [
          TRoundedContainer( 
            height: 180,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: Stack(
              children: [
                const TRoundedImage(imageUrl: TImages.productImage1, applyImageRadius: true ,),

                Positioned(
                  top: 12,
                  child: TRoundedContainer(
                    radius: TSizes.sm,
                    backgroundColor: TColors.secondary.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                    child: Text('25%', style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black),),
                  ),
                ),

                 const Positioned(
                top: 0,
                 right: 0,
                 child: TCircularIcon(icon: Iconsax.heart5, color: Colors.red,),)



              ],
            ),
            
          ),
           const SizedBox(height: TSizes.spaceBtwItems/2,),
        
         const Padding(padding: const EdgeInsets.only(left: TSizes.sm),
        child: Column(
          children: [
          TProductTitleText(title:'Black Nike Shoes', smallSize: true,)
          ],
        ),)
        
        ],
      ),
      
    );
  }
}


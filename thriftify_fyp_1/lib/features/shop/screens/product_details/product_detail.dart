import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:thriftify_fyp_1/common/widgets/appbar/appbar.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/curved_edges/curved_edges_widgets.dart';
import 'package:thriftify_fyp_1/common/widgets/icons/t_circular_icon.dart';
import 'package:thriftify_fyp_1/common/widgets/images/t_rounded_image.dart';
import 'package:thriftify_fyp_1/common/widgets/texts/section_heading.dart';
import 'package:thriftify_fyp_1/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:thriftify_fyp_1/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:thriftify_fyp_1/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:thriftify_fyp_1/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:thriftify_fyp_1/utils/constants/colors.dart';
import 'package:thriftify_fyp_1/utils/constants/image_strings.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';
import 'package:thriftify_fyp_1/utils/helpers/helper_functions.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return  Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            const TProductImageSlider(),

            Padding(
              padding: 
            const EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
            child: Column(
              children: [
                TRatingAndShare(),

                TProductMetaData(), 

                const TProductAttributes(),
                const SizedBox(height: TSizes.spaceBtwSections,),

                const TSectionHeading(title: 'Description', showActionButton: false,),
                const SizedBox(height: TSizes.spaceBtwItems,),
                const ReadMoreText('This is a Product Description for Nike Shoes. There are more things that can be added but i am busy.',
                trimLines: 2,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show More',
                trimExpandedText: 'Less',
                moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),),


                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TSectionHeading(title: 'Reviews (199)', showActionButton: false,),
                    IconButton(icon: const Icon(Iconsax.arrow_right_3, size: 18,), onPressed: (){},)
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections,),




              ]
            ),
            )
          ],
        ),
      ),
    );
  }
}



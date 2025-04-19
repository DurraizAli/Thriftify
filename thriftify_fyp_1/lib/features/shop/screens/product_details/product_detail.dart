import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thriftify_fyp_1/common/widgets/appbar/appbar.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/curved_edges/curved_edges_widgets.dart';
import 'package:thriftify_fyp_1/common/widgets/icons/t_circular_icon.dart';
import 'package:thriftify_fyp_1/common/widgets/images/t_rounded_image.dart';
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


              ]
            ),
            )
          ],
        ),
      ),
    );
  }
}



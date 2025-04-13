import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thriftify_fyp_1/common/widgets/appbar/appbar.dart';
import 'package:thriftify_fyp_1/common/widgets/chatbot/AI_bot.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/curved_edges/curved_edges_widgets.dart';
import 'package:thriftify_fyp_1/common/widgets/images/t_rounded_image.dart';
import 'package:thriftify_fyp_1/common/widgets/texts/section_haeding.dart';
import 'package:thriftify_fyp_1/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:thriftify_fyp_1/features/shop/screens/home/widgets/home_categories.dart';
import 'package:thriftify_fyp_1/features/shop/screens/home/widgets/image_text_widgets/vertiacl_image_text.dart';
import 'package:thriftify_fyp_1/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:thriftify_fyp_1/utils/constants/colors.dart';
import 'package:thriftify_fyp_1/utils/constants/image_strings.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';
import 'package:thriftify_fyp_1/utils/constants/text_strings.dart';
import 'package:thriftify_fyp_1/utils/device/device_utility.dart';
import 'package:thriftify_fyp_1/utils/helpers/helper_functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  THomeAppBar(),
                   SizedBox(height: TSizes.spaceBtwSections),


                   TSearchContainer(text: 'Search in Store',),
                  SizedBox(height: TSizes.spaceBtwSections),

                  Padding(padding: EdgeInsets.only(left: TSizes.defaultSpace), child: Column(children: [
                    TsectionHeading(title: 'Popular Categories', showActionButton: false, textColor: Colors.white,),
                     SizedBox(height: TSizes.spaceBtwItems),

                    THomeCategories()





      

                  ],),)
                ],
              ),
            ),
             Padding(
               padding:   EdgeInsets.all(TSizes.defaultSpace),
               child: TPromoSlider(banners: [TImages.promoBanner1,TImages.promoBanner2,TImages.promoBanner3,],),
               
             )








          ],
        ),
      ),
    );
  }
}















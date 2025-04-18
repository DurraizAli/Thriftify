import 'package:flutter/material.dart';
import 'package:thriftify_fyp_1/common/widgets/appbar/appbar.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:thriftify_fyp_1/common/widgets/images/t_circular_image.dart';
import 'package:thriftify_fyp_1/common/widgets/layouts/grid_layout.dart';
import 'package:thriftify_fyp_1/common/widgets/texts/section_heading.dart';
import 'package:thriftify_fyp_1/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:thriftify_fyp_1/utils/constants/colors.dart';
import 'package:thriftify_fyp_1/utils/constants/enums.dart';
import 'package:thriftify_fyp_1/utils/constants/image_strings.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';
import 'package:thriftify_fyp_1/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Store'),

       
      ),
      body: NestedScrollView(headerSliverBuilder: (_, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            floating: true,
            backgroundColor: THelperFunctions.isDarkMode(context)? TColors.black : TColors.white,
            expandedHeight: 440,
            flexibleSpace: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(height: TSizes.spaceBtwItems,),
                const TSearchContainer(text: 'Search in Store', showBorder:  true, showBackground: false, padding: EdgeInsets.zero,),
                const SizedBox(height: TSizes.spaceBtwSections,),

                TSectionHeading(title: 'Featured Brands', onPressed: (){}),
                const SizedBox(height: TSizes.spaceBtwItems/1.5,),

                TGridLayout(itemCount: 4, mainAxisExtent: 80, itemBuilder: (_, index){
                  return GestureDetector(
                  onTap: (){},
                  child: TRoundedContainer(
                    padding: const EdgeInsets.all(TSizes.sm),
                    showBorder: true,
                    backgroundColor: Colors.transparent,
                    child: Row(
                      children: [
                        Flexible(
                          child: TCircularImage(
                            isNetworkImage: false,
                            image: TImages.google,
                            backgroundColor: Colors.transparent,
                            overlayColor: THelperFunctions.isDarkMode(context) ? TColors.white: TColors.black,
                            
                          ),
                        ),
                        const SizedBox(width: TSizes.spaceBtwItems/2,),
                  
                  
                         Expanded(
                           child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               const TBrandTitleWithVerifiedIcon(title: 'Nike',brandTextSize: TextSizes.large,),
                              Text('256 products',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.labelMedium,)
                            ],
                                                   ),
                         )
                      ],
                    ),
                  ),
                );
                })



              ],
            ),
            ),

          ),
        ];
      }, body: Container(),),
    );
  }
}


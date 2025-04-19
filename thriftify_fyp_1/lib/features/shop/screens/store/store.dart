import 'package:flutter/material.dart';
import 'package:thriftify_fyp_1/common/widgets/appbar/appbar.dart';
import 'package:thriftify_fyp_1/common/widgets/appbar/tabbar.dart';
import 'package:thriftify_fyp_1/common/widgets/brands/brand_card.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:thriftify_fyp_1/common/widgets/layouts/grid_layout.dart';
import 'package:thriftify_fyp_1/common/widgets/texts/section_heading.dart';
import 'package:thriftify_fyp_1/features/shop/screens/store/widgets/category_tab.dart';
import 'package:thriftify_fyp_1/utils/constants/colors.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';
import 'package:thriftify_fyp_1/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: const TAppBar(
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
                    return const TBrandCard(showBorder: false);
                  },)
      
      
      
                ],
              ),
              ),
      
              bottom: const TTabBar(
                tabs: [
                  Tab(child: Text('Sports'),),
                  Tab(child: Text('Clothes'),),
                  Tab(child: Text('Accesories'),),
                  Tab(child: Text('Shoes'),),
                ],
              )
      
            ),
          ];
        }, body: const TabBarView(children:[ 
        TCategoryTab(),
        TCategoryTab(),
        TCategoryTab(),
        TCategoryTab(),
        TCategoryTab(),
    
        ],
        ),),
      ),
    );
  }
}


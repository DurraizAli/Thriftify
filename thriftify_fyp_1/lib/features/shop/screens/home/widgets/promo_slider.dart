import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:thriftify_fyp_1/common/widgets/images/t_rounded_image.dart';
import 'package:thriftify_fyp_1/features/shop/controllers/home_controller.dart';
import 'package:thriftify_fyp_1/utils/constants/colors.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key, required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
         options: CarouselOptions(viewportFraction: 1,
         onPageChanged: (index, _)=> controller.UpdatePageIndicator(index)),
         items: banners.map((url) => TRoundedImage(imageUrl: url, isNetworkImage: true)).toList()
        ),
        const SizedBox(height: TSizes.spaceBtwItems,),
        Center(
          child: Obx(
            ()=> Row(
              mainAxisSize: MainAxisSize.min,
              children: [
               for(int i =0; i<banners.length ; i++)
                TCircularContainer(
                 width: 20,
                 margin: const EdgeInsets.only(right: 10),
                 height: 4,
                 backgroundColor:  controller.carousalCurrentIndex.value == i ? const Color.fromARGB(255, 30, 143, 92) : TColors.grey,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
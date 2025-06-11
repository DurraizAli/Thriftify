import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:thriftify_fyp_1/common/widgets/images/t_rounded_image.dart';
import 'package:thriftify_fyp_1/common/widgets/shimmers/shimmer.dart';
import 'package:thriftify_fyp_1/features/shop/controllers/banner_controller.dart';
import 'package:thriftify_fyp_1/features/shop/controllers/home_controller.dart';
import 'package:thriftify_fyp_1/utils/constants/colors.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Obx(() {
      if (controller.isLoading.value)
        return const TShimmerEffect(width: double.infinity, height: 200);
      if (controller.banners.isEmpty) {
        return const Center(
          child: Text("No Data Found"),
        );
      } else {
        return Column(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: CarouselSlider(
                  options: CarouselOptions(
                      viewportFraction: 1.0,
                      onPageChanged: (index, _) =>
                          controller.UpdatePageIndicator(index)),
                  items: controller.banners
                      .map((banner) => TRoundedImage(
                            imageUrl: banner.imageUrl,
                            isNetworkImage: true,
                            height: 200,
                            width: double.infinity,
                            onPressed: () => Get.toNamed(banner.targetScreen),
                          ))
                      .toList()),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Center(
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < controller.banners.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5), // Equal padding on left & right
                        child: TCircularContainer(
                          width: 8,
                          height: 8,
                          radius: 100,
                          backgroundColor:
                              controller.carousalCurrentIndex.value == i
                                  ? const Color.fromARGB(255, 40, 180, 124)
                                  : const Color.fromARGB(255, 128, 128, 129),
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        );
      }
    });
  }
}

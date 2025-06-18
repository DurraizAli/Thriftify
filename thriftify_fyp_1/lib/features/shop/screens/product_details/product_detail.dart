import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:thriftify_fyp_1/common/widgets/texts/section_heading.dart';
import 'package:thriftify_fyp_1/features/shop/controllers/product_image_slider_controller.dart';
import 'package:thriftify_fyp_1/features/shop/models/product_model.dart';
import 'package:thriftify_fyp_1/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final sliderController = Get.put(ProductImageSliderController());
    final images = product.imageUrls;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Stack(
              children: [
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 400,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, _) =>
                          sliderController.updateIndex(index),
                    ),
                    items: images.map((url) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) => Dialog(
                              backgroundColor: Colors.transparent,
                              insetPadding: EdgeInsets.zero,
                              child: Stack(
                                children: [
                                  SizedBox.expand(
                                    child: InteractiveViewer(
                                      child: Image.network(
                                        url,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 40,
                                    right: 20,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black54,
                                      child: IconButton(
                                        icon: const Icon(Icons.close,
                                            color: Colors.white),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Image.network(
                          url,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // Back button (top left)
                Positioned(
                  top: 40,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ),
                // Image index (bottom right)
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Obx(() => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${sliderController.currentIndex.value + 1} / ${images.length}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      )),
                ),
              ],
            ),

            //--------------------------------------------------------------------------------------------
            //circles will show here
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Center(
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < images.length; i++)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5), // Equal padding on left & right
                        child: TCircularContainer(
                          width: 8,
                          height: 8,
                          radius: 100,
                          backgroundColor:
                              sliderController.currentIndex.value == i
                                  ? const Color.fromARGB(255, 40, 180, 124)
                                  : const Color.fromARGB(255, 128, 128, 129),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            //---------------------------------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(children: [
                //---------------------------------------------------------------------------------------------
                //added this line to display the product name and price from firebase

                // Text(product.name,
                //      style: Theme.of(context).textTheme.headlineSmall),
                // Text('\$${product.price}',
                //     style: Theme.of(context).textTheme.headlineSmall),
                // const SizedBox(height: 8),
                // Text(product.description),

                //--------------------------------------------------------------------------------------------
                // const TRatingAndShare(),
               Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product meta data expands and wraps text
                    Expanded(
                      child: TProductMetaData(product),
                    ),
                    const SizedBox(width: 16),
                    // Try-On button hugs the right with padding
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                      child: SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 243, 200, 9),
                              side: BorderSide.none),
                          onPressed: () async {
                            final picked = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (picked != null) {
                              // Get the last image (background-removed) from product.imageUrls
                              final productImgUrl = product.imageUrls.last;
                              // Download both images as bytes

                              final userBytes = await picked.readAsBytes();
                              final productBytes =
                                  (await http.get(Uri.parse(productImgUrl)))
                                      .bodyBytes;
                              // Send to Flask server
                              final request = http.MultipartRequest(
                                  'POST',
                                  Uri.parse(
                                      'http://192.168.137.1:5000/try-on'));
                              request.files.add(http.MultipartFile.fromBytes(
                                  'user', userBytes,
                                  filename: 'user.jpg'));
                              request.files.add(http.MultipartFile.fromBytes(
                                  'product', productBytes,
                                  filename: 'product.png'));
                              final response = await request.send();
                              if (response.statusCode == 200) {
                                final resultBytes =
                                    await response.stream.toBytes();
                                showDialog(
                                  context: context,
                                  builder: (_) => Dialog(
                                    child: Image.memory(resultBytes),
                                  ),
                                );
                              } else {
                                Get.snackbar("Error", "Try-On failed");
                              }
                            }
                          },
                          child: const Text("Try-On"),
                        ),
                      ),
                    ),
                  ],
                ),
                // const TProductAttributes(),    commenting this because i do not need it for now.
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                const TSectionHeading(
                  title: 'Description',
                  showActionButton: false,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                  ReadMoreText(
                  //This is the read more text widget that will display the product description
                  product.description,
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show More',
                  trimExpandedText: 'Less',
                  moreStyle:
                     const  TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  lessStyle:
                     const  TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),
                // const Divider(),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Contact with Seller",
                      style: TextStyle(
                          fontSize: TSizes.fontSizemd,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Call Container
                          GestureDetector(
                            onTap: () => _launchCaller(
                                product.phone), // <-- Use seller's phone
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: const Color.fromARGB(255, 3, 68, 37),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Iconsax.call_calling,
                                      color: Color.fromARGB(255, 3, 68, 37)),
                                  SizedBox(width: 8),
                                  Text(
                                    "Call",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 3, 68, 37),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: TSizes.spaceBtwSections),
                          // Chat Container
                          GestureDetector(
                            onTap: () => _launchWhatsApp(
                                product.phone), // <-- Use seller's phone
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 18),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 14, 168, 93)
                                    .withValues(alpha: 0.1),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 14, 168, 93),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Iconsax.message,
                                      color: Color.fromARGB(255, 14, 168, 93)),
                                  SizedBox(width: 8),
                                  Text(
                                    "Chat",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 14, 168, 93),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  void _launchWhatsApp(String phone) async {
    String formattedPhone = phone.replaceAll(RegExp(r'\D'), '');
    if (formattedPhone.startsWith('0')) {
      formattedPhone =
          '92${formattedPhone.substring(1)}'; // Example for Pakistan
    }

    final waMeUrl = 'https://wa.me/$formattedPhone';

    try {
      final uri = Uri.parse(waMeUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar("Error", "Could not open WhatsApp. Is it installed?");
      }
    } catch (e) {
      Get.snackbar("Error", "Could not open WhatsApp: $e");
    }
  }

  void _launchCaller(String phone) async {
    final url = 'tel:$phone';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Get.snackbar("Error", "Could not open dialer.");
    }
  }
}

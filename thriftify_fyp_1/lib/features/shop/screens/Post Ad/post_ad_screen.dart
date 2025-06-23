import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:thriftify_fyp_1/common/widgets/texts/section_heading.dart';
import 'package:thriftify_fyp_1/features/shop/controllers/post_ad_controller.dart';
import 'package:thriftify_fyp_1/navigation_menu.dart';
import 'package:thriftify_fyp_1/routes/routes.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';

class PostAdScreen extends StatelessWidget {
  final controller = Get.put(PostAdController());
  final List<String> categories = [
    'Suit',
    'T-Shirts',
    'Dress shirt',
    'Coat',
    'Gym Wear',
    'Trousers',
    'Jeans',
    'Dress pants',
    'Shorts',
    'Dress shoes',
    'Sneakers',
    'Sandals',
    'Boots'
        'Runners',
    'Other'
  ]..sort();

  final List<String> brands = [
    'Nike',
    'Adidas',
    'Puma',
    'Reebok',
    'Under Armour',
    'New Balance',
    'Asics',
    'Converse',
    'Vans',
    'H&M',
    'Zara',
    'Uniqlo',
    'Levi\'s',
    'Wrangler',
    'Lee',
    'Dockers',
    'Calvin Klein',
    'Tommy Hilfiger',
    'Diesel',
    'Guess',
    'American Eagle',
    'Abercrombie & Fitch',
    'Hollister',
    'American Apparel',
    'Forever 21',
    'Bershka',
    'Pull&Bear',
    'Stradivarius',
    'Mango',
    'Massimo Dutti',
    'Sandro',
    'Maje',
    'Claudie Pierlot',
    'Ba&sh',
    'Hugo Boss',
    'Armani',
    'Ralph Lauren',
    'Tom Ford',
    'Brioni',
    'Canali',
    'Zegna',
    'Brooks Brothers',
    'Paul Smith',
    'Burberry',
    'Other'
  ]..sort();

  PostAdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor:
          const Color.fromARGB(255, 255, 255, 245), // Make scaffold transparent
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: TSizes.md),
                  //back icon used to go back to the previous screen
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Get.offAll(() => const NavigationMenu()),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: TSizes.defaultSpace, top: TSizes.defaultSpace),
                    child: Text(
                      "Post a New Ad",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: TSizes.defaultSpace,
                      top: TSizes.sm,
                      right: TSizes.defaultSpace,
                    ),
                    child: Text(
                      "Fill the details below to list your product for sale. Add good quality images to increase visibility.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(179, 123, 123, 123),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: Column(
                      children: [
                        _buildTextField("Product Name", controller.name),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        _buildTextField("Price", controller.price,
                            isNumber: true),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        _buildTextField("Description", controller.description,
                            maxLines: null,
                            textInputAction: TextInputAction.newline),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        //the dropdown for category

                        Obx(() => DropdownButtonFormField<String>(
                              value: controller.category.value.isEmpty
                                  ? null
                                  : controller.category.value,
                              decoration: InputDecoration(
                                labelText: 'Category',
                                labelStyle:
                                    const TextStyle(color: Color(0xFF888888)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              items: categories.map((category) {
                                return DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.category.value = value;
                                }
                              },
                            )),
                        //drop down for brands
                        const SizedBox(height: TSizes.spaceBtwItems),
                        Obx(() => DropdownButtonFormField<String>(
                              value: controller.brand.value.isEmpty
                                  ? null
                                  : controller.brand.value,
                              decoration: InputDecoration(
                                labelText: 'Brand',
                                labelStyle:
                                    const TextStyle(color: Color(0xFF888888)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              items: brands.map((brand) {
                                return DropdownMenuItem(
                                  value: brand,
                                  child: Text(brand),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.brand.value = value;
                                }
                              },
                            )),

                        const SizedBox(height: TSizes.spaceBtwItems),
                        _buildTextField("Phone Number", controller.phone,
                            isPhone: true),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        // Pick Image Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: controller.pickAndCropImage,
                            icon: const Icon(Icons.crop),
                            label: const Text("Pick & Crop Product Image"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 243, 200, 9),
                              side: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: TSizes.defaultSpace),
                        const Text(
                          "(i.e) For the last picture, kindly put on your cloth and take a picture and crop the picture to it's boundries.",
                          style: TextStyle(
                              color: Color.fromARGB(255, 247, 92, 92),
                              fontSize: 10),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        // Show selected images
                        Obx(() {
                          final List<File> files = [
                            ...controller.croppedImages
                                .map((xfile) => File(xfile.path)),
                            ...controller.images
                                .map((xfile) => File(xfile.path)),
                          ];

                          return files.isNotEmpty
                              ? SizedBox(
                                  height: 100,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: files.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          image: DecorationImage(
                                            image: FileImage(files[index]),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(width: 10),
                                  ),
                                )
                              : const Text(
                                  "No images selected",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 5, 5, 5)),
                                );
                        }),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // Post Ad Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 46, 176, 118),
                                side: BorderSide.none),
                            onPressed: controller.uploadAd,
                            child: const Text("Post Ad"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
    );
  }

  Widget _buildTextField(String label, RxString target,
      {bool isNumber = false,
      bool isPhone = false,
      int? maxLines,
      TextInputAction? textInputAction}) {
    return TextField(
      onChanged: (val) => target.value = val,
      keyboardType: isNumber
          ? TextInputType.number
          : isPhone
              ? TextInputType.phone
              : (maxLines == null || maxLines != 1)
                  ? TextInputType.multiline
                  : TextInputType.text,
      maxLines: maxLines,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF888888)),
        hintText: label,
        hintStyle: const TextStyle(color: Color(0xFFB0B0B0)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

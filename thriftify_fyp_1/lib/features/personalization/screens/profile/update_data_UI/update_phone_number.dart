import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thriftify_fyp_1/common/widgets/appbar/appbar.dart';
import 'package:thriftify_fyp_1/features/personalization/controllers/update_phone_number_controller.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';
import 'package:thriftify_fyp_1/utils/constants/text_strings.dart';
import 'package:thriftify_fyp_1/utils/validators/validation.dart';

class ChangePhoneNumber extends StatelessWidget {
  const ChangePhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhone());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Change Phone Number",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Use real phone for easy verification",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Form(
              key: controller.updatephone,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.phone,
                    validator: (value) =>
                        TValidator.validateEmptyText("phone", value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.phoneNumber, prefixIcon: Icon(Icons.call)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updateUserPhone(),
                  child: const Text("Save")),
            ),
          ],
        ),
      ),
    );
  }
}

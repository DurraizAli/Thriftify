import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:thriftify_fyp_1/common/widgets/appbar/appbar.dart';
import 'package:thriftify_fyp_1/features/personalization/controllers/update_email_controller.dart';
import 'package:thriftify_fyp_1/features/personalization/controllers/update_name_controler.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';
import 'package:thriftify_fyp_1/utils/constants/text_strings.dart';
import 'package:thriftify_fyp_1/utils/validators/validation.dart';

class ChangeEmail extends StatelessWidget {
  const ChangeEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateEmail());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Change Email",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Use real email for easy verification",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            Form(
              key: controller.updateemail,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.email,
                    validator: (value) =>
                        TValidator.validateEmptyText("Email", value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.email, prefixIcon: Icon(Icons.mail)),
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
                  onPressed: () => controller.updateUserEmail(),
                  child: const Text("Save")),
            ),
          ],
        ),
      ),
    );
  }
}

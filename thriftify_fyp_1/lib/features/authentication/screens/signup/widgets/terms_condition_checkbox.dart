import 'package:flutter/material.dart';
import 'package:thriftify_fyp_1/utils/constants/colors.dart';
import 'package:thriftify_fyp_1/utils/constants/sizes.dart';
import 'package:thriftify_fyp_1/utils/constants/text_strings.dart';
import 'package:thriftify_fyp_1/utils/helpers/helper_functions.dart';

class TTermsAndConditionCheckbox extends StatelessWidget {
  const TTermsAndConditionCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Wrap in a Sized box to remove extra padding
        SizedBox(width: 24, height: 24, child: Checkbox(value: true, onChanged: (value){})),
        const SizedBox(width: TSizes.md),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '${TTexts.iAgreeTo} ', style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: TTexts.privacyPolicy,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: THelperFunctions.isDarkMode(context) ? TColors.white : TColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: THelperFunctions.isDarkMode(context) ? TColors.white : TColors.primary,
                ),
              ),
              TextSpan(text: ' ${TTexts.and} ', style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: TTexts.termsOfUsage,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: THelperFunctions.isDarkMode(context) ? TColors.white : TColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: THelperFunctions.isDarkMode(context) ? TColors.white : TColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
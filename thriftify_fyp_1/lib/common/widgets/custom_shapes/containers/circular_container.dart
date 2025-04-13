
import 'package:flutter/material.dart';
import 'package:thriftify_fyp_1/utils/constants/colors.dart';

class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
    this.width = 165,
    this.height = 165,
    this.radius = 165,
    this.child,
    this.backgroundColor = TColors.white, this.padding=0, this.margin,
  });

  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      height: 165,
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(165),
        color: TColors.textWhite.withOpacity(0.1),
      ),
      child: child,
    );
  }
}
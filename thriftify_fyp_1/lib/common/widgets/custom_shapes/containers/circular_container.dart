
import 'package:flutter/material.dart';
import 'package:thriftify_fyp_1/utils/constants/colors.dart';

class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
    this.width = 8,
    this.height = 8,
    this.radius = 100,
    this.child,
    this.backgroundColor = const Color.fromARGB(255, 37, 121, 102), this.padding=0, this.margin,
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
      width: width,
      height: height,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor
      ),
      child: child,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:thriftify_fyp_1/common/widgets/custom_shapes/curved_edges/curved_edges_widgets.dart';
import 'package:thriftify_fyp_1/utils/constants/colors.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key, required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return TCurvedEdgeWidget(
      child: Container(
        color: const Color.fromARGB(255, 38, 137, 98),
        
        //stack is used to display widgets on top of each other
        child: Stack(
          children: [
            Positioned(
                top: 0,
                right: -50,
                child: TCircularContainer(
                  backgroundColor: TColors.textWhite.withOpacity(0.1),
                  width: 200,
                  height: 200,
                )),
            Positioned(
                top: 100,
                right: -120,
                child: TCircularContainer(
                  backgroundColor: TColors.textWhite.withOpacity(0.1),
                  width: 200,
                  height: 200,
                )),
                child,
          ],
        ),
      ),
    );
  }
}
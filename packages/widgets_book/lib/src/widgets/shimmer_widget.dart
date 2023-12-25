import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart' as shimmer;

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    required this.type, super.key,
    this.width = double.infinity,
    this.height = 60,
    this.borderRadius = 5,
    this.child,
  });
  final ShimmerType type;
  final double width;
  final double height;
  final Widget? child;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return shimmer.Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade300,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: type == ShimmerType.circle
              ? BorderRadius.circular(width)
              : BorderRadius.circular(borderRadius),
        ),
        child: child,
      ),
    );
  }
}

enum ShimmerType { circle, square }

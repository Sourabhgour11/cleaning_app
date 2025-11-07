import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Universal shimmer widget for loading states.
/// You can use it for lists, grids, banners, or full pages.
class CustomShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  const CustomShimmer({
    Key? key,
    this.width,
    this.height,
    this.borderRadius = 8.0,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBoxWidget extends StatelessWidget {
  const ShimmerBoxWidget({
    Key? key,
    this.width = 100,
    this.height = 36,
    this.child,
    this.borderRadius,
  }) : super(key: key);
  final double? width;
  final double? height;
  final Widget? child;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xffdcdada),
      highlightColor: const Color(0x00dcdada),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
        ),
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}

class ContainerBoxWidget extends StatelessWidget {
  const ContainerBoxWidget({
    Key? key,
    this.width = 100,
    this.height = 36,
    this.child,
    this.borderRadius,
    this.color,
  }) : super(key: key);
  final double? width;
  final double? height;
  final Widget? child;
  final BorderRadius? borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: borderRadius,
      ),
      width: width,
      height: height,
      child: child,
    );
  }
}

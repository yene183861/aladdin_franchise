/// Author: sondv
/// Created 23/02/2023 at 10:05

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Gap extends StatelessWidget {
  final double? dimension;
  final Widget? child;
  const Gap(
    this.dimension, {
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: (dimension ?? 0).sp,
      child: child,
    );
  }
}

class GapH extends StatelessWidget {
  final double? height;
  final Widget? child;
  const GapH(
    this.height, {
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: child,
    );
  }
}

class GapW extends StatelessWidget {
  final double? width;
  final Widget? child;
  const GapW(
    this.width, {
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: child,
    );
  }
}

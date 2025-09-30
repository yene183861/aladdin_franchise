// import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/src/features/widgets/shimmer_box.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppImageCacheNetworkWidget extends StatelessWidget {
  final String imageUrl;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorWidget;
  final int? memCacheWidth;
  final int? memCacheHeight;
  const AppImageCacheNetworkWidget({
    Key? key,
    required this.imageUrl,
    this.borderRadius,
    this.width,
    this.height,
    this.fit,
    this.errorWidget,
    this.memCacheHeight,
    this.memCacheWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        memCacheWidth: memCacheWidth,
        memCacheHeight: memCacheHeight,
        width: width,
        height: height,
        imageUrl: imageUrl,
        fit: fit ?? BoxFit.cover,
        placeholder: (context, _) {
          return const _ImageLoadingWidget();
        },
        errorWidget: (context, _, __) {
          return errorWidget ?? const _ImageErrorWidget();
        },
      ),
    );
  }
}

class _ImageErrorWidget extends StatelessWidget {
  const _ImageErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        Assets.imagesImageDefault,
        color: Colors.blueGrey,
        width: 66,
      ),
    );
  }
}

class _ImageLoadingWidget extends StatelessWidget {
  const _ImageLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ShimmerBoxWidget(
      width: double.maxFinite,
    );
  }
}

class AppImageNetworkWithoutCacheWidget extends StatelessWidget {
  final String imageUrl;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Widget Function(Widget)? imageBuilder;
  const AppImageNetworkWithoutCacheWidget({
    Key? key,
    required this.imageUrl,
    this.borderRadius,
    this.width,
    this.height,
    this.fit,
    this.errorWidget,
    this.loadingWidget,
    this.imageBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        frameBuilder: (context, child, _, __) {
          if (imageBuilder == null) return child;
          return imageBuilder!(child);
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return loadingWidget ?? const _ImageLoadingWidget();
        },
        errorBuilder: (context, _, __) {
          return errorWidget ?? const _ImageErrorWidget();
        },
      ),
    );
  }
}

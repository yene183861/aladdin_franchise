import 'package:aladdin_franchise/src/features/widgets/button/button_cir_icon_menu.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:flutter/material.dart';

void showImageWidget({
  required BuildContext context,
  String? imageUrl,
  ImageProvider<Object>? imageProvider,
  Widget? imageWidget,
  EdgeInsetsGeometry? padding,
  double? widthFactor,
}) {
  showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: true,
    builder: (context) => _ViewImageWidget(
      imageUrl: imageUrl,
      imageProvider: imageProvider,
      imageWidget: imageWidget,
      padding: padding,
      widthFactor: widthFactor,
    ),
  );
}

class _ViewImageWidget extends StatelessWidget {
  final String? imageUrl;
  final ImageProvider<Object>? imageProvider;
  final Widget? imageWidget;
  final EdgeInsetsGeometry? padding;

  final double? widthFactor;
  const _ViewImageWidget({
    Key? key,
    this.imageUrl,
    this.imageProvider,
    this.imageWidget,
    this.padding,
    this.widthFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double valueRadius = 0;
    return FractionallySizedBox(
      widthFactor: widthFactor ?? 0.5,
      heightFactor: 0.95,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(valueRadius),
        ),
        content: Stack(
          alignment: Alignment.topRight,
          children: [
            Padding(
              padding: padding ?? EdgeInsets.zero,
              child: imageWidget ??
                  (imageProvider == null
                      ? AppImageCacheNetworkWidget(
                          imageUrl: imageUrl.toString(),
                          fit: BoxFit.fitHeight,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(valueRadius),
                            topRight: Radius.circular(valueRadius),
                          ),
                        )
                      : Image(image: imageProvider!)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonCirMenuWidget(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icons.close,
                color: Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }
}

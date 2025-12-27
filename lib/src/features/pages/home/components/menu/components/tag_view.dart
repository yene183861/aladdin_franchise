import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/models/tag_product.dart';
import 'package:flutter/material.dart';

class TagViewWidget extends StatelessWidget {
  final TagProductModel tag;
  const TagViewWidget({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgTagInProduct,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 2,
            spreadRadius: 0.3,
            offset: Offset(-2, 2),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Text(
        tag.name,
        style: AppTextStyle.regular(
          rawFontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.tcTagInProduct,
        ),
      ),
    );
  }
}

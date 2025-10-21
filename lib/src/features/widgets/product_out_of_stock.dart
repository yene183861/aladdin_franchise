import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

/// Author: sondv
/// Created 05/02/2024 at 10:14

/// Hết món - Hết hàng
class ProductOutOfStockWidget extends StatelessWidget {
  const ProductOutOfStockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 0, 6, 8),
      child: Chip(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.mainColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        label: Text(
          S.current.out_of_stock,
          style: AppTextStyle.regular(
            rawFontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.mainColor,
          ),
        ),
      ),
    );
  }
}

class ProductOutOfStockCircleWidget extends StatelessWidget {
  const ProductOutOfStockCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CircleAvatar(
        backgroundColor: Colors.white54,
        radius: 50,
        child: CircleAvatar(
          radius: 46,
          backgroundColor: Colors.black54,
          child: Text(
            S.current.out_of_dish,
            style: AppTextStyle.regular(
              rawFontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

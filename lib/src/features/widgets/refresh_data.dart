import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

class RefreshDataWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onRefresh;
  final IndicatorTrigger indicatorTrigger;
  const RefreshDataWidget({
    Key? key,
    required this.child,
    required this.onRefresh,
    this.indicatorTrigger = IndicatorTrigger.bothEdges,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      trigger: indicatorTrigger,
      leadingScrollIndicatorVisible: true,
      onRefresh: () async {
        onRefresh.call();
      },
      builder: MaterialIndicatorDelegate(
        builder: (context, controller) {
          return Icon(Icons.refresh, color: AppColors.mainColor);
        },
      ),
      child: child,
    );
  }
}

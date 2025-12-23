import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/list_product.dart';
import 'package:flutter/material.dart';

class OrderHistoryListViewLoading extends StatelessWidget {
  const OrderHistoryListViewLoading({
    super.key,
    required this.colSettings,
  });
  final List<Map<String, Object?>> colSettings;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: (context, index) {
        if (index == 0) {
          return SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: colSettings.length,
              itemBuilder: (context, index) => SizedBox(
                width: 180,
                child: Center(
                  child: Text(
                    colSettings[index]['title'].toString(),
                    style: AppTextStyle.bold(),
                  ),
                ),
              ),
            ),
          );
        }
        return AppShimmerLoading(
          child: Container(
            height: 50,
            color: index % 2 == 0 ? null : Colors.grey.shade100,
          ),
        );
      },
    );
  }
}

import 'package:aladdin_franchise/src/features/pages/home/components/menu/components/list_product.dart';
import 'package:flutter/material.dart';

class OrderHistoryGridViewLoading extends StatelessWidget {
  const OrderHistoryGridViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (BuildContext context, int index) {
        return const AppShimmerLoading(borderRadius: 8);
      },
      itemCount: 6,
    );
  }
}

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/components/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online_new/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/image.dart';
import 'package:aladdin_franchise/src/data/model/o2o/request_order.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';

class RequestItemLine extends ConsumerWidget {
  const RequestItemLine({
    super.key,
    required this.request,
    required this.item,
    this.selected = false,
  });
  final RequestOrderModel request;
  final RequestOrderItemModel item;
  final bool selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: AppConfig.borderRadiusSecond,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Builder(
                    builder: (context) {
                      bool mobileDevice = AppDeviceSizeUtil.checkMobileDevice();
                      return AppImageCacheNetworkWidget(
                        imageUrl: item.image,
                        width: mobileDevice ? 50 : 80,
                        height: mobileDevice ? 50 : 80,
                        borderRadius:
                            BorderRadius.circular(mobileDevice ? 8 : 20),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  const Gap(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: AppTextStyle.bold(),
                        ),
                        const Gap(6),
                        Text.rich(
                          TextSpan(
                            text: '${S.current.quantityCut}: ',
                            children: [
                              TextSpan(
                                text: item.quantity.toString(),
                                style: AppTextStyle.bold(),
                              ),
                            ],
                          ),
                          style: AppTextStyle.regular(),
                        ),
                        if (item.note.trim().isNotEmpty) ...[
                          const GapH(6),
                          Wrap(
                            children: [
                              Text(
                                '${S.current.note}: ',
                                style: AppTextStyle.regular(),
                              ),
                              const GapW(4),
                              Text(
                                item.note,
                                style: AppTextStyle.regular(),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              if (item.noteRestaurant.trim().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                      '${S.current.note_the_dish}: ${item.noteRestaurant.trim()}'),
                ),
              if (kDebugMode) Text(item.codeProduct),
            ],
          ),
        ],
      ),
    );
  }
}

class ReasonCancelItemWidget extends StatelessWidget {
  const ReasonCancelItemWidget({
    super.key,
    this.reason,
    this.isCancel = false,
  });
  final String? reason;
  final bool isCancel;

  @override
  Widget build(BuildContext context) {
    if (reason == null || reason!.trim().isEmpty)
      return const SizedBox.shrink();
    return Row(
      children: [
        ResponsiveIconWidget(
          iconData: Icons.note_alt_outlined,
          color: Colors.grey.shade400,
        ),
        const Gap(8),
        Text.rich(
          TextSpan(
            children: [
              // TextSpan(
              //     text: isCancel
              //         ? '${S.current.cancellation_reason}: '
              //         : '${S.current.confirmation_content}: '),
              TextSpan(
                text: reason!.trim(),
                style: AppTextStyle.bold().copyWith(
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ],
          ),
          style: AppTextStyle.regular().copyWith(
            color: Colors.grey.shade400,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

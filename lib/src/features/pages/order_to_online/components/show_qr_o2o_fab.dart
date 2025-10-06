import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/login/view.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';

class QrO2OFab extends ConsumerWidget {
  const QrO2OFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderSelect = ref
        .watch(orderToOnlinePageProvider.select((value) => value.orderSelect));
    return orderSelect == null || orderSelect.qrOrderO2o.isEmpty
        ? const SizedBox.shrink()
        : FloatingActionButton.extended(
            extendedPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            onPressed: () async {
              final res = await showDialog(
                context: context,
                useRootNavigator: false,
                barrierDismissible: false,
                builder: (context) => _QRO2ODialog(
                  qr: [orderSelect.qrOrderO2o.first],
                  tableName: orderSelect.tableName,
                  orderCode: orderSelect.orderCode,
                ),
              );

              if (res == true && context.mounted) {
                showPrinterDialog(context);
              }
            },
            label: Text(
              S.current.view_order_qr,
              style: AppTextStyle.regular(color: Colors.white, fontSize: 13),
            ),
            icon: const ResponsiveIconWidget(iconData: Icons.qr_code_2),
            foregroundColor: Colors.white,
            backgroundColor: AppColors.mainColor,
          );
  }
}

class _QRO2ODialog extends ConsumerWidget {
  const _QRO2ODialog({
    required this.qr,
    required this.tableName,
    required this.orderCode,
  });
  final List<String> qr;
  final String tableName;
  final String orderCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isMobile = AppDeviceSizeUtil.checkMobileDevice();
    bool isPortraitOrientation =
        AppDeviceSizeUtil.checkPortraitOrientation(context);
    bool isSmallDevice = isMobile && !isPortraitOrientation;
    var fontSize = isSmallDevice ? 13.0 : 14.0;
    return AlertDialog(
      title: Column(
        children: [
          Text(
            S.current.qr_order_to_online,
            style: AppTextStyle.regular(fontSize: fontSize),
            textAlign: TextAlign.center,
          ),
          const GapH(8),
          Text(
            '${S.current.order.toUpperCase()} $orderCode',
            style: AppTextStyle.bold(fontSize: fontSize),
            textAlign: TextAlign.center,
          ),
          Text(
            '${S.current.table.toUpperCase()} $tableName',
            style: AppTextStyle.bold(fontSize: fontSize),
            textAlign: TextAlign.center,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Wrap(
                runSpacing: 8,
                spacing: 8,
                children: List<Widget>.generate(
                  qr.length,
                  (index) => SizedBox(
                    width: isSmallDevice ? 100 : 256,
                    height: isSmallDevice ? 100 : 256,
                    child: QrImageView(
                      data: qr[index],
                      eyeStyle: const QrEyeStyle(
                        color: AppColors.mainColor,
                        eyeShape: QrEyeShape.square,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.current.use_camera_zalo_to_scan_the_code,
              style: AppTextStyle.regular(fontSize: fontSize),
            ),
            const Gap(12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ButtonCancelWidget(
                  textAction: S.current.close,
                  textSize: fontSize,
                  onPressed: () => Navigator.pop(context),
                ),
                const Gap(20),
                ButtonSimpleWidget(
                  textAction: S.current.print_QR,
                  textSize: fontSize,
                  color: AppColors.secondColor,
                  onPressed: () async {
                    var error = await ref
                        .read(orderToOnlinePageProvider.notifier)
                        .getPrinters();
                    if (error == null) {
                      Navigator.pop(context, true);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

Future<dynamic> showPrinterDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return const PrinterContentDialog();
    },
  );
}

class PrinterContentDialog extends ConsumerWidget {
  const PrinterContentDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final printers =
        ref.watch(orderToOnlinePageProvider.select((value) => value.printers));
    final printerSelect = ref.watch(
        orderToOnlinePageProvider.select((value) => value.printerSelect));
    return AlertDialog(
      title: Text(
        S.current.choose_printer_o2o,
        textAlign: TextAlign.center,
      ),
      content: printers.isEmpty
          ? Text(
              S.current.no_printers,
              style: AppTextStyle.regular(),
            )
          : SizedBox(
              width: double.minPositive,
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  bool selected = printerSelect == printers[index];
                  return InkWell(
                    onTap: () {
                      ref
                          .read(orderToOnlinePageProvider.notifier)
                          .changePrinterSelect(printers[index]);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          color: selected ? Colors.grey.shade200 : null,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  printers[index].name,
                                  style: AppTextStyle.regular()
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '${printers[index].ip}: ${printers[index].port}',
                                  style: AppTextStyle.regular()
                                      .copyWith(fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          if (selected)
                            const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: printers.length,
                separatorBuilder: (context, index) => const Gap(8),
              ),
            ),
      actions: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ButtonSimpleWidget(
                  color: Colors.grey.shade700,
                  textAction: S.current.close,
                  onPressed: () => Navigator.pop(context),
                ),
                if (printers.isNotEmpty) ...[
                  const GapW(20),
                  ButtonSimpleWidget(
                    textAction: S.current.print,
                    color: printerSelect == null ? Colors.grey.shade400 : null,
                    onPressed: () async {
                      if (printerSelect == null) return;
                      Navigator.pop(context);
                      ref
                          .read(orderToOnlinePageProvider.notifier)
                          .printQRCode();
                    },
                  ),
                ]
              ],
            ),
          ],
        ),
      ],
    );
  }
}

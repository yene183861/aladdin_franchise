import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/model/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/features/dialogs/printer/printer_selector_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/printer/printer_selector_for_order_action.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online_new/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

class BtnO2oQrCode extends ConsumerWidget {
  const BtnO2oQrCode({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        var orders = ref.read(orderToOnlineProvider).when(
            data: (data) => data,
            error: (error, stackTrace) => {},
            loading: () => {});
        var orderIdSelect = ref.read(orderToOnlinePageProvider).orderIdSelect;
        showLogs(orders[orderIdSelect], flags: 'orders[orderIdSelect]');
        var order = (orderIdSelect == null
            ? null
            : orders[orderIdSelect]?['order']) as O2OOrderModel?;
        if (order == null) return;
        await showDialog(
          context: context,
          useRootNavigator: false,
          barrierDismissible: false,
          builder: (context) => _QrO2oDialog(order: order),
        );

        // if (res == true && context.mounted) {
        //   showPrinterDialog(context);
        // }
      },
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black26,
            )
          ],
        ),
        child: const Icon(Icons.qr_code_2_rounded, color: Colors.white),
      ),
    );
  }
}

class _QrO2oDialog extends ConsumerWidget {
  const _QrO2oDialog({required this.order});

  final O2OOrderModel order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool smallDevice =
        ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE);
    var listQr = order.qrOrderO2o;
    return AlertDialog(
      title: Column(
        children: [
          Text(
            S.current.qr_order_to_online,
            style: AppTextStyle.regular(),
            textAlign: TextAlign.center,
          ),
          const GapH(8),
          Text(
            '${S.current.order.toUpperCase()}${order.orderCode}',
            style: AppTextStyle.bold(),
            textAlign: TextAlign.center,
          ),
          Text(
            '${S.current.table.toUpperCase()} ${order.tableName}',
            style: AppTextStyle.bold(),
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
                  listQr.length,
                  (index) => SizedBox(
                    width: smallDevice ? 100 : 256,
                    height: smallDevice ? 100 : 256,
                    child: QrImageView(
                      data: listQr[index],
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
              style: AppTextStyle.regular(),
            ),
            const Gap(12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppCloseButton(),
                const Gap(20),
                AppButton(
                  textAction: S.current.print_QR,
                  color: AppColors.secondColor,
                  onPressed: () async {
                    var status = await showPrinterSelectorDialog(
                      context,
                      textAction: 'In',
                      action: (printerSelect) async {
                        return null;
                      },
                    );
                    if (status == true) {
                      pop(context);
                    }
                    // await showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return const PrinterContentDialog();
                    //   },
                    // );
                    // var error = await ref
                    //     .read(orderToOnlinePageProvider.notifier)
                    //     .getPrinters();
                    // if (error == null) {
                    //   Navigator.pop(context, true);
                    // }
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


// Future<dynamic> showPrinterDialog(BuildContext context) {
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return const PrinterContentDialog();
//     },
//   );
// }

// class PrinterContentDialog extends ConsumerWidget {
//   const PrinterContentDialog({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final printers =
//         ref.watch(orderToOnlinePageProvider.select((value) => value.printers));
//     final printerSelect = ref.watch(
//         orderToOnlinePageProvider.select((value) => value.printerSelect));
//     return AlertDialog(
//       title: Text(
//         S.current.choose_printer_o2o,
//         textAlign: TextAlign.center,
//       ),
//       content: printers.isEmpty
//           ? Text(
//               S.current.no_printers,
//               style: AppTextStyle.regular(),
//             )
//           : SizedBox(
//               width: double.minPositive,
//               child: ListView.separated(
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   bool selected = printerSelect == printers[index];
//                   return InkWell(
//                     onTap: () {
//                       ref
//                           .read(orderToOnlinePageProvider.notifier)
//                           .changePrinterSelect(printers[index]);
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 8),
//                       decoration: BoxDecoration(
//                           color: selected ? Colors.grey.shade200 : null,
//                           borderRadius: BorderRadius.circular(12)),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   printers[index].name,
//                                   style: AppTextStyle.regular()
//                                       .copyWith(fontWeight: FontWeight.w500),
//                                 ),
//                                 Text(
//                                   '${printers[index].ip}: ${printers[index].port}',
//                                   style: AppTextStyle.regular()
//                                       .copyWith(fontWeight: FontWeight.w400),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           if (selected)
//                             const Icon(
//                               Icons.check_circle_outline,
//                               color: Colors.green,
//                             ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//                 itemCount: printers.length,
//                 separatorBuilder: (context, index) => const Gap(8),
//               ),
//             ),
//       actions: [
//         Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ButtonSimpleWidget(
//                   color: Colors.grey.shade700,
//                   textAction: S.current.close,
//                   onPressed: () => Navigator.pop(context),
//                 ),
//                 if (printers.isNotEmpty) ...[
//                   const GapW(20),
//                   ButtonSimpleWidget(
//                     textAction: S.current.print,
//                     color: printerSelect == null ? Colors.grey.shade400 : null,
//                     onPressed: () async {
//                       // if (printerSelect == null) return;
//                       // Navigator.pop(context);
//                       // ref
//                       //     .read(orderToOnlinePageProvider.notifier)
//                       //     .printQRCode();
//                     },
//                   ),
//                 ]
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

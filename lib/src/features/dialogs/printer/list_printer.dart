import 'dart:async';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';

import 'package:aladdin_franchise/src/features/pages/order_to_online/components/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/subwindows_moniter%20copy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<PrinterModel?> showPrinterDialog(
  BuildContext context,
  PrinterModel? current,
) {
  return showDialog<PrinterModel>(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListPrintersDialog(
            initPrinters: {if (current != null) current},
            dialog: true,
          ),
        )),
  );
}

class ListPrintersDialog extends ConsumerStatefulWidget {
  const ListPrintersDialog({
    super.key,
    this.initPrinters = const <PrinterModel>{},
    this.title = '',
    this.onChangePrinterConfig,
    this.dialog = false,
    this.width = 400.0,
  });
  final Set<PrinterModel> initPrinters;
  final String title;

  final Function(Set<PrinterModel>, bool)? onChangePrinterConfig;
  final bool dialog;
  final double width;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListPrintersDialogState();
}

class _ListPrintersDialogState extends ConsumerState<ListPrintersDialog> {
  PrinterModel? selected;

  Set<PrinterModel> printerSelect = {};
  bool useDefaultPrinter = true;
  late StreamSubscription printerSub;
  late ValueNotifier<Map<PrinterModel, bool>> printerStatusNotifier;
  void onChangeUseDefaultPrinter([bool? value]) {
    setState(() {
      useDefaultPrinter = value ?? !useDefaultPrinter;
      if (!widget.dialog) {
        widget.onChangePrinterConfig?.call(printerSelect, useDefaultPrinter);
      }
    });
  }

  void onChangePrinterSelect(PrinterModel item, bool selected) {
    if (selected) {
      printerSelect.add(item);
    } else {
      printerSelect.remove(item);
    }
    if (!widget.dialog) {
      widget.onChangePrinterConfig?.call(printerSelect, useDefaultPrinter);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    printerSelect.addAll(printerSelect);
    printerStatusNotifier =
        ValueNotifier<Map<PrinterModel, bool>>(PrinterMonitor.instance.printerCheck);
    printerSub = PrinterMonitor.instance.printerBoardcastController.stream.listen(
      (event) {
        printerStatusNotifier.value = event;
      },
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (!widget.dialog) {
          widget.onChangePrinterConfig?.call(printerSelect, useDefaultPrinter);
        }
      },
    );
  }

  @override
  void dispose() {
    printerSub.cancel();
    printerStatusNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title.trim().isNotEmpty)
              Row(
                children: [
                  Icon(
                    Icons.print,
                    color: Colors.grey.shade500,
                  ),
                  const Gap(4),
                  Expanded(
                    child: Text(
                      widget.title.trim(),
                      style: AppTextStyle.bold(),
                    ),
                  ),
                ],
              ),
            RadioListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              value: true,
              groupValue: useDefaultPrinter,
              onChanged: (value) {
                onChangeUseDefaultPrinter(true);
              },
              title: Text(
                'Sử dụng máy in mặc định theo món',
                style: AppTextStyle.regular(),
              ),
            ),
            RadioListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              value: false,
              groupValue: useDefaultPrinter,
              onChanged: (value) {
                onChangeUseDefaultPrinter(false);
              },
              title: Text(
                'Chọn máy in khác',
                style: AppTextStyle.regular(),
              ),
            ),
            Expanded(
              child: useDefaultPrinter
                  ? Container()
                  : Consumer(
                      builder: (context, ref, child) {
                        var printers = ref.watch(printersProvider);
                        return printers.when(
                          data: (data) {
                            if (data.isEmpty) {
                              return Center(
                                child: Text(
                                  'Danh sách máy in trống',
                                  style: AppTextStyle.regular(
                                    color: Colors.grey.shade400,
                                    rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                                  ),
                                ),
                              );
                            }

                            WidgetsBinding.instance.addPostFrameCallback(
                              (timeStamp) {
                                PrinterMonitor.instance.checkPrinters(data);
                              },
                            );
                            return Expanded(
                              child: ListView.separated(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                                itemCount: data.length,
                                separatorBuilder: (context, index) => const Gap(12),
                                itemBuilder: (context, index) {
                                  var printer = data[index];
                                  bool selected = printerSelect.contains(printer);
                                  return InkWell(
                                    onTap: () {
                                      onChangePrinterSelect(printer, !selected);
                                    },
                                    child: Container(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: selected
                                              ? Color.fromARGB(255, 57, 132, 194)
                                              : Colors.grey.shade200,
                                          width: 1.5,
                                        ),
                                        borderRadius: AppConfig.borderRadiusMain,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            offset: const Offset(0, 2),
                                            blurRadius: 8,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Icon(
                                          //   Icons.print,
                                          //   size: 28,
                                          //   color: Colors.grey.shade500,
                                          // ),
                                          // Gap(12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  printer.name,
                                                  style: AppTextStyle.bold(),
                                                ),
                                                Text(
                                                  '${printer.ip ?? ''} : ${printer.port ?? ''}',
                                                  style: AppTextStyle.regular(
                                                    rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                ),
                                                ValueListenableBuilder(
                                                  valueListenable: printerStatusNotifier,
                                                  builder: (context, value, child) {
                                                    var status = value[printer] ?? false;
                                                    showLog(status, flags: 'status');
                                                    return Row(
                                                      children: [
                                                        Container(
                                                          height: 8,
                                                          width: 8,
                                                          decoration: BoxDecoration(
                                                            color: status
                                                                ? Colors.green
                                                                : AppColors.redColor,
                                                            shape: BoxShape.circle,
                                                          ),
                                                        ),
                                                        const Gap(4),
                                                        Text(
                                                          status ? 'Online' : 'Offline',
                                                          style: AppTextStyle.bold(
                                                            rawFontSize:
                                                                AppConfig.defaultRawTextSize - 1.0,
                                                            color: status
                                                                ? Colors.green
                                                                : AppColors.redColor,
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                                // Row(
                                                //   children: [
                                                //     Container(
                                                //       height: 8,
                                                //       width: 8,
                                                //       decoration: BoxDecoration(
                                                //         color: printer.pingStatus
                                                //             ? Colors.green
                                                //             : AppColors.redColor,
                                                //         shape: BoxShape.circle,
                                                //       ),
                                                //     ),
                                                //     const Gap(4),
                                                //     Text(
                                                //       printer.pingStatus ? 'Online' : 'Offline',
                                                //       style: AppTextStyle.bold(
                                                //         rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                                                //         color: printer.pingStatus
                                                //             ? Colors.green
                                                //             : AppColors.redColor,
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                          ),
                                          if (selected)
                                            Icon(
                                              Icons.check_circle_rounded,
                                              color: Color.fromARGB(255, 57, 132, 194),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          error: (error, stackTrace) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Tooltip(
                                    message: 'Nhấn để thử lại',
                                    child: IconButton(
                                      onPressed: () {
                                        ref.refresh(printersProvider);
                                      },
                                      icon: Icon(
                                        Icons.refresh,
                                        size: 32,
                                        color: AppColors.redColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Không thể tải danh sách máy in',
                                    style: AppTextStyle.medium(
                                      rawFontSize: AppConfig.defaultRawTextSize,
                                      color: AppColors.redColor,
                                    ),
                                  ),
                                  Text(
                                    error.toString(),
                                    style: AppTextStyle.regular(
                                      color: Colors.grey.shade500,
                                      rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          },
                          loading: () {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(),
                                  ),
                                  const Gap(8),
                                  Text(
                                    'Đang tải danh sách máy in',
                                    style: AppTextStyle.regular(
                                      rawFontSize: AppConfig.defaultRawTextSize,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),

            if (widget.dialog) ...[
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                    textAction: 'Đóng',
                    color: Colors.grey.shade400,
                    onPressed: () {
                      pop(context);
                    },
                  ),
                  AppButton(
                    textAction: 'Lưu',
                    color: AppColors.secondColor,
                    onPressed: () {
                      pop(context);
                      widget.onChangePrinterConfig?.call(printerSelect, useDefaultPrinter);
                    },
                  ),
                ],
              ),
            ],
            // const SizedBox(height: 16),

            // // _buildActions(context), const SizedBox(height: 16),
            // AppButton(
            //   textAction: 'Lưu thiết lập',
            //   color: AppColors.secondColor,
            //   onPressed: () {
            //     ref
            //         .read(cartPageProvider.notifier)
            //         .mapProductWithPrinter(saveConfigPrinter: true);
            //   },
            // ),
          ],
        ),
      ),
      // ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomCheckbox(
          onChange: () {},
        ),
        Expanded(
            child: Text(
                'Lưu thiết lập cho những món đã chọn trong lần gọi tiếp theo trên thiết bị này!')),
        // Expanded(
        //   child: OutlinedButton(
        //     onPressed: () => Navigator.pop(context),
        //     child: const Text('Đóng'),
        //   ),
        // ),
        // const SizedBox(width: 12),
        // Expanded(
        //   child: ElevatedButton(
        //     onPressed: () {
        //       ref.read(cartPageProvider.notifier).mapProductWithPrinter(saveConfigPrinter: true);
        //     },
        //     child: const Text('Lưu thiết lập'),
        //   ),
        // ),
      ],
    );
  }
}

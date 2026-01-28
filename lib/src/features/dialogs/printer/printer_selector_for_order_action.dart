import 'dart:async';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/enum/printer_type.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';

import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'widgets/barrel_widget.dart';

Future<PrinterModel?> showPrinterSelectorForOrderActionDialog(
  BuildContext context,
  PrinterModel? current,
) {
  return showDialog<PrinterModel>(
    context: context,
    barrierDismissible: true,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: AppConfig.borderRadiusMain,
      ),
      child: PrinterSelectorForOrderAction(
        initPrinters: {if (current != null) current},
        dialog: true,
        defaultTypePrinter: [
          PrinterTypeEnum.total,
          PrinterTypeEnum.receipt,
          PrinterTypeEnum.tmp,
          PrinterTypeEnum.kitchen,
          PrinterTypeEnum.bar,
        ].map((e) => e.key).toSet(),
      ),
    ),
  );
}

class PrinterSelectorForOrderAction extends ConsumerStatefulWidget {
  const PrinterSelectorForOrderAction({
    super.key,
    this.initPrinters = const <PrinterModel>{},
    this.title = '',
    this.onChangePrinterConfig,
    this.dialog = false,
    this.width = 400.0,
    this.defaultTypePrinter = const <int>{},
    this.defaultPrinterProvider,
    this.onRetryDefaultPrinterProvider,
  });
  final Set<PrinterModel> initPrinters;
  final String title;

  final Function(Set<PrinterModel>, bool)? onChangePrinterConfig;
  final bool dialog;
  final double width;

  final Set<int> defaultTypePrinter;
  final ProviderListenable<AsyncValue<List<PrinterModel>>>?
      defaultPrinterProvider;
  final VoidCallback? onRetryDefaultPrinterProvider;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PrinterSelectorForOrderActionState();
}

class _PrinterSelectorForOrderActionState
    extends ConsumerState<PrinterSelectorForOrderAction> {
  PrinterModel? selected;

  Set<PrinterModel> printerSelect = {};
  bool useDefaultPrinter = true;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 8,
          minLeadingWidth: 0,
          dense: true,
          minVerticalPadding: 0,
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        ),
      ),
      child: SizedBox(
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
                    const Icon(Icons.print),
                    const Gap(8),
                    Expanded(
                      child: Text(
                        widget.title.trim(),
                        style: AppTextStyle.bold(),
                      ),
                    ),
                  ],
                ),
              RadioListTile(
                value: true,
                groupValue: useDefaultPrinter,
                onChanged: (value) {
                  onChangeUseDefaultPrinter(true);
                },
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Sử dụng máy in mặc định theo món',
                        style: AppTextStyle.regular(),
                      ),
                    ),
                    _BtnRefreshListPrinters(
                      useDefaultPrinter: useDefaultPrinter,
                      hide: !useDefaultPrinter,
                      defaultPrinterProvider: widget.defaultPrinterProvider,
                      onRetryDefaultPrinterProvider:
                          widget.onRetryDefaultPrinterProvider,
                    ),
                  ],
                ),
              ),
              RadioListTile(
                value: false,
                groupValue: useDefaultPrinter,
                onChanged: (value) {
                  printerSelect = {};
                  onChangeUseDefaultPrinter(false);
                },
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Chọn máy in khác',
                        style: AppTextStyle.regular(),
                      ),
                    ),
                    _BtnRefreshListPrinters(
                      useDefaultPrinter: useDefaultPrinter,
                      hide: useDefaultPrinter,
                      defaultPrinterProvider: widget.defaultPrinterProvider,
                      onRetryDefaultPrinterProvider:
                          widget.onRetryDefaultPrinterProvider,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: useDefaultPrinter
                    ? Consumer(
                        builder: (context, ref, child) {
                          var printers = ref.watch(
                              widget.defaultPrinterProvider ??
                                  printerByOrderProvider);
                          return printers.when(
                            skipError: false,
                            skipLoadingOnRefresh: false,
                            skipLoadingOnReload: false,
                            data: (data) => ListPrintersSection(
                              data: data,
                              printerSelect: printerSelect,
                              addPostFrameCallback: (p0) {
                                var item = p0
                                    .where((e) => widget.defaultTypePrinter
                                        .contains(e.type))
                                    .toSet();
                                setState(() {
                                  printerSelect = item;
                                  widget.onChangePrinterConfig
                                      ?.call(item, useDefaultPrinter);
                                });
                              },
                            ),
                            error: (error, stackTrace) =>
                                FetchListPrintersError(
                              error: error.toString(),
                              onRetry: () {
                                if (widget.defaultPrinterProvider != null) {
                                  widget.onRetryDefaultPrinterProvider?.call();
                                } else {
                                  ref.refresh(printerByOrderProvider);
                                }
                              },
                            ),
                            loading: () => const FetchListPrintersLoading(),
                          );
                        },
                      )
                    : Consumer(
                        builder: (context, ref, child) {
                          var printers = ref.watch(printersProvider);
                          return printers.when(
                            skipError: false,
                            skipLoadingOnRefresh: false,
                            skipLoadingOnReload: false,
                            data: (data) => ListPrintersSection(
                              data: data,
                              onSelectPrinter: (p0, p1) {
                                onChangePrinterSelect(p0, p1);
                              },
                              printerSelect: printerSelect,
                            ),
                            error: (error, stackTrace) =>
                                FetchListPrintersError(
                              error: error.toString(),
                              onRetry: () {
                                ref.refresh(printersProvider);
                              },
                            ),
                            loading: () => const FetchListPrintersLoading(),
                          );
                        },
                      ),
              ),
              if (widget.dialog) ...[
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppCloseButton(),
                    AppButton(
                      textAction: 'Lưu',
                      color: AppColors.secondColor,
                      onPressed: () {
                        pop(context);
                        widget.onChangePrinterConfig
                            ?.call(printerSelect, useDefaultPrinter);
                      },
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _BtnRefreshListPrinters extends ConsumerWidget {
  const _BtnRefreshListPrinters({
    super.key,
    this.useDefaultPrinter = true,
    this.hide = false,
    this.defaultPrinterProvider,
    this.onRetryDefaultPrinterProvider,
  });
  final bool useDefaultPrinter;
  final bool hide;

  final ProviderListenable<AsyncValue<List<PrinterModel>>>?
      defaultPrinterProvider;
  final VoidCallback? onRetryDefaultPrinterProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (hide) return const SizedBox.shrink();
    bool smallDevice = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    var printers = ref.watch(printersProvider);
    var printerByOrder =
        ref.watch(defaultPrinterProvider ?? printerByOrderProvider);
    bool show1 = printers.when(
      skipError: false,
      skipLoadingOnRefresh: false,
      skipLoadingOnReload: false,
      data: (data) => true,
      error: (error, stackTrace) => true,
      loading: () => false,
    );
    bool show2 = printerByOrder.when(
      skipError: false,
      skipLoadingOnRefresh: false,
      skipLoadingOnReload: false,
      data: (data) => true,
      error: (error, stackTrace) => true,
      loading: () => false,
    );
    bool show = useDefaultPrinter ? show2 : show1;
    if (!show) return const SizedBox.shrink();
    return Tooltip(
      message: 'Tải lại danh sách máy in',
      child: IconButton(
        onPressed: () {
          if (useDefaultPrinter) {
            if (defaultPrinterProvider != null) {
              onRetryDefaultPrinterProvider?.call();
            } else {
              ref.refresh(printerByOrderProvider);
            }
          } else {
            ref.refresh(printersProvider);
          }
        },
        icon: const Icon(Icons.cloud_sync_outlined),
        style: !smallDevice
            ? null
            : const ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.all(0))),
      ),
    );
  }
}

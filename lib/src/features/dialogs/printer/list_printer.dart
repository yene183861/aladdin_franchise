import 'dart:async';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/enum/printer_type.dart';
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
import 'package:responsive_framework/responsive_framework.dart';

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
            defaultTypePrinter: [
              PrinterTypeEnum.total,
              PrinterTypeEnum.receipt,
              PrinterTypeEnum.tmp,
              PrinterTypeEnum.kitchen,
              PrinterTypeEnum.bar,
            ].map((e) => e.key).toSet(),
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
    this.defaultTypePrinter = const <int>{},
  });
  final Set<PrinterModel> initPrinters;
  final String title;

  final Function(Set<PrinterModel>, bool)? onChangePrinterConfig;
  final bool dialog;
  final double width;

  final Set<int> defaultTypePrinter;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListPrintersDialogState();
}

class _ListPrintersDialogState extends ConsumerState<ListPrintersDialog> {
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
                        S.current.use_default_printer,
                        style: AppTextStyle.regular(),
                      ),
                    ),
                    _BtnRefreshListPrinters(
                      useDefaultPrinter: useDefaultPrinter,
                      hide: !useDefaultPrinter,
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
                        S.current.select_another_printer,
                        style: AppTextStyle.regular(),
                      ),
                    ),
                    _BtnRefreshListPrinters(
                      useDefaultPrinter: useDefaultPrinter,
                      hide: useDefaultPrinter,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: useDefaultPrinter
                    ? Consumer(
                        builder: (context, ref, child) {
                          var printers = ref.watch(printerByOrderProvider);
                          return printers.when(
                            skipError: false,
                            skipLoadingOnRefresh: false,
                            skipLoadingOnReload: false,
                            data: (data) => _ListPrintersSection(
                              data: data,
                              printerSelect: printerSelect,
                              addPostFrameCallback: (p0) {
                                var item = p0
                                    .where((e) => widget.defaultTypePrinter.contains(e.type))
                                    .toSet();
                                setState(() {
                                  printerSelect = item;
                                  widget.onChangePrinterConfig?.call(item, useDefaultPrinter);
                                });
                              },
                            ),
                            error: (error, stackTrace) => _FetchListPrintersError(
                              error: error.toString(),
                              onRetry: () {
                                ref.refresh(printerByOrderProvider);
                              },
                            ),
                            loading: () => const _FetchListPrintersLoading(),
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
                            data: (data) => _ListPrintersSection(
                              data: data,
                              onSelectPrinter: (p0, p1) {
                                onChangePrinterSelect(p0, p1);
                              },
                              printerSelect: printerSelect,
                            ),
                            error: (error, stackTrace) => _FetchListPrintersError(
                              error: error.toString(),
                              onRetry: () {
                                ref.refresh(printersProvider);
                              },
                            ),
                            loading: () => const _FetchListPrintersLoading(),
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
                      textAction: S.current.save,
                      color: AppColors.secondColor,
                      onPressed: () {
                        pop(context);
                        widget.onChangePrinterConfig?.call(printerSelect, useDefaultPrinter);
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

class _FetchListPrintersError extends ConsumerWidget {
  const _FetchListPrintersError({
    super.key,
    required this.error,
    this.onRetry,
  });

  final String error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Tooltip(
              message: S.current.tap_to_try_again,
              child: IconButton(
                onPressed: onRetry,
                icon: const Icon(
                  Icons.refresh,
                  color: AppColors.redColor,
                ),
              ),
            ),
            Text(
              S.current.unable_load_printer_list,
              style: AppTextStyle.medium(
                rawFontSize: AppConfig.defaultRawTextSize,
                color: AppColors.redColor,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              error,
              style: AppTextStyle.regular(
                color: Colors.grey.shade500,
                rawFontSize: AppConfig.defaultRawTextSize - 1.0,
              ),
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _FetchListPrintersLoading extends ConsumerWidget {
  const _FetchListPrintersLoading();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(),
            ),
            const Gap(8),
            Text(
              S.current.loading_printer_list,
              style: AppTextStyle.regular(rawFontSize: AppConfig.defaultRawTextSize),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ListPrintersSection extends ConsumerWidget {
  const _ListPrintersSection({
    this.data = const [],
    this.onSelectPrinter,
    this.printerSelect = const <PrinterModel>{},
    this.addPostFrameCallback,
  });

  final List<PrinterModel> data;
  final Function(PrinterModel, bool)? onSelectPrinter;
  final Set<PrinterModel> printerSelect;
  final Function(Set<PrinterModel>)? addPostFrameCallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        addPostFrameCallback?.call(data.toSet());
      },
    );
    if (data.isEmpty) {
      return Center(
        child: Text(
          S.current.printer_list_empty,
          style: AppTextStyle.regular(
            color: Colors.grey.shade400,
            rawFontSize: AppConfig.defaultRawTextSize - 1.0,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      itemCount: data.length,
      separatorBuilder: (context, index) => const Gap(12),
      itemBuilder: (context, index) {
        var printer = data[index];
        bool selected = printerSelect.contains(printer);
        return InkWell(
          onTap: () {
            onSelectPrinter?.call(printer, !selected);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: selected ? Color.fromARGB(255, 57, 132, 194) : Colors.grey.shade200,
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
                    ],
                  ),
                ),
                if (selected)
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Color.fromARGB(255, 57, 132, 194),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BtnRefreshListPrinters extends ConsumerWidget {
  const _BtnRefreshListPrinters({
    super.key,
    this.useDefaultPrinter = true,
    this.hide = false,
  });
  final bool useDefaultPrinter;
  final bool hide;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (hide) return const SizedBox.shrink();
    bool smallDevice = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    var printers = ref.watch(printersProvider);
    var printerByOrder = ref.watch(printerByOrderProvider);
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
      message: S.current.reload_printer_list,
      child: IconButton(
        onPressed: () {
          if (useDefaultPrinter) {
            ref.refresh(printerByOrderProvider);
          } else {
            ref.refresh(printersProvider);
          }
        },
        icon: const Icon(Icons.cloud_sync_outlined),
        style: !smallDevice
            ? null
            : const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(0))),
      ),
    );
  }
}

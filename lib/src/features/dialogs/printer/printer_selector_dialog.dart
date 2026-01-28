import 'dart:async';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/barrel_widget.dart';

Future<bool?> showPrinterSelectorDialog(
  BuildContext context, {
  String? textAction,
  Future<String?> Function(Set<PrinterModel> printerSelect)? action,
}) {
  return showDialog<bool?>(
    context: context,
    barrierDismissible: true,
    builder: (_) => FractionallySizedBox(
      widthFactor: 0.7,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: AppConfig.borderRadiusMain,
        ),
        child: _PrinterSelectorDialogBody(
          textAction: textAction,
          action: action,
        ),
      ),
    ),
  );
}

class _PrinterSelectorDialogBody extends ConsumerStatefulWidget {
  const _PrinterSelectorDialogBody({super.key, this.textAction, this.action});
  final String? textAction;
  final Future<String?> Function(Set<PrinterModel> printerSelect)? action;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __PrinterSelectorDialogBodyState();
}

class __PrinterSelectorDialogBodyState
    extends ConsumerState<_PrinterSelectorDialogBody> {
  Set<PrinterModel> printerSelect = {};
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Chọn danh sách máy in',
                  style: AppTextStyle.bold(
                    rawFontSize: AppConfig.defaultRawTextSize + 1.0,
                  ),
                ),
              ),
              const CloseButton(),
            ],
          ),
          Flexible(
            child: Consumer(
              builder: (context, ref, child) {
                var printers = ref.watch(printersProvider);
                return printers.when(
                  skipError: false,
                  skipLoadingOnRefresh: false,
                  skipLoadingOnReload: false,
                  data: (data) => ListPrintersSection(
                    data: data,
                    onSelectPrinter: (p0, p1) {
                      if (p1) {
                        printerSelect.add(p0);
                      } else {
                        printerSelect.remove(p0);
                      }
                      setState(() {});
                    },
                    printerSelect: printerSelect,
                    onRefreshData: () {
                      ref.refresh(printersProvider);
                    },
                    // addPostFrameCallback: (value) {
                    // },
                  ),
                  error: (error, stackTrace) => FetchListPrintersError(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const AppCloseButton(),
              AppButton(
                textAction: widget.textAction,
                onPressed: printerSelect.isEmpty
                    ? null
                    : () async {
                        var error = await widget.action?.call(printerSelect);
                        if (error == null) {
                          pop(context, true);
                        } else {
                          showMessageDialog(context, message: error);
                        }
                      },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

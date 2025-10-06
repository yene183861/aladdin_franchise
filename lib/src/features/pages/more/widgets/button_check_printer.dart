import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonCheckPrinterWidget extends ConsumerWidget {
  const ButtonCheckPrinterWidget({
    super.key,
    this.printers = const [],
  });

  final List<IpOrderModel> printers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (printers.isEmpty) return const SizedBox.shrink();
    return ListTile(
      onTap: () async {
        List<IpOrderModel> printerSelect = [];
        await showConfirmActionWithChild(
          context,
          title: S.current.printer_list,
          child: _PrinterSelectWidget(
            printers: printers,
            updatePrinterSelect: (p0) {
              printerSelect = List.from(p0);
            },
          ),
          closeDialog: false,
          onCheckAction: () {
            if (printerSelect.isEmpty) {
              showMessageDialog(context,
                  message: S.current.please_select_printer_to_check);
              return false;
            }
            return true;
          },
          action: () async {
            final result = await ref
                .read(homeProvider.notifier)
                .checkPrinter(printerSelect);
            if (result == null) {
              await showMessageDialog(context,
                  message: S.current.printer_work_stably);
              pop(context);
              return;
            }
            showMessageDialog(context, message: result);
          },
        );
      },
      leading: Icon(
        CupertinoIcons.printer,
        color: Colors.red[700],
      ),
      title: Text(
        S.current.check_printer_status,
        style: AppTextStyle.regular(),
      ),
    );
  }
}

class _PrinterSelectWidget extends ConsumerStatefulWidget {
  const _PrinterSelectWidget(
      {super.key, this.printers = const [], this.updatePrinterSelect});

  final List<IpOrderModel> printers;

  final Function(List<IpOrderModel>)? updatePrinterSelect;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __PrinterSelectWidgetState();
}

class __PrinterSelectWidgetState extends ConsumerState<_PrinterSelectWidget> {
  List<IpOrderModel> printerSelect = [];

  void updatePrinterSelect(IpOrderModel item) {
    if (printerSelect.contains(item)) {
      printerSelect.remove(item);
    } else {
      printerSelect.add(item);
    }

    widget.updatePrinterSelect?.call(printerSelect);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 500, minHeight: 200),
      width: 400,
      child: ListView.separated(
        itemBuilder: (context, index) {
          var item = widget.printers[index];
          return GestureDetector(
            onTap: () {
              updatePrinterSelect(item);
            },
            child: Row(
              children: [
                CustomCheckbox(
                  onChange: () {
                    updatePrinterSelect(item);
                  },
                  checked: printerSelect.contains(item),
                ),
                const Gap(8),
                Flexible(
                  child: Text('${item.name} (${item.ip}:${item.port})'),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const Gap(4),
        itemCount: widget.printers.length,
      ),
    );
  }
}

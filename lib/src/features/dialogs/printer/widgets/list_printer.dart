import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';

import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListPrintersSection extends ConsumerWidget {
  const ListPrintersSection({
    super.key,
    this.data = const [],
    this.onSelectPrinter,
    this.printerSelect = const <PrinterModel>{},
    this.addPostFrameCallback,
    this.onRefreshData,
  });

  final List<PrinterModel> data;
  final Function(PrinterModel, bool)? onSelectPrinter;
  final Set<PrinterModel> printerSelect;
  final Function(Set<PrinterModel>)? addPostFrameCallback;
  final VoidCallback? onRefreshData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        addPostFrameCallback?.call(data.toSet());
      },
    );
    if (data.isEmpty) {
      return Center(
        child: Tooltip(
          message: onRefreshData == null ? '' : 'Nhấn để tải lại',
          child: InkWell(
            onTap: onRefreshData,
            child: Text(
              'Danh sách máy in trống',
              style: AppTextStyle.regular(
                color: Colors.grey.shade400,
                rawFontSize: AppConfig.defaultRawTextSize - 1.0,
              ),
            ),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        onRefreshData?.call();
      },
      child: ListView.separated(
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
      ),
    );
  }
}

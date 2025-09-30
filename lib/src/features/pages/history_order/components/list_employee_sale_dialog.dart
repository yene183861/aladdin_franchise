import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/history_order/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/cashier.dart';
import 'package:aladdin_franchise/src/models/employee_sale.dart';
import 'package:aladdin_franchise/src/models/sale.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'history_order_detail_dialog.dart';

Future<EmployeeSaleModel?> showEmployeeSaleListDialog(BuildContext context,
    {String? actionTitle}) async {
  return showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (context) => PopScope(
        canPop: false,
        child: _EmployeeSaleListDialog(
          actionTitle: actionTitle,
        )),
  );
}

class _EmployeeSaleListDialog extends ConsumerStatefulWidget {
  const _EmployeeSaleListDialog({super.key, this.actionTitle});

  final String? actionTitle;

  @override
  ConsumerState createState() => __EmployeeSaleListDialogState();
}

class __EmployeeSaleListDialogState
    extends ConsumerState<_EmployeeSaleListDialog> {
  EmployeeSaleModel? saleSelect;
  bool initCashier = false;

  late TextEditingController _searchCtrl;

  late ValueNotifier<String> _textSearchNotifier;

  @override
  void initState() {
    super.initState();
    _searchCtrl = TextEditingController();
    _textSearchNotifier = ValueNotifier<String>('');

    _searchCtrl.addListener(
      () {
        _textSearchNotifier.value = _searchCtrl.text.trim();
      },
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _textSearchNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state =
        ref.watch(homeProvider.select((value) => value.employeeSaleState));
    final employeeSales =
        ref.watch(homeProvider.select((value) => value.employeeSales));

    return AlertDialog(
      title: Text(
        S.current.list_sales,
        style: AppTextStyle.medium(fontSize: 14.sp),
      ),
      content: SizedBox(
        width: 500,
        height: double.maxFinite,
        child: Column(
          children: [
            TextFieldSimpleWidget(
              textController: _searchCtrl,
              hintText: S.current.search_by_name,
            ),
            Expanded(
              child: switch (state.status) {
                PageCommonState.normal => Container(),
                PageCommonState.loading =>
                  AppLoadingSimpleWidget(message: S.current.loading_list),
                PageCommonState.error => AppErrorSimpleWidget(
                    onTryAgain: () {
                      ref.read(homeProvider.notifier).getEmployeeSales();
                    },
                    message:
                        "${S.current.unable_load_sales_list}\n${S.current.ex_problem}:${state.messageError}",
                  ),
                PageCommonState.success => ValueListenableBuilder(
                    valueListenable: _textSearchNotifier,
                    builder: (context, value, child) {
                      var history =
                          ref.read(historyOrderPageProvider).historyOrderSelect;
                      var textSearch =
                          removeDiacritics(value.trim().toLowerCase());

                      var dataView = employeeSales
                          .where((e) =>
                              [
                                0,
                                if (history?.orderType != null)
                                  history?.orderType
                              ].contains(e.isOnline) &&
                              removeDiacritics(e.fullName.trim().toLowerCase())
                                  .contains(textSearch))
                          .toList();
                      return dataView.isEmpty
                          ? Center(
                              child: Text(
                                S.current.list_sales_empty,
                                style: AppTextStyle.regular(),
                              ),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                bool selected = saleSelect == dataView[index];
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      saleSelect = dataView[index];
                                    });
                                  },
                                  borderRadius: AppConfig.borderRadiusMain,
                                  child: Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: AppConfig.borderRadiusMain,
                                      border: Border.all(
                                        color: selected
                                            ? AppColors.mainColor
                                            : Colors.grey,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            dataView[index].fullName,
                                            style: AppTextStyle.regular(),
                                          ),
                                        ),
                                        const Gap(4),
                                        if (selected)
                                          const Icon(
                                              CupertinoIcons
                                                  .check_mark_circled_solid,
                                              color: AppColors.mainColor),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Gap(4),
                              itemCount: dataView.length,
                            );
                    },
                  ),
              },
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        ButtonCancelWidget(
          onPressed: () => Navigator.pop(context, null),
        ),
        ButtonSimpleWidget(
          onPressed: () async {
            if (saleSelect == null) {
              showMessageDialog(context,
                  message: S.current.please_select_a_sale);
              return;
            }

            Navigator.pop(context, saleSelect);

            // await showConfirmAction(
            //   context,
            //   message: S.current.confirm_complete_order_with_sale,
            //   textCancel: S.current.cancel,
            //   actionTitle: S.current.confirm,
            //   action: () async {
            //     bool printNumberOfPeople = false;
            //     var confirm = await showConfirmActionWithChild(
            //       context,
            //       title: 'In lại hóa đơn cho khách hàng',
            //       child: ConfirmPrintBillAgain(onSave: (value) {
            //         printNumberOfPeople = value;
            //       }),
            //     );
            //     if (confirm != true) return;
            //     var result = await ref
            //         .read(historyOrderPageProvider.notifier)
            //         .printBillForCustomer(
            //           context,
            //           saleSelect: saleSelect,
            //           printNumberOfPeople: printNumberOfPeople,
            //         );
            //     if (result != null) {
            //       showMessageDialog(context,
            //           message: result, textAction: S.current.close);
            //       return;
            //     }
            //     showDoneSnackBar(
            //         context: context, message: S.current.print_bill_success);
            //     pop(context);
            //     ref.refresh(historyOrderProvider);
            //   },
            // );
          },
          color: AppColors.bgButtonMain,
          textColor: AppColors.tcButtonMain,
          textAction: widget.actionTitle ?? S.current.print_bill,
        )
      ],
    );
  }
}

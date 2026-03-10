import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_input.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/printer/list_printer.dart';
import 'package:aladdin_franchise/src/features/pages/cart/provider.dart';
import 'package:aladdin_franchise/src/features/pages/cart/widgets/order_item_line.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';

import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/dialog/title_with_close_icon.dart';
import 'package:aladdin_franchise/src/features/widgets/empty_data_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

void showAddOrderItemDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const Dialog(
        child: _AddOrderItemDialogBody(),
      );
    },
  );
}

class _AddOrderItemDialogBody extends ConsumerStatefulWidget {
  const _AddOrderItemDialogBody();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __AddOrderItemDialogBodyState();
}

class __AddOrderItemDialogBodyState extends ConsumerState<_AddOrderItemDialogBody> {
  Set<PrinterModel> printerSelect = {};
  bool useDefaultPrinter = true;
  bool useKds = (LocalStorage.getDataLogin()?.restaurant?.posStatus ?? false);

  @override
  Widget build(BuildContext context) {
    bool isPhone = ResponsiveBreakpoints.of(context).smallerThan(DESKTOP);
    var productIdSelect = ref.watch(cartPageProvider.select((value) => value.productIdSelect));
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppConfig.borderRadiusMain,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(8),
          TitleWithCloseIconDialog(
            title: S.current.processOrder,
            icon: Icons.shopping_cart_outlined,
          ),
          const Divider(height: 1),
          Flexible(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                children: [
                  const Gap(12),
                  if (!useKds)
                    Row(
                      children: [
                        const Icon(Icons.list_alt_outlined),
                        const Gap(8),
                        Expanded(
                          child: Text(
                            S.current.list_dish,
                            style: AppTextStyle.bold(),
                          ),
                        ),
                      ],
                    ),
                  Expanded(child: Consumer(
                    builder: (context, ref, child) {
                      var items =
                          ref.watch(cartPageProvider.select((value) => value.productsSelecting));
                      if (items.isEmpty) {
                        return EmptyDataWidget(
                          message: S.current.add_item_to_order,
                          icon: Icons.shopping_cart_outlined,
                        );
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        itemBuilder: (context, index) {
                          var item = items[index];
                          var selected = productIdSelect.contains(item.id);
                          return CartOrderLine(
                            allowEnterNote: true,
                            item: item,
                            selected: selected,
                            onTap: (p0) {
                              ref
                                  .read(cartPageProvider.notifier)
                                  .onChangeProductIdSelect(item.id, !selected);
                            },
                          );
                        },
                        itemCount: items.length,
                        separatorBuilder: (context, index) => const Gap(8),
                      );
                    },
                  )),
                ],
              )),
              if (!useKds) ...[
                const VerticalDivider(width: 1),
                Consumer(builder: (context, ref, child) {
                  var items =
                      ref.watch(cartPageProvider.select((value) => value.productsSelecting));
                  Set<int> printerType = {};
                  for (var item in items) {
                    if (item.numberSelecting > 0 && item.printerType != null) {
                      printerType.add(item.printerType!);
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: ListPrintersDialog(
                      width: 400 * (isPhone ? 0.7 : 1.0),
                      title: S.current.printer_options,
                      onChangePrinterConfig: (p0, p1) {
                        printerSelect = Set<PrinterModel>.from(p0);
                        useDefaultPrinter = p1;
                      },
                      defaultTypePrinter: printerType,
                    ),
                  );
                }),
              ],
            ],
          )),
          const Gap(12),
          Row(
            children: [
              Text(
                '${S.current.total}: ',
                style: AppTextStyle.regular(color: Colors.grey.shade500),
              ),
              Consumer(
                builder: (context, ref, child) {
                  var productIdSelect =
                      ref.watch(cartPageProvider.select((value) => value.productIdSelect));
                  var productsSelecting =
                      ref.watch(cartPageProvider.select((value) => value.productsSelecting));
                  double total = 0;
                  for (var i in productIdSelect) {
                    var p = productsSelecting.firstWhereOrNull((e) => e.id == i);
                    total += (p?.getUnitPriceNum() ?? 0.0) * (p?.numberSelecting ?? 0);
                  }
                  return Text(
                    AppUtils.formatCurrency(
                      symbol: 'đ',
                      value: total,
                    ),
                    style: AppTextStyle.bold(
                      color: AppColors.mainColor,
                      rawFontSize: AppConfig.defaultRawTextSize + 1.0,
                    ),
                  );
                },
              ),
              const Gap(16),
              const Spacer(),
              const AppCloseButton(),
              const Gap(12),
              Consumer(builder: (context, ref, child) {
                var productIdSelect =
                    ref.watch(cartPageProvider.select((value) => value.productIdSelect));
                return AppButton(
                  icon: Icons.shopping_cart_checkout_sharp,
                  textAction: S.current.add_to_order,
                  onPressed: productIdSelect.isEmpty
                      ? null
                      : () async {
                          var note = await showConfirmInputDialog(
                            context,
                            title: S.current.confirm,
                            message: S.current.orderConfirm,
                            hintText: S.current.enter_note_kitchen_or_bar,
                          );
                          if (note != null && context.mounted) {
                            _processOrder(
                              context: context,
                              note: note,
                              ignorePrint: useKds,
                            );
                          }
                        },
                  color: const Color.fromARGB(255, 57, 132, 194),
                );
              }),
              const Gap(12),
            ],
          ),
          const Gap(12),
        ],
      ),
    );
  }

  void _processOrder({
    required BuildContext context,
    String? note,
    bool ignorePrint = false,
    bool processOrder = true,
    int? turn,
  }) async {
    var result = await ref.read(cartPageProvider.notifier).addItemToOrder(
          note: note ?? '',
          printerSelect: useKds ? <PrinterModel>{} : printerSelect,
          useDefaultPrinter: useKds ? true : useDefaultPrinter,
          ignorePrint: ignorePrint,
          turn: turn,
        );
    if (result.checkPrinters != null) {
      if (context.mounted) {
        await showConfirmAction(
          context,
          message: '${result.checkPrinters ?? ''}\n${S.current.process_order_and_not_print}',
          actionTitle: S.current.continue_text,
          title: S.current.notification,
          action: () {
            _processOrder(
              context: context,
              note: note,
              ignorePrint: true,
              turn: result.timesOrders,
            );
          },
        );
      }
      return;
    } else if (result.error != null) {
      if (context.mounted) {
        showMessageDialog(context, message: result.error ?? '');
      }
    } else {
      if (result.resultSendPrintData != null) {
        if (context.mounted) {
          await showConfirmAction(
            context,
            message: S.current.msg_add_item_success_print_failed,
            actionTitle: S.current.print_now,
            textCancel: S.current.close,
            title: S.current.notification,
            action: () {
              _processOrder(
                context: context,
                note: note,
                processOrder: false,
                ignorePrint: ignorePrint,
                turn: result.timesOrders,
              );
            },
          );
        }
      }
      var state = ref.read(cartPageProvider);
      if (state.productsSelecting.isEmpty) {
        if (context.mounted) pop(context);
        ref.read(homeProvider.notifier).onChangeOrderTabSelect(OrderTabEnum.ordered);
      }
    }
  }
}

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/core/storages/provider.dart';
import 'package:aladdin_franchise/src/features/dialogs/error.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';

class CreateNewOrderDialog extends ConsumerStatefulWidget {
  const CreateNewOrderDialog({super.key});

  @override
  ConsumerState createState() => _CreateNewOrderDialogState();
}

class _CreateNewOrderDialogState extends ConsumerState<CreateNewOrderDialog> {
  List<int> tableIdsSelected = [];
  List<TableModel> tableSelected = [];
  TypeOrderEnum typeOrderSelect = TypeOrderEnum.offline;
  bool useReservation =
      LocalStorage.getDataLogin()?.restaurant?.reservationStatus ?? false;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (timeStamp) {
    //     ref.refresh(tablesAndOrdersProvider);
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    final tableAvailable = ref.watch(tablesAndOrdersProvider);
    return AlertDialog(
      title: Text(
        '${S.current.selectTable} - ${S.current.createNewOrder}',
        style: AppTextStyle.medium(
            // fontSize: 14.sp,
            ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: tableAvailable.when(
          skipLoadingOnRefresh: false,
          data: (data) {
            var notUseOffline = List<TableModel>.from(data.offline.notUse);
            var notUseOnline = List<TableModel>.from(data.online?.notUse ?? []);
            if ([...notUseOffline, ...notUseOnline].isEmpty) {
              return Center(
                  child: Text(
                S.current.tableOff,
                style: AppTextStyle.regular(),
              ));
            }
            var typeOrder = convertToTypeOrderEnum(kTypeOrder);

            List<dynamic> tableNotUseAndType = [
              if (ref.read(enableOrderOnlineProvider)) ...[
                TypeOrderEnum.offline,
                const Gap(12),
              ],
              notUseOffline,
            ];

            switch (typeOrder) {
              case TypeOrderEnum.offline:
                if (ref.read(enableOrderOnlineProvider)) {
                  tableNotUseAndType.addAll([
                    const Gap(20),
                    TypeOrderEnum.online,
                    const Gap(12),
                    notUseOnline
                  ]);
                }
                break;
              case TypeOrderEnum.online:
                tableNotUseAndType.insertAll(0, [
                  TypeOrderEnum.online,
                  const Gap(12),
                  notUseOnline,
                  const Gap(20)
                ]);
                break;
              default:
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...tableNotUseAndType.map((e) {
                    if (e is Widget) {
                      return e;
                    } else if (e is TypeOrderEnum) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                              .copyWith(bottomLeft: Radius.zero),
                          color: e.color,
                        ),
                        child: Text(
                          e.title,
                          style: AppTextStyle.bold(color: AppColors.white),
                        ),
                      );
                    } else if (e is List<TableModel>) {
                      if (e.isEmpty) {
                        return Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Center(
                              child: Text(
                                S.current.tableOff,
                                style: AppTextStyle.regular(),
                              ),
                            ));
                      }
                      return Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: e.map(
                            (e) {
                              bool isSelected = tableIdsSelected.contains(e.id);
                              return ChoiceChip(
                                padding: const EdgeInsets.all(12),
                                label: Text(
                                  e.name ?? "",
                                  style: AppTextStyle.regular(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                selected: isSelected,
                                selectedColor: AppColors.mainColor,
                                checkmarkColor: Colors.white,
                                onSelected: (value) {
                                  if (value) {
                                    tableSelected.add(e);
                                    typeOrderSelect =
                                        convertToTypeOrderEnum(e.typeOrder);
                                    List<int> ids = [];
                                    List<TableModel> tables = [];
                                    for (var t in tableSelected) {
                                      if (t.typeOrder == typeOrderSelect.type) {
                                        tables.add(t);
                                        ids.add(t.id);
                                      }
                                    }
                                    tableIdsSelected = List.from(ids);
                                    tableSelected = List.from(tables);
                                  } else {
                                    tableIdsSelected.remove(e.id);
                                    tableSelected.removeWhere(
                                        (element) => element.id == e.id);
                                  }
                                  setState(() {});
                                },
                              );
                            },
                          ).toList());
                    }
                    return const SizedBox.shrink();
                  }).toList(),
                ],
              ),
            );
          },
          error: (_, __) {
            return AppErrorSimpleWidget(
              onTryAgain: () {
                ref.refresh(tablesAndOrdersProvider);
              },
              message: "${S.current.canNotLoadTables}\n${_.toString()}",
            );
          },
          loading: () {
            return AppLoadingSimpleWidget(message: S.current.loading_list);
          },
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        ButtonCancelWidget(
          onPressed: () => Navigator.pop(
              context, (orderId: null, typeOrderEnum: TypeOrderEnum.offline)),
        ),
        ButtonSimpleWidget(
          onPressed: () async {
            // if (tableIdsSelected.isEmpty) {
            //   showMessageDialog(context, message: S.current.notTableSelected);
            //   return;
            // }

            // var result = await ref.read(homeProvider.notifier).createNewOrder(
            //     tableIdsSelected,
            //     typeOrderEnum: typeOrderSelect);
            // if (result.last == null) {
            //   showDoneSnackBar(
            //       context: context, message: S.current.createdNewOrder);
            //   Navigator.pop(context,
            //       (orderId: result.first, typeOrderEnum: typeOrderSelect));
            // } else {
            //   if (context.mounted) {
            //     await showErrorDialog(
            //       context,
            //       message: result.last,
            //       isNotifier: true,
            //     );
            //     // showMessageDialog(context, message: result.last);
            //   }
            // }
          },
          color: AppColors.bgButtonMain,
          textColor: AppColors.tcButtonMain,
          textAction: S.current.confirm,
        )
      ],
    );
  }
}

Future<({int? orderId, TypeOrderEnum typeOrderEnum})> showCreateNewOrderDialog(
    BuildContext context) async {
  final result = await showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (context) => const PopScope(
      canPop: false,
      child: CreateNewOrderDialog(),
    ),
  );
  return result;
}

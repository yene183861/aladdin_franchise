import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/enum/status.dart';
import 'package:aladdin_franchise/src/data/model/floor.dart';
import 'package:aladdin_franchise/src/data/model/table_layout_item.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/table_layout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/table_layout/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/button/btn_with_icon.dart';
import 'package:aladdin_franchise/src/features/widgets/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/widgets/dropdown/dropdown_menu_function.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/text_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/model/table_layout_setting.dart';
import 'dragger_table.dart';
import 'floor_dropdown.dart';
import 'list_reservations.dart';

class ItemSettingBottomSheet extends ConsumerStatefulWidget {
  const ItemSettingBottomSheet({
    super.key,
    required this.initSetting,
    required this.title,
    this.item,
  });

  final TableLayoutSettingModel initSetting;
  final String title;
  final TableLayoutItemModel? item;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __SettingBottomSheetState();
}

class __SettingBottomSheetState extends ConsumerState<ItemSettingBottomSheet> {
  TableLayoutSettingModel setting = const TableLayoutSettingModel();

  late TextEditingController widthCtrl, heightCtrl;
  FloorModel? floorSelect;
  TableModel? tableSelect;
  List<TableModel> allTables = [];

  @override
  void initState() {
    super.initState();
    setting = widget.initSetting;
    widthCtrl = TextEditingController(text: widget.initSetting.minTableWidth.toInt().toString());
    heightCtrl = TextEditingController(text: widget.initSetting.minTableHeight.toInt().toString());
    floorSelect = widget.item?.floorId == null ? null : FloorModel(id: widget.item!.floorId);
    tableSelect = widget.item?.table;
    if (widget.item != null) {
      setting = setting.copyWith(
        topChairs: widget.item?.topChair ?? 0,
        bottomChairs: widget.item?.bottomChair ?? 0,
        leftChairs: widget.item?.leftChair ?? 0,
        rightChairs: widget.item?.rightChair ?? 0,
      );
    }
  }

  @override
  void dispose() {
    widthCtrl.dispose();
    heightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: AppTextStyle.bold(rawFontSize: AppConfig.defaultRawTextSize + 1.0),
                  textAlign: TextAlign.center,
                ),
              ),
              ResponsiveIconButtonWidget(
                iconData: Icons.close,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const Gap(20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (widget.item == null) ...[
                      Row(
                        children: [
                          Expanded(
                            child: Text('Danh sách màu sử dụng', style: AppTextStyle.medium()),
                          ),
                          const Gap(8),
                          Consumer(
                            builder: (context, ref, child) {
                              bool unchecked = setting.availableTableColor !=
                                      TableColorEnum.available.colorValue ||
                                  setting.usingTableColor != TableColorEnum.using.colorValue ||
                                  setting.reservedTableColor != TableColorEnum.reserved.colorValue;
                              return AppCheckbox(
                                checked: !unchecked,
                                onChange: () {
                                  setState(() {
                                    setting = setting.copyWith(
                                      availableTableColor: TableColorEnum.available.colorValue,
                                      usingTableColor: TableColorEnum.using.colorValue,
                                      reservedTableColor: TableColorEnum.reserved.colorValue,
                                    );
                                  });
                                },
                                text: 'Màu mặc định',
                              );
                            },
                          ),
                        ],
                      ),
                      const Gap(8),
                      Wrap(
                        spacing: 48,
                        children: TableColorEnum.values
                            .map(
                              (e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(e.title),
                                  const Gap(4),
                                  InkWell(
                                    onTap: () async {
                                      var settingChange =
                                          await showDialog<TableLayoutSettingModel?>(
                                        context: context,
                                        builder: (context) {
                                          return ColorPickerDialog(
                                            type: e,
                                            setting: setting,
                                          );
                                        },
                                      );

                                      if (settingChange != null) {
                                        setState(() {
                                          setting = settingChange;
                                        });
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      height: 48,
                                      width: 48,
                                      decoration: BoxDecoration(
                                        color: setting.colorMap[e],
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.grey.shade200,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      const Gap(20),
                    ],
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: widget.item == null
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Kích thước tối thiểu', style: AppTextStyle.medium()),
                                    const Gap(8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: TextUtil.getTextSize(text: ' Ngang ').width,
                                                child: Text('Ngang'),
                                              ),
                                              const Gap(8),
                                              Expanded(
                                                child: AppTextFormField(
                                                  textController: widthCtrl,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.digitsOnly
                                                  ],
                                                  textInputType: TextInputType.number,
                                                  maxLength: 3,
                                                  textAlign: TextAlign.center,
                                                  onChanged: (p0) {
                                                    setState(() {
                                                      setting = setting.copyWith(
                                                          minTableWidth:
                                                              double.tryParse(p0) ?? 0.0);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Gap(8),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: TextUtil.getTextSize(text: 'Ngang').width,
                                                child: const Text(
                                                  'Dọc',
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                              const Gap(8),
                                              Expanded(
                                                child: AppTextFormField(
                                                  textController: heightCtrl,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.digitsOnly
                                                  ],
                                                  textInputType: TextInputType.number,
                                                  maxLength: 3,
                                                  textAlign: TextAlign.center,
                                                  onChanged: (p0) {
                                                    setState(() {
                                                      setting = setting.copyWith(
                                                          minTableHeight:
                                                              double.tryParse(p0) ?? 0.0);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Vị trí', style: AppTextStyle.medium()),
                                    const Gap(8),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              const Text('Tầng'),
                                              const Gap(8),
                                              Expanded(
                                                child: FloorDropdown(
                                                  floorInit: floorSelect,
                                                  onChangeFloor: (p0) {
                                                    floorSelect = p0;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Gap(20),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              const Text('Bàn'),
                                              const Gap(8),
                                              Expanded(
                                                child: Consumer(
                                                  builder: (context, ref, child) {
                                                    ref.watch(tablesAndOrdersProvider).when(
                                                          skipLoadingOnRefresh: false,
                                                          skipLoadingOnReload: false,
                                                          skipError: false,
                                                          data: (data) {
                                                            allTables = [
                                                              ...(data.offline?.notUse ?? []),
                                                              ...(data.offline?.using ?? [])
                                                            ];
                                                            return StatusEnum.success;
                                                          },
                                                          error: (error, stackTrace) =>
                                                              StatusEnum.error,
                                                          loading: () => StatusEnum.loading,
                                                        );

                                                    var items = ref.watch(tableLayoutPageProvider
                                                        .select((value) => value.items));
                                                    Set<int> assignedTableIds = {};
                                                    for (var i in items) {
                                                      if (i.table != null &&
                                                          tableSelect?.id != i.table?.id) {
                                                        assignedTableIds.add(i.table!.id);
                                                      }
                                                    }
                                                    var tables = allTables
                                                        .where(
                                                            (e) => !assignedTableIds.contains(e.id))
                                                        .toList();
                                                    WidgetsBinding.instance.addPostFrameCallback(
                                                      (timeStamp) {
                                                        if (allTables.isEmpty) return;
                                                        var tableChange =
                                                            allTables.firstWhereOrNull(
                                                                (e) => e.id == tableSelect?.id);
                                                        if (tableChange != tableSelect) {
                                                          setState(() {
                                                            tableSelect = tableChange;
                                                          });
                                                        }
                                                      },
                                                    );
                                                    return AppDropdownMenuFunction<TableModel>(
                                                      showBtnBottom: false,
                                                      datas: tables,
                                                      itemInit: tableSelect,
                                                      titleButton: 'Thêm tầng',
                                                      titleMenuItemBuilder: (p0) {
                                                        return p0.name ?? '';
                                                      },
                                                      onSelectionItem: (p0) {
                                                        tableSelect = p0;
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Consumer(
                                      builder: (context, ref, child) {
                                        var table = ref.watch(tablesAndOrdersProvider);
                                        return table.when(
                                          skipError: false,
                                          skipLoadingOnRefresh: false,
                                          data: (data) => const SizedBox.shrink(),
                                          error: (error, stackTrace) => Padding(
                                            padding: const EdgeInsets.only(top: 4),
                                            child: Align(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      'Không tải được danh sách bàn!',
                                                      style: AppTextStyle.regular(
                                                        color: AppColors.redColor,
                                                        rawFontSize:
                                                            AppConfig.defaultRawTextSize - 1.0,
                                                      ),
                                                    ),
                                                  ),
                                                  ResponsiveIconButtonWidget(
                                                    buttonStyle: ButtonStyle(
                                                        padding: const WidgetStatePropertyAll(
                                                            EdgeInsets.all(4)),
                                                        backgroundColor: WidgetStatePropertyAll(
                                                            Colors.grey.shade200)),
                                                    iconData: Icons.refresh_rounded,
                                                    color: Colors.black54,
                                                    onPressed: () {
                                                      ref.refresh(tablesAndOrdersProvider);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          loading: () => Padding(
                                            padding: const EdgeInsets.only(top: 8),
                                            child: Align(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  CupertinoActivityIndicator(color: AppColors.blue),
                                                  const Gap(4),
                                                  Flexible(
                                                    child: Text(
                                                      'Không tải được danh sách bàn!',
                                                      style: AppTextStyle.regular(
                                                        color: AppColors.blue,
                                                        rawFontSize:
                                                            AppConfig.defaultRawTextSize - 1.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                        ),
                        const Gap(12),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Xoay', style: AppTextStyle.medium()),
                              const Gap(8),
                              Row(
                                children: [
                                  _RotateWidget(
                                    onTap: () {
                                      setState(() {
                                        setting = setting.copyWith(
                                          topChairs: setting.bottomChairs,
                                          bottomChairs: setting.topChairs,
                                          leftChairs: setting.rightChairs,
                                          rightChairs: setting.leftChairs,
                                        );
                                      });
                                    },
                                    svgPath: Assets.iconsRotate3d,
                                    tooltip: 'Lật ngược',
                                  ),
                                  const Gap(4),
                                  _RotateWidget(
                                    onTap: () {
                                      setState(() {
                                        setting = setting.copyWith(
                                          topChairs: setting.leftChairs,
                                          bottomChairs: setting.rightChairs,
                                          leftChairs: setting.bottomChairs,
                                          rightChairs: setting.topChairs,
                                        );
                                      });
                                    },
                                    svgPath: Assets.iconsRotateCwSquare,
                                    tooltip: 'Xoay theo chiều kim đồng hồ',
                                  ),
                                  const Gap(4),
                                  _RotateWidget(
                                    onTap: () {
                                      setState(() {
                                        setting = setting.copyWith(
                                          topChairs: setting.rightChairs,
                                          bottomChairs: setting.leftChairs,
                                          leftChairs: setting.topChairs,
                                          rightChairs: setting.bottomChairs,
                                        );
                                      });
                                    },
                                    svgPath: Assets.iconsRotateCcwSquare,
                                    tooltip: 'Xoay ngược chiều kim đồng hồ',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // if (widget.item != null) ...[
                    //   Consumer(
                    //     builder: (context, ref, child) {
                    //       var reservationTimeCheck = ref.watch(tableLayoutPageProvider
                    //           .select((value) => value.reservationTimeCheck));
                    //       var reservationsData =
                    //           ref.watch(homeProvider.select((value) => value.reservations));

                    //       var today = DateTime.now().date;

                    //       var reservations = ((reservationsData[today]?['data'] ?? []) as List)
                    //           .map((e) => e as ReservationModel)
                    //           .toList();
                    //       var reservationsOfTable =
                    //           ref.read(tableLayoutPageProvider.notifier).getReservationsOfTable(
                    //                 reservations: reservations,
                    //                 table: widget.item?.table,
                    //                 reservationTimeCheck: reservationTimeCheck,
                    //               );

                    //       return Padding(
                    //         padding: const EdgeInsets.only(top: 20),
                    //         child: Row(
                    //           children: [
                    //             Text('Đặt bàn', style: AppTextStyle.medium()),
                    //             const Gap(12),
                    //             // Flexible(
                    //             //   child: AppButtonWithIconWidget(
                    //             //     icon: Icons.calendar_today,
                    //             //     textAction: reservationsOfTable.isEmpty
                    //             //         ? 'Tạo lịch đặt'
                    //             //         : reservationsOfTable.length > 1
                    //             //             ? '${reservationsOfTable.length} lịch đặt'
                    //             //             : '${reservationsOfTable.first.customer?.name ?? ''} - ${TextUtil.convertPhone(reservationsOfTable.first.customer?.phoneNumber ?? '')}',
                    //             //     color: Colors.blue.shade400,
                    //             //     onPressed: () async {
                    //             //       if (reservationsOfTable.isEmpty) {
                    //             //         await showDialog(
                    //             //           context: context,
                    //             //           useRootNavigator: false,
                    //             //           barrierDismissible: false,
                    //             //           builder: (context) => UpdateReservationDialog(
                    //             //             table: widget.item?.table,
                    //             //             startTime: ref
                    //             //                 .read(tableLayoutPageProvider.notifier)
                    //             //                 .startDateTime(),
                    //             //           ),
                    //             //         );
                    //             //         AppSingleton.instance.onChangeStatus(
                    //             //           openLogs: false,
                    //             //           openNotiPage: false,
                    //             //           openUpdateReserPage: false,
                    //             //         );
                    //             //         return;
                    //             //       } else if (reservationsOfTable.length == 1) {
                    //             //         await showDialog(
                    //             //           context: context,
                    //             //           useRootNavigator: false,
                    //             //           barrierDismissible: false,
                    //             //           builder: (context) => UpdateReservationDialog(
                    //             //             table: widget.item?.table,
                    //             //             reservation: reservationsOfTable.first,
                    //             //           ),
                    //             //         );
                    //             //         AppSingleton.instance.onChangeStatus(
                    //             //           openLogs: false,
                    //             //           openNotiPage: false,
                    //             //           openUpdateReserPage: false,
                    //             //         );
                    //             //         return;
                    //             //       }
                    //             //       showDialog(
                    //             //         context: context,
                    //             //         builder: (context) {
                    //             //           return ListReservationsDialog(
                    //             //             item: widget.item,
                    //             //           );
                    //             //         },
                    //             //       );
                    //             //     },
                    //             //   ),
                    //             // ),

                    //             if (reservationsOfTable.isNotEmpty) ...[
                    //               const Gap(8),
                    //               Tooltip(
                    //                 message: 'Thêm mới lịch đặt bàn',
                    //                 child: ResponsiveIconButtonWidget(
                    //                   iconData: Icons.add,
                    //                   buttonStyle: ButtonStyle(
                    //                     backgroundColor:
                    //                         const WidgetStatePropertyAll(Color(0xFFe1e8f1)),
                    //                     shape: WidgetStateProperty.all(
                    //                       RoundedRectangleBorder(
                    //                         borderRadius: BorderRadius.circular(12),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   onPressed: () async {
                    //                     // await showDialog(
                    //                     //   context: context,
                    //                     //   useRootNavigator: false,
                    //                     //   barrierDismissible: false,
                    //                     //   builder: (context) => UpdateReservationDialog(
                    //                     //     table: widget.item?.table,
                    //                     //     startTime: ref
                    //                     //         .read(tableLayoutPageProvider.notifier)
                    //                     //         .startDateTime(),
                    //                     //   ),
                    //                     // );
                    //                     // AppSingleton.instance.onChangeStatus(
                    //                     //   openLogs: false,
                    //                     //   openNotiPage: false,
                    //                     //   openUpdateReserPage: false,
                    //                     // );
                    //                   },
                    //                 ),
                    //               ),
                    //             ],
                    //           ],
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ],
                    const Gap(20),
                    Text('Số lượng chỗ ngồi', style: AppTextStyle.medium()),
                    const Gap(8),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _SeatSettingWidget(
                            title: 'Trên',
                            value: setting.topChairs,
                            onChangeValue: (p0) {
                              setState(() {
                                setting = setting.copyWith(topChairs: p0);
                              });
                            },
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          flex: 1,
                          child: _SeatSettingWidget(
                            title: 'Dưới',
                            value: setting.bottomChairs,
                            onChangeValue: (p0) {
                              setState(() {
                                setting = setting.copyWith(bottomChairs: p0);
                              });
                            },
                            maxValue: 6,
                          ),
                        ),
                      ],
                    ),
                    const Gap(12),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _SeatSettingWidget(
                            title: 'Trái',
                            value: setting.leftChairs,
                            onChangeValue: (p0) {
                              setState(() {
                                setting = setting.copyWith(leftChairs: p0);
                              });
                            },
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          flex: 1,
                          child: _SeatSettingWidget(
                            title: 'Phải',
                            value: setting.rightChairs,
                            onChangeValue: (p0) {
                              setState(() {
                                setting = setting.copyWith(rightChairs: p0);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Expanded(
                flex: 2,
                child: Center(
                  child: Builder(builder: (context) {
                    var textStyle = AppTextStyle.regular(
                      rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                      color: Colors.grey.shade700,
                    );
                    return Column(
                      children: [
                        Text('Xem trước', style: AppTextStyle.medium()),
                        const Gap(8),
                        Text('Trên', style: textStyle),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 50,
                              child: Text(
                                'Trái',
                                style: textStyle,
                                textAlign: TextAlign.end,
                              ),
                            ),
                            DraggerTableWidget(
                                itemSetting: setting.copyWith(
                                    availableTableColor: TableColorEnum.available.colorValue)),
                            SizedBox(
                              width: 50,
                              child: Text(
                                'Phải',
                                style: textStyle,
                              ),
                            ),
                          ],
                        ),
                        Text('Dưới', style: textStyle),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (widget.item == null)
                ButtonWithIconWidget(
                  textAction: 'Thiết lập mặc định',
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  // borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade400,
                  onPressed: () {
                    showConfirmAction(
                      context,
                      message: 'Bạn chắc chắn muốn thiết lập trở về ban đầu?',
                      action: () {
                        Navigator.of(context).pop((
                          setting: const TableLayoutSettingModel(),
                          table: null,
                          floor: null,
                        ));
                      },
                    );
                  },
                  icon: Icons.restart_alt_rounded,
                ),
              if (widget.item != null)
                ButtonWithIconWidget(
                  textAction: 'Xoá bỏ',
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  // borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade400,
                  onPressed: () {
                    showConfirmAction(
                      context,
                      message: 'Bạn chắc chắn muốn xoá bỏ bàn này trong bố cục?',
                      action: () {
                        ref.read(tableLayoutPageProvider.notifier).onDeleteLayoutItem();
                        Navigator.of(context).pop();
                      },
                    );
                  },
                  icon: Icons.delete,
                ),
              ButtonWithIconWidget(
                textAction: 'Lưu',
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                // borderRadius: BorderRadius.circular(12),
                onPressed: () {
                  Navigator.of(context).pop((
                    setting: setting,
                    table: tableSelect,
                    floor: floorSelect,
                  ));
                },
              ),
            ],
          ),
          Gap(MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );
  }
}

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({
    super.key,
    required this.type,
    required this.setting,
  });
  final TableColorEnum type;
  final TableLayoutSettingModel setting;

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  TableLayoutSettingModel setting = const TableLayoutSettingModel();
  @override
  void initState() {
    super.initState();
    setting = widget.setting;
  }

  @override
  Widget build(BuildContext context) {
    showLogs(setting.colorMap, flags: 'setting');
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text('Màu bàn - ${widget.type.title}'),
          ),
          const CloseButton(),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: ColorPicker(
                  enableAlpha: false,
                  showLabel: false,
                  pickerColor: setting.colorMap[widget.type] ?? Colors.transparent,
                  onColorChanged: (color) {
                    setState(() {
                      switch (widget.type) {
                        case TableColorEnum.available:
                          setting = setting.copyWith(availableTableColor: color.value);
                          break;
                        case TableColorEnum.using:
                          setting = setting.copyWith(usingTableColor: color.value);
                          break;
                        case TableColorEnum.reserved:
                          setting = setting.copyWith(reservedTableColor: color.value);
                          break;
                      }
                    });
                  },
                  portraitOnly: true,
                ),
              ),
              const Gap(12),
              DraggerTableWidget(
                order: widget.type == TableColorEnum.using
                    ? OrderModel(createdAt: DateTime.now().subtract(const Duration(hours: 1)))
                    : null,
                item: TableLayoutItemModel(
                  table: TableModel(id: 0, name: 'Bàn'),
                  topChair: 3,
                  bottomChair: 2,
                  typeOrder: kTypeOrder,
                ),
                itemSetting: setting,
                reservations: widget.type != TableColorEnum.reserved
                    ? []
                    : [
                        // ReservationModel(
                        //   customer: ReservationCustomerModel(
                        //     name: 'Khách',
                        //     phoneNumber: '012345678',
                        //   ),
                        //   startTime: '09:00',
                        //   reservationDate: '2025-01-02',
                        // ),
                      ],
              ),
            ],
          ),
          const Gap(12),
          ButtonWithIconWidget(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            textAction: 'Lưu',
            onPressed: () {
              Navigator.of(context).pop(setting);
            },
          ),
        ],
      ),
    );
  }
}

class _RotateWidget extends StatelessWidget {
  const _RotateWidget({
    this.onTap,
    required this.svgPath,
    this.tooltip,
  });
  final VoidCallback? onTap;
  final String svgPath;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: ResponsiveIconButtonWidget(
        svgPath: svgPath,
        buttonStyle: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.grey.shade200),
          padding: const WidgetStatePropertyAll(EdgeInsets.all(12)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        onPressed: onTap,
      ),
    );
  }
}

class _SeatSettingWidget extends StatelessWidget {
  const _SeatSettingWidget({
    required this.title,
    this.maxValue = 5,
    this.value = 1,
    this.minValue = 0,
    this.onChangeValue,
  });

  final String title;
  final int maxValue;
  final int value;
  final int minValue;
  final Function(int)? onChangeValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: TextUtil.getTextSize(text: 'Dưới  ').width,
          child: Text(title),
        ),
        const Gap(12),
        Container(
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: const Color(0xFFf1f4f9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Builder(
                builder: (context) {
                  bool disable = value <= minValue;
                  return ResponsiveIconButtonWidget(
                    iconData: Icons.remove,
                    color: disable ? Colors.grey.shade500 : Colors.black87,
                    buttonStyle: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(disable ? const Color(0xFFe1e8f1) : Colors.white),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (disable) return;
                      onChangeValue?.call(value - 1);
                    },
                  );
                },
              ),
              const Gap(12),
              SizedBox(
                width: 30,
                child: Text(
                  value.toString(),
                  style: AppTextStyle.bold(
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Gap(12),
              Builder(
                builder: (context) {
                  bool disable = value >= maxValue;
                  return ResponsiveIconButtonWidget(
                    iconData: Icons.add,
                    color: disable ? Colors.grey.shade500 : Colors.black87,
                    buttonStyle: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(disable ? const Color(0xFFe1e8f1) : Colors.white),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (disable) return;
                      onChangeValue?.call(value + 1);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

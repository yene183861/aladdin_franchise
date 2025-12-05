import 'dart:math';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/enum/status.dart';
import 'package:aladdin_franchise/src/data/model/floor.dart';
import 'package:aladdin_franchise/src/data/model/table_layout_item.dart';
import 'package:aladdin_franchise/src/data/model/table_layout_setting.dart';
import 'package:aladdin_franchise/src/features/common/process_state.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_input.dart';
import 'package:aladdin_franchise/src/features/pages/cart/components/order_items_widget.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/widgets/date_picker_dialog.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:vector_math/vector_math_64.dart' as vm;

import 'provider.dart';
import 'widgets/dragger_table.dart';
import 'state.dart';
import 'widgets/floor_dropdown.dart';
import 'widgets/setting.dart';

class TableLayoutPage extends ConsumerStatefulWidget {
  const TableLayoutPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TableLayoutPageState();
}

class _TableLayoutPageState extends ConsumerState<TableLayoutPage> {
  late TransformationController _controller;
  final GlobalKey _dragTargetKey = GlobalKey();
  final GlobalKey _dragLocalTargetKey = GlobalKey();

  double _canvasWidth = 4000;
  double _canvasHeight = 4000;
  final double _expandThreshold = 100;
  final double _expandStep = 800;

  /// vị trí của con trỏ so với góc (0,0) của widget con
  Offset? anchorOffset;

  List<TableModel> allTables = [];
  List<TableModel> usingTables = [];
  List<OrderModel> orders = [];
  // List<HistoryOrderModel> history = [];

  @override
  void initState() {
    super.initState();
    _controller = TransformationController();
    // _controller.addListener(_onTransformationChanged);

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(tableLayoutPageProvider.notifier).init();
      },
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onTransformationChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTransformationChanged() {
    final Matrix4 matrix = _controller.value;

    // Lấy thành phần tịnh tiến (pan) của ma trận
    final double translateX = matrix.storage[12];
    final double translateY = matrix.storage[13];

    // Lấy scale hiện tại
    final double scale = matrix.storage[0];

    // Lấy RenderBox của InteractiveViewer (hoặc SizedBox chứa Stack)
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size viewportSize = renderBox.size;

    // Tính toán kích thước hiển thị của viewport trong không gian local của canvas
    // Tức là, nếu InteractiveViewer đang hiển thị 100% màn hình,
    // nhưng đang zoom 2x, thì nó chỉ hiển thị 1/2 kích thước canvas thực tế.
    final double viewportWidthInCanvas = viewportSize.width / scale;
    final double viewportHeightInCanvas = viewportSize.height / scale;

    // Tính toán góc trên bên trái của khung nhìn trong không gian local của canvas
    // translateX và translateY là các giá trị âm khi pan sang phải và xuống.

    final double currentCanvasViewLeft = -translateX / scale;
    final double currentCanvasViewTop = -translateY / scale;

    bool panLimited = false;
    double newTranslateX = translateX;
    double newTranslateY = translateY;
    if (translateX > 0) {
      newTranslateX = 0;
      panLimited = true;
    }

    // // Ngăn Pan lên Trên (Giới hạn translateY <= 0)
    if (translateY > 0) {
      newTranslateY = 0;
      panLimited = true;
    }

    bool canvasExpanded = false;

    // Vị trí phải của khung nhìn (trên Canvas)
    final double canvasViewRight = currentCanvasViewLeft + viewportWidthInCanvas;
    if (canvasViewRight > _canvasWidth - _expandThreshold) {
      _canvasWidth += _expandStep;
      canvasExpanded = true;
    }

    // Vị trí dưới của khung nhìn (trên Canvas)
    final double canvasViewBottom = currentCanvasViewTop + viewportHeightInCanvas;

    if (canvasViewBottom > _canvasHeight - _expandThreshold) {
      _canvasHeight += _expandStep;
      canvasExpanded = true;
    }
    if (panLimited) {
      // Lên lịch thực thi sau khi khung hình hiện tại kết thúc
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _controller.value = Matrix4.identity()
          ..translate(newTranslateX, newTranslateY, 0.0)
          ..scale(scale);
      });
    }

    if (canvasExpanded) {
      setState(() {});
    }
  }

  double oldScale = 1.0;

  _listenEvent(BuildContext context, WidgetRef ref) => (bool? previous, bool? next) async {
        if (next ?? false) {
          oldScale = _controller.value.entry(0, 0);
          _controller.value = Matrix4.identity()..scale(1.0);
        }
      };

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(
      tableLayoutPageProvider.select((value) => value.enableDragLayout),
      _listenEvent(context, ref),
    );

    bool enableDragLayout =
        ref.watch(tableLayoutPageProvider.select((value) => value.enableDragLayout));
    var table = ref.watch(tablesAndOrdersProvider);
    ProcessState tableState;
    tableState = table.when(
      skipError: false,
      skipLoadingOnRefresh: false,
      skipLoadingOnReload: false,
      data: (data) {
        usingTables =
            (kTypeOrder == TypeOrderEnum.offline.type ? data.offline : data.online)?.using ?? [];
        orders = List.from(
            (kTypeOrder == TypeOrderEnum.offline.type ? data.offline : data.online)?.userUsing ??
                []);
        allTables = [
          ...((kTypeOrder == TypeOrderEnum.offline.type ? data.offline : data.online)?.notUse ??
              []),
          ...usingTables,
        ];
        orders.sort((a, b) {
          if (a.createdAt == null || b.createdAt == null) return 0;
          return a.createdAt!.compareTo(b.createdAt!);
        });

        final earliest = orders.firstWhereOrNull((e) => e.createdAt != null); // ngày nhỏ nhất
        final latest = orders.lastWhereOrNull((e) => e.createdAt != null);
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            // ref.read(tableLayoutPageProvider.notifier).getHistoryOrder();
            ref
                .read(tableLayoutPageProvider.notifier)
                .onChangeDateHistory(earliest: earliest?.createdAt, latest: latest?.createdAt);
          },
        );
        return const ProcessState(status: StatusEnum.success);
      },
      error: (error, stackTrace) {
        return ProcessState(status: StatusEnum.error, message: error.toString());
      },
      loading: () {
        return const ProcessState(status: StatusEnum.loading);
      },
    );
    // var historyData = ref.watch(todayHistoryOrderProvider);
    // historyState = historyData.when(
    //   data: (data) {
    //     history = List<HistoryOrderModel>.from(data);
    //     return const ProcessState(status: StatusEnum.success);
    //   },
    //   error: (error, stackTrace) =>
    //       ProcessState(status: StatusEnum.error, message: error.toString()),
    //   loading: () => const ProcessState(status: StatusEnum.loading),
    // );

    // showLogs(history, flags: 'history');

    // var reservations = ((reservationsData[date]?['data'] ?? []) as List)
    //     .map((e) => e as ReservationModel)
    //     .toList();
    // reservationState = reservationState.copyWith(
    //   status: (reservationsData[date]?['status'] ?? StatusEnum.normal),
    //   message: (reservationsData[date]?['message'] ?? '').toString(),
    // );

    // WidgetsBinding.instance.addPostFrameCallback(
    //   (timeStamp) {
    //     if (reservationState.status == StatusEnum.normal) {
    //       // ref.read(homeProvider.notifier).fetchReservations(fromDate: date, toDate: date);
    //     }
    //   },
    // );

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: ResponsiveIconButtonWidget(
          iconData: Icons.arrow_back_rounded,
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Layout nhà hàng',
                style: AppTextStyle.bold(
                  rawFontSize: AppConfig.defaultRawTextSize + 1.0,
                  color: Colors.white,
                ),
              ),
            ),
            ResponsiveIconButtonWidget(
              iconData: Icons.settings,
              color: Colors.white,
              onPressed: () async {
                var res = await showModalBottomSheet<
                    ({
                      TableLayoutSettingModel? setting,
                      TableModel? table,
                      FloorModel? floor,
                    })?>(
                  context: context,
                  backgroundColor: Colors.white,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) {
                    return ItemSettingBottomSheet(
                      initSetting: ref.read(tableLayoutPageProvider).itemSetting,
                      title: 'Thiết lập mặc định',
                    );
                  },
                );
                if (res == null) return;
                if (res.setting != null) {
                  ref.read(tableLayoutPageProvider.notifier).onSaveItemSetting(res.setting!);
                }
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                var enableDragLayout =
                    ref.watch(tableLayoutPageProvider.select((value) => value.enableDragLayout));
                return ResponsiveIconButtonWidget(
                  iconData: enableDragLayout ? Icons.save : Icons.edit,
                  color: Colors.white,
                  onPressed: () async {
                    ref.read(tableLayoutPageProvider.notifier).onChangeEnableDragLayout(null);
                  },
                );
              },
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                var floors = ref.watch(tableLayoutPageProvider.select((value) => value.floors));
                var floorSelect =
                    ref.watch(tableLayoutPageProvider.select((value) => value.floorSelect));
                return Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (index == 0 && enableDragLayout) {
                              return InkWell(
                                onTap: () async {
                                  var res = await showConfirmInputDialog(
                                    context,
                                    title: 'Thêm tầng',
                                    hintText: '',
                                    textAction: 'Thêm mới',
                                  );

                                  if ((res ?? '').trim().isNotEmpty) {
                                    await ref
                                        .read(tableLayoutPageProvider.notifier)
                                        .addFloor((res ?? '').trim());
                                  }
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(),
                                  ),
                                  child: Row(
                                    children: [
                                      const ResponsiveIconWidget(iconData: Icons.add),
                                      Text(
                                        'Thêm tầng',
                                        style: AppTextStyle.regular(
                                            rawFontSize: AppConfig.defaultRawTextSize - 0.5),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            var item = floors[index - (enableDragLayout ? 1 : 0)];
                            bool selected = floorSelect == item;
                            return InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                ref
                                    .read(tableLayoutPageProvider.notifier)
                                    .onChangeFloorSelect(item);
                              },
                              onLongPress: () async {
                                if (item.isDefault || !enableDragLayout) return;
                                var res = await showConfirmInputDialog(
                                  context,
                                  title: 'Thay đổi tên từ ${item.name} thành',
                                  hintText: '',
                                  textAction: 'Lưu',
                                  initText: item.name,
                                  validator: (p0) {
                                    if ((p0 ?? '').trim().isEmpty) {
                                      return 'Vui lòng nhập tên để dễ phân biệt';
                                    }
                                    return null;
                                  },
                                );
                                if ((res ?? '').trim().isNotEmpty) {
                                  var fl =
                                      await ref.read(tableLayoutPageProvider.notifier).updateFloor(
                                            item: item,
                                            name: (res ?? '').trim(),
                                            delete: false,
                                          );
                                  if (item == floorSelect) {
                                    ref
                                        .read(tableLayoutPageProvider.notifier)
                                        .onChangeFloorSelect(fl);
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selected ? Colors.blue : null,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: selected ? Colors.blue : Colors.grey),
                                ),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                child: Row(
                                  children: [
                                    Text(
                                      item.name,
                                      style: selected
                                          ? AppTextStyle.bold(
                                              color: Colors.white,
                                              rawFontSize: AppConfig.defaultRawTextSize - 0.5)
                                          : AppTextStyle.regular(
                                              rawFontSize: AppConfig.defaultRawTextSize - 0.5),
                                    ),
                                    if (!item.isDefault && enableDragLayout) ...[
                                      const Gap(4),
                                      const ResponsiveIconWidget(
                                        iconData: Icons.edit,
                                        iconSize: 18,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Gap(8),
                          itemCount: floors.length + (enableDragLayout ? 1 : 0),
                        ),
                      ),
                      Consumer(builder: (context, ref, child) {
                        var setting =
                            ref.watch(tableLayoutPageProvider.select((value) => value.itemSetting));
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: TableColorEnum.values.map(
                            (e) {
                              var color = setting.colorMap[e];

                              return Row(
                                children: [
                                  const Gap(20),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: color ?? e.color,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: color ?? e.borderColor),
                                    ),
                                    height: 12,
                                    width: 12,
                                  ),
                                  const Gap(8),
                                  Text(
                                    e.title,
                                    style: AppTextStyle.regular(
                                      rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              );
                            },
                          ).toList(),
                        );
                      }),
                      const Gap(8),
                    ],
                  ),
                );
              },
            ),
            Expanded(
              child: Container(
                color: const Color(0xFFf9fafc),
                child: Stack(
                  children: [
                    DragTarget<String>(
                      key: _dragTargetKey,
                      onAcceptWithDetails: (details) {
                        final RenderBox dragTargetRenderBox =
                            _dragTargetKey.currentContext!.findRenderObject() as RenderBox;
                        final Offset dragTargetGlobalPosition =
                            dragTargetRenderBox.localToGlobal(Offset.zero);
                        final Offset screenOffset = details.offset - dragTargetGlobalPosition;

                        Matrix4 inverseMatrix;
                        try {
                          inverseMatrix = _controller.value.clone()..invert();
                        } catch (ex) {
                          return;
                        }

                        // Biến đổi ngược
                        final vm.Vector4 localVector = inverseMatrix
                            .transform(vm.Vector4(screenOffset.dx, screenOffset.dy, 0.0, 1.0));
                        final Offset corrected =
                            Offset(localVector.x, localVector.y); // toạ độ thực bên trong
                        ref.read(tableLayoutPageProvider.notifier).addItem(corrected);
                      },
                      builder: (context, candidateData, rejectedData) {
                        return InteractiveViewer(
                          transformationController: _controller,
                          // boundaryMargin: const EdgeInsets.all(double.infinity),
                          boundaryMargin: const EdgeInsets.all(0),
                          constrained: false,
                          minScale: enableDragLayout ? 1.0 : 0.6,
                          maxScale: enableDragLayout ? 1.0 : 2,
                          child: SizedBox(
                            width: _canvasWidth,
                            height: _canvasHeight,
                            child: Consumer(builder: (context, ref, child) {
                              var enableDragLayout = ref.watch(tableLayoutPageProvider
                                  .select((value) => value.enableDragLayout));
                              var itemSetting = ref.watch(
                                  tableLayoutPageProvider.select((value) => value.itemSetting));
                              var data =
                                  ref.watch(tableLayoutPageProvider.select((value) => value.items));
                              var floorSelect = ref.watch(
                                  tableLayoutPageProvider.select((value) => value.floorSelect));
                              var reservationTimeCheck = ref.watch(tableLayoutPageProvider
                                  .select((value) => value.reservationTimeCheck));
                              var fromTime = ref
                                  .watch(tableLayoutPageProvider.select((value) => value.fromTime));
                              var toTime = ref
                                  .watch(tableLayoutPageProvider.select((value) => value.toTime));
                              var date =
                                  ref.watch(tableLayoutPageProvider.select((value) => value.date));
                              var itemDelete = ref.watch(
                                  tableLayoutPageProvider.select((value) => value.itemDelete));

                              List<TableLayoutItemModel> dataView =
                                  data.where((e) => e.floorId == (floorSelect?.id ?? '')).toList();

                              return Stack(
                                clipBehavior: Clip.hardEdge,
                                children: [
                                  CustomPaint(
                                    size: Size(_canvasWidth, _canvasHeight),
                                    painter: _GridPainter(),
                                  ),
                                  for (var item in dataView)
                                    Positioned(
                                      left: item.xPos,
                                      top: item.yPos,
                                      child: Draggable<TableLayoutItemModel>(
                                        maxSimultaneousDrags: enableDragLayout ? null : 0,
                                        data: item,
                                        feedback: Builder(builder: (context) {
                                          var scale = _controller.value.entry(0, 0);
                                          return Transform.scale(
                                            scale: scale,
                                            child: DraggerTableWidget(item: item),
                                          );
                                        }),
                                        onDragUpdate: (details) {
                                          if (anchorOffset == null) {
                                            Offset rawAnchor = details.localPosition;
                                            var currentZoomScale = _controller.value.entry(0, 0);
                                            if (currentZoomScale != 1.0 && currentZoomScale > 0) {
                                              anchorOffset = Offset(
                                                rawAnchor.dx / currentZoomScale,
                                                rawAnchor.dy / currentZoomScale,
                                              );
                                            } else {
                                              anchorOffset = rawAnchor;
                                            }
                                          }

                                          _onDragUpdate(item, details.delta);
                                        },
                                        onDragEnd: (details) {},
                                        childWhenDragging: const SizedBox.shrink(),
                                        child: Consumer(
                                          builder: (context, ref, child) {
                                            var history = ref.watch(tableLayoutPageProvider
                                                .select((value) => value.historyOrder));

                                            showLogs(history, flags: 'history');
                                            return DraggerTableWidget(
                                              history: history,
                                              order: item.table?.id != null
                                                  ? orders.firstWhereOrNull((e) {
                                                      return e.getTableIds.contains(item.table?.id);
                                                    })
                                                  : null,
                                              onTap: (p0) async {
                                                if (!enableDragLayout) {
                                                  var order = orders.firstWhereOrNull((e) {
                                                    return e.getTableIds.contains(item.table?.id);
                                                  });
                                                  if (order == null) return;
                                                  ref
                                                      .read(homeProvider.notifier)
                                                      .changeOrderSelect(order);
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) {
                                                      return DetailOrderBottomSheet();
                                                    },
                                                  );
                                                  return;
                                                }
                                                var res = await showModalBottomSheet<
                                                    ({
                                                      TableLayoutSettingModel? setting,
                                                      TableModel? table,
                                                      FloorModel? floor,
                                                    })?>(
                                                  context: context,
                                                  backgroundColor: Colors.white,
                                                  isScrollControlled: true,
                                                  useSafeArea: true,
                                                  builder: (context) {
                                                    showLogs(item, flags: 'item');
                                                    return ItemSettingBottomSheet(
                                                      initSetting: ref
                                                          .read(tableLayoutPageProvider)
                                                          .itemSetting,
                                                      title: 'Thiết lập',
                                                      item: item,
                                                    );
                                                  },
                                                );
                                                if (res != null) {
                                                  ref
                                                      .read(tableLayoutPageProvider.notifier)
                                                      .onChangeLayoutItem(
                                                        item: item,
                                                        floor: res.floor,
                                                        table: res.table,
                                                        setting: res.setting,
                                                      );
                                                }
                                              },
                                              onLongPress: enableDragLayout
                                                  ? (p0) {
                                                      ref
                                                          .read(tableLayoutPageProvider.notifier)
                                                          .addDeleteItem(p0);
                                                    }
                                                  : null,
                                              item: item,
                                              itemSetting: itemSetting,
                                              reservations: ref
                                                  .read(tableLayoutPageProvider.notifier)
                                                  .getReservationsOfTable(
                                                // reservations: reservations,
                                                reservations: [],
                                                table: item.table,
                                                reservationTimeCheck: reservationTimeCheck,
                                                fromTime: fromTime,
                                                toTime: toTime,
                                                date: date,
                                              ),
                                              isSelect: itemDelete
                                                      .firstWhereOrNull((e) => e.id == item.id) !=
                                                  null,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  Positioned.fill(
                                    child: DragTarget<TableLayoutItemModel>(
                                      key: _dragLocalTargetKey,
                                      onAcceptWithDetails: (details) {
                                        final RenderBox dragTargetRenderBox =
                                            _dragTargetKey.currentContext!.findRenderObject()
                                                as RenderBox;

                                        Offset screenOffset =
                                            dragTargetRenderBox.globalToLocal(details.offset);
                                        final double currentZoomScale =
                                            _controller.value.entry(0, 0);
                                        double feedbackScale = currentZoomScale;
                                        double compensationFactor = feedbackScale - 1.0;
                                        if (anchorOffset != null) {
                                          var compensationVetor = Offset(
                                              (anchorOffset?.dx ?? 0) * compensationFactor,
                                              (anchorOffset?.dy ?? 0) * compensationFactor);
                                          screenOffset = screenOffset - compensationVetor;
                                        }
                                        Matrix4 inverseMatrix;
                                        try {
                                          inverseMatrix = _controller.value.clone()..invert();
                                        } catch (ex) {
                                          return;
                                        }

                                        final vm.Vector4 localVector = inverseMatrix.transform(
                                            vm.Vector4(screenOffset.dx, screenOffset.dy, 0.0, 1.0));
                                        Offset corrected = Offset(localVector.x, localVector.y);
                                        // final double scaleCorrectionFactor =
                                        //     1.0 - (1.0 / currentZoomScale);
                                        // showLogs(scaleCorrectionFactor,
                                        //     flags: 'scaleCorrectionFactor');
                                        // showLogs(corrected, flags: 'corrected');
                                        // showLogs(anchorOffset, flags: 'anchorOffset');
                                        // var doubleCompensationVetor = Offset(
                                        //     anchorOffset!.dx * scaleCorrectionFactor,
                                        //     anchorOffset!.dy * scaleCorrectionFactor);

                                        // // ÁP DỤNG BÙ TRỪ TỈ LỆ VÀO KẾT QUẢ CUỐI CÙNG
                                        // final Offset finalDropPosition =
                                        //     corrected - doubleCompensationVetor;
                                        anchorOffset = null;

                                        ref
                                            .read(tableLayoutPageProvider.notifier)
                                            .updatePosition(details.data, corrected);
                                      },
                                      builder: (_, __, ___) => const SizedBox.expand(),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            // const Divider(height: 2),
            // Container(
            //   height: 110,
            //   color: Colors.grey.shade200,
            //   child: Row(
            //     children: [
            //       if (enableDragLayout) ...[
            //         Draggable<String>(
            //           data: 'chair',
            //           feedback: const Opacity(opacity: 0.7, child: DraggerTableWidget()),
            //           childWhenDragging: const Opacity(opacity: 0.3, child: DraggerTableWidget()),
            //           child: DraggerTableWidget(
            //             item: TableLayoutItemModel(
            //               topChair: 0,
            //               bottomChair: 0,
            //               leftChair: 0,
            //               rightChair: 0,
            //               table: TableModel(id: 0, name: 'Bàn'),
            //               typeOrder: kTypeOrder,
            //             ),
            //           ),
            //         ),
            //         Flexible(
            //           child: SingleChildScrollView(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               mainAxisSize: MainAxisSize.min,
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 const Gap(4),
            //                 Row(
            //                   children: [
            //                     Consumer(
            //                       builder: (context, ref, child) {
            //                         var items = ref.watch(
            //                             tableLayoutPageProvider.select((value) => value.items));
            //                         var exists = items
            //                             .where((e) => e.table != null)
            //                             .map((e) => e.table!.id)
            //                             .toList();
            //                         // bool enable = items.isEmpty && allTables.isNotEmpty;
            //                         var size = MediaQuery.of(context).size;

            //                         var remainTables =
            //                             allTables.where((e) => !exists.contains(e.id)).toList();
            //                         bool enable = remainTables.isNotEmpty;
            //                         return Tooltip(
            //                           message: 'Sắp xếp mặc định',
            //                           child: ResponsiveIconButtonWidget(
            //                             buttonStyle: ButtonStyle(
            //                               backgroundColor: WidgetStatePropertyAll(
            //                                   enable ? Colors.white : Colors.grey.shade100),
            //                               padding: const WidgetStatePropertyAll(EdgeInsets.all(16)),
            //                               shape: WidgetStatePropertyAll(
            //                                 RoundedRectangleBorder(
            //                                   borderRadius: BorderRadius.circular(12),
            //                                 ),
            //                               ),
            //                             ),
            //                             iconData: Icons.auto_awesome_motion_outlined,
            //                             iconSize: 28,
            //                             color: enable ? Colors.black87 : Colors.grey.shade400,
            //                             onPressed: () {
            //                               if (!enable) return;
            //                               ref
            //                                   .read(tableLayoutPageProvider.notifier)
            //                                   .generateDefaultTable(
            //                                     tables: remainTables,
            //                                     viewportWidth: 4000,
            //                                     viewportHeight: size.height,
            //                                   );
            //                             },
            //                           ),
            //                         );
            //                       },
            //                     ),
            //                     const Gap(12),
            //                     Consumer(
            //                       builder: (context, ref, child) {
            //                         var items = ref.watch(
            //                             tableLayoutPageProvider.select((value) => value.items));
            //                         var enableDragLayout = ref.watch(tableLayoutPageProvider
            //                             .select((value) => value.enableDragLayout));
            //                         if (!enableDragLayout) return const SizedBox.shrink();
            //                         bool disable = items.isEmpty;

            //                         return DragTarget<TableLayoutItemModel>(
            //                           onAcceptWithDetails: (details) {
            //                             if (disable) return;
            //                             ref
            //                                 .read(tableLayoutPageProvider.notifier)
            //                                 .removeItem(details.data);
            //                           },
            //                           builder: (_, __, ___) => Tooltip(
            //                             message: 'Kéo bàn muốn xoá vào đây',
            //                             child: ResponsiveIconButtonWidget(
            //                               buttonStyle: ButtonStyle(
            //                                 backgroundColor: WidgetStatePropertyAll(
            //                                     disable ? Colors.grey.shade100 : Colors.white),
            //                                 padding:
            //                                     const WidgetStatePropertyAll(EdgeInsets.all(16)),
            //                                 shape: WidgetStatePropertyAll(
            //                                   RoundedRectangleBorder(
            //                                     borderRadius: BorderRadius.circular(12),
            //                                   ),
            //                                 ),
            //                               ),
            //                               iconData: Icons.delete,
            //                               iconSize: 28,
            //                               color: disable ? Colors.grey.shade400 : Colors.black87,
            //                               onPressed: () {
            //                                 showConfirmAction(
            //                                   context,
            //                                   message: 'Bạn có chắc chắn muốn xoá các bàn đã chọn?',
            //                                   action: () {
            //                                     ref
            //                                         .read(tableLayoutPageProvider.notifier)
            //                                         .onDeleteMulti();
            //                                   },
            //                                 );
            //                               },
            //                             ),
            //                           ),
            //                         );
            //                       },
            //                     ),
            //                     const Gap(20),
            //                     Consumer(
            //                       builder: (context, ref, child) {
            //                         var floorSelect = ref.watch(tableLayoutPageProvider
            //                             .select((value) => value.floorSelect));
            //                         return Row(
            //                           mainAxisSize: MainAxisSize.min,
            //                           children: [
            //                             Text(
            //                               'Tầng',
            //                               style: AppTextStyle.bold(
            //                                 rawFontSize: AppConfig.defaultRawTextSize - 1.0,
            //                               ),
            //                             ),
            //                             const Gap(12),
            //                             SizedBox(
            //                               width: 200,
            //                               child: FloorDropdownWidget(
            //                                 backgroundColor: Colors.white,
            //                                 floorInit: floorSelect,
            //                                 onChangeFloor: ref
            //                                     .read(tableLayoutPageProvider.notifier)
            //                                     .onChangeFloorSelect,
            //                               ),
            //                             ),
            //                           ],
            //                         );
            //                       },
            //                     ),
            //                     const Gap(12),
            //                     Consumer(
            //                       builder: (context, ref, child) {
            //                         var items = ref.watch(
            //                             tableLayoutPageProvider.select((value) => value.items));
            //                         if (items.isEmpty) return const SizedBox.shrink();
            //                         return AppCheckbox(
            //                           onChange: () {
            //                             showConfirmAction(
            //                               context,
            //                               message: 'Bạn có chắc chắn muốn xoá tất cả các bàn?',
            //                               action: () {
            //                                 ref
            //                                     .read(tableLayoutPageProvider.notifier)
            //                                     .onDeleteAll();
            //                               },
            //                             );
            //                           },
            //                           text: 'Xoá tất cả',
            //                         );
            //                       },
            //                     )
            //                   ],
            //                 ),
            //                 Row(
            //                   children: [
            //                     Text(
            //                       'Lưu ý: Với nút "Sắp xếp mặc định"',
            //                       style: AppTextStyle.regular(
            //                         rawFontSize: AppConfig.defaultRawTextSize - 1.5,
            //                         color: Colors.blue,
            //                       ),
            //                     ),
            //                     ResponsiveIconButtonWidget(
            //                       buttonStyle: ButtonStyle(
            //                         backgroundColor: const WidgetStatePropertyAll(Colors.white),
            //                         padding: const WidgetStatePropertyAll(EdgeInsets.all(2)),
            //                         shape: WidgetStatePropertyAll(
            //                           RoundedRectangleBorder(
            //                             borderRadius: BorderRadius.circular(12),
            //                           ),
            //                         ),
            //                       ),
            //                       iconData: Icons.auto_awesome_motion_outlined,
            //                       iconSize: 12,
            //                       color: Colors.black87,
            //                     ),
            //                     Expanded(
            //                       child: Text(
            //                         ' sẽ chỉ thêm những bàn chưa có trong bố cục, các bàn thêm có thể sẽ ghi đè lên vị trí các bàn đã có!',
            //                         style: AppTextStyle.regular(
            //                           rawFontSize: AppConfig.defaultRawTextSize - 1.5,
            //                           color: Colors.blue,
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 const Gap(2),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //       if (!enableDragLayout) ...[
            //         const Gap(20),
            //         Consumer(
            //           builder: (context, ref, child) {
            //             var floorSelect =
            //                 ref.watch(tableLayoutPageProvider.select((value) => value.floorSelect));
            //             return Column(
            //               mainAxisSize: MainAxisSize.min,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   'Tầng',
            //                   style: AppTextStyle.bold(
            //                     rawFontSize: AppConfig.defaultRawTextSize - 1.0,
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   width: 200,
            //                   child: FloorDropdownWidget(
            //                     backgroundColor: Colors.white,
            //                     floorInit: floorSelect,
            //                     onChangeFloor:
            //                         ref.read(tableLayoutPageProvider.notifier).onChangeFloorSelect,
            //                   ),
            //                 ),
            //               ],
            //             );
            //           },
            //         ),
            //         const Gap(12),
            //         const Spacer(),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.end,
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             const Gap(12),
            //             Row(
            //               children: [
            //                 // Consumer(
            //                 //   builder: (context, ref, child) {
            //                 //     var date = ref
            //                 //         .watch(tableLayoutPageProvider.select((value) => value.date));

            //                 //     return GestureDetector(
            //                 //       onTap: () async {
            //                 //         var dateChange = await showDatePickerDialog(
            //                 //           context,
            //                 //           calendarType: CalendarDatePicker2Type.single,
            //                 //           value: [date],
            //                 //           dialogSize: const Size(500, 450),
            //                 //         );
            //                 //         if ((dateChange ?? []).isNotEmpty &&
            //                 //             dateChange!.first != null) {
            //                 //           ref
            //                 //               .read(tableLayoutPageProvider.notifier)
            //                 //               .onChangeDate(dateChange.first!);
            //                 //         }
            //                 //       },
            //                 //       child: Container(
            //                 //         padding:
            //                 //             const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            //                 //         decoration: BoxDecoration(
            //                 //           color: Colors.white,
            //                 //           borderRadius: BorderRadius.circular(4),
            //                 //         ),
            //                 //         child: Row(
            //                 //           children: [
            //                 //             const ResponsiveIconWidget(
            //                 //                 iconData: Icons.calendar_month,
            //                 //                 color: AppColors.textColor),
            //                 //             const Gap(4),
            //                 //             Text(
            //                 //               DateTimeUtils.formatToString(
            //                 //                   time: date, newPattern: DateTimePatterns.date),
            //                 //               style: AppTextStyle.regular(),
            //                 //             ),
            //                 //           ],
            //                 //         ),
            //                 //       ),
            //                 //     );
            //                 //   },
            //                 // ),
            //                 // const Gap(8),
            //                 // Consumer(
            //                 //   builder: (context, ref, child) {
            //                 //     var fromTime = ref.watch(
            //                 //         tableLayoutPageProvider.select((value) => value.fromTime));
            //                 //     var toTime = ref
            //                 //         .watch(tableLayoutPageProvider.select((value) => value.toTime));

            //                 //     return GestureDetector(
            //                 //       onTap: () async {
            //                 //         var from = await showTimePicker(
            //                 //           context: context,
            //                 //           initialTime: fromTime,
            //                 //           helpText: 'Bắt đầu',
            //                 //         );
            //                 //         if (from != null) {
            //                 //           var to = await showTimePicker(
            //                 //             context: context,
            //                 //             initialTime: toTime,
            //                 //             helpText: 'Kết thúc',
            //                 //           );
            //                 //           if (to != null) {
            //                 //             var today = DateTime.now().date;
            //                 //             var fromDateTime = DateTimeUtils.parseDateTimeFromTimeOfDay(
            //                 //                 date: today, timeOfDay: from);
            //                 //             var toDateTime = DateTimeUtils.parseDateTimeFromTimeOfDay(
            //                 //                 date: today, timeOfDay: to);
            //                 //             if (!toDateTime.isAfter(fromDateTime)) {
            //                 //               toDateTime =
            //                 //                   fromDateTime.add(const Duration(minutes: 120));
            //                 //               var endDate =
            //                 //                   today.add(const Duration(hours: 23, minutes: 59));
            //                 //               if (toDateTime.isAfter(endDate)) {
            //                 //                 toDateTime = endDate;
            //                 //               }
            //                 //             }

            //                 //             to = TimeOfDay(
            //                 //                 hour: toDateTime.hour, minute: toDateTime.minute);

            //                 //             ref
            //                 //                 .read(tableLayoutPageProvider.notifier)
            //                 //                 .onChangeTime(from: from, to: to);
            //                 //           }
            //                 //         }
            //                 //       },
            //                 //       child: Container(
            //                 //         padding:
            //                 //             const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            //                 //         decoration: BoxDecoration(
            //                 //           color: Colors.white,
            //                 //           borderRadius: BorderRadius.circular(4),
            //                 //         ),
            //                 //         child: Row(
            //                 //           children: [
            //                 //             const ResponsiveIconWidget(
            //                 //                 iconData: Icons.access_time_sharp,
            //                 //                 color: AppColors.textColor),
            //                 //             const Gap(4),
            //                 //             Text(
            //                 //               '${fromTime.format(context)} - ${toTime.format(context)}',
            //                 //               style: AppTextStyle.regular(),
            //                 //             ),
            //                 //           ],
            //                 //         ),
            //                 //       ),
            //                 //     );
            //                 //   },
            //                 // ),

            //                 const Gap(8),
            //                 Consumer(builder: (context, ref, child) {
            //                   var setting = ref.watch(
            //                       tableLayoutPageProvider.select((value) => value.itemSetting));
            //                   return Row(
            //                     mainAxisSize: MainAxisSize.min,
            //                     children: TableColorEnum.values.map(
            //                       (e) {
            //                         var color = setting.colorMap[e];

            //                         return Row(
            //                           children: [
            //                             const Gap(20),
            //                             Container(
            //                               decoration: BoxDecoration(
            //                                 color: color ?? e.color,
            //                                 shape: BoxShape.circle,
            //                                 border: Border.all(color: color ?? e.borderColor),
            //                               ),
            //                               height: 12,
            //                               width: 12,
            //                             ),
            //                             const Gap(8),
            //                             Text(
            //                               e.title,
            //                               style: AppTextStyle.regular(
            //                                 rawFontSize: AppConfig.defaultRawTextSize - 1.0,
            //                               ),
            //                               maxLines: 1,
            //                               overflow: TextOverflow.ellipsis,
            //                             ),
            //                           ],
            //                         );
            //                       },
            //                     ).toList(),
            //                   );
            //                 }),
            //                 const Gap(8),
            //               ],
            //             ),
            //             const Gap(12),
            //             // if ([
            //             //   StatusEnum.loading,
            //             //   StatusEnum.error,
            //             // ].contains(reservationState.status)) ...[
            //             //   switch (reservationState.status) {
            //             //     StatusEnum.normal => const SizedBox.shrink(),
            //             //     StatusEnum.success => const SizedBox.shrink(),
            //             //     StatusEnum.loading => Row(
            //             //         children: [
            //             //           CupertinoActivityIndicator(color: AppColors.blue),
            //             //           const Gap(4),
            //             //           Text(
            //             //             'Đang làm mới dữ liệu đặt bàn...',
            //             //             style: AppTextStyle.regular(
            //             //               color: AppColors.blue,
            //             //               rawFontSize: AppConfig.defaultRawTextSize - 1.0,
            //             //             ),
            //             //           ),
            //             //         ],
            //             //       ),
            //             //     StatusEnum.error => GestureDetector(
            //             //         onTap: () {
            //             //           // ref
            //             //           //     .read(homeProvider.notifier)
            //             //           //     .fetchReservations(fromDate: date, toDate: date);
            //             //         },
            //             //         child: Row(
            //             //           children: [
            //             //             ResponsiveIconWidget(
            //             //               iconData: Icons.info_outline,
            //             //               color: AppColors.redColor,
            //             //             ),
            //             //             const Gap(4),
            //             //             Text(
            //             //               'Thông tin bàn đặt không được cập nhật. Sự cố: ${reservationState.message}',
            //             //               style: AppTextStyle.regular(
            //             //                 color: AppColors.redColor,
            //             //                 rawFontSize: AppConfig.defaultRawTextSize - 1.0,
            //             //               ),
            //             //               maxLines: 2,
            //             //               overflow: TextOverflow.ellipsis,
            //             //             ),
            //             //           ],
            //             //         ),
            //             //       ),
            //             //   }
            //             // ],
            //             if ([
            //               StatusEnum.loading,
            //               StatusEnum.error,
            //             ].contains(tableState.status)) ...[
            //               switch (tableState.status) {
            //                 StatusEnum.normal => const SizedBox.shrink(),
            //                 StatusEnum.success => const SizedBox.shrink(),
            //                 StatusEnum.loading => allTables.isEmpty
            //                     ? Row(
            //                         children: [
            //                           CupertinoActivityIndicator(color: AppColors.blue),
            //                           const Gap(4),
            //                           Text(
            //                             'Đang làm mới dữ liệu bàn...',
            //                             style: AppTextStyle.regular(
            //                               color: AppColors.blue,
            //                               rawFontSize: AppConfig.defaultRawTextSize - 1.0,
            //                             ),
            //                           ),
            //                         ],
            //                       )
            //                     : const SizedBox.shrink(),
            //                 StatusEnum.error => GestureDetector(
            //                     onTap: () {
            //                       ref.refresh(tablesAndOrdersProvider);
            //                     },
            //                     child: Row(
            //                       children: [
            //                         const ResponsiveIconWidget(
            //                           iconData: Icons.info_outline,
            //                           color: AppColors.redColor,
            //                         ),
            //                         const Gap(4),
            //                         Text(
            //                           'Trạng thái bàn không được cập nhật.\nSự cố: ${tableState.message}',
            //                           style: AppTextStyle.regular(
            //                             color: AppColors.redColor,
            //                             rawFontSize: AppConfig.defaultRawTextSize - 1.0,
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //               }
            //             ],
            //           ],
            //         ),
            //       ] else
            //         const Gap(20),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _onDragUpdate(TableLayoutItemModel item, Offset delta) {
    setState(() {
      var offset = Offset(item.xPos, item.yPos);
      offset += delta;

      final pos = offset;
      if (pos.dx > _canvasWidth - _expandThreshold) {
        _canvasWidth += _expandStep;
      }
      if (pos.dy > _canvasHeight - _expandThreshold) {
        _canvasHeight += _expandStep;
      }
      if (pos.dx < _expandThreshold) {
        _canvasWidth += _expandStep;
      }
      if (pos.dy < _expandThreshold) {
        _canvasHeight += _expandStep;
      }
    });
  }
}

class DetailOrderBottomSheet extends ConsumerStatefulWidget {
  const DetailOrderBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailOrderBottomSheetState();
}

class _DetailOrderBottomSheetState extends ConsumerState<DetailOrderBottomSheet> {
  ItemScrollController? itemScrollController;
  ItemPositionsListener? itemPositionsListener;

  ItemScrollController? itemSelectingScrollController;
  ItemPositionsListener? itemSelectingPositionsListener;

  @override
  void initState() {
    super.initState();
    itemScrollController = ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();
    itemSelectingScrollController = ItemScrollController();
    itemSelectingPositionsListener = ItemPositionsListener.create();
  }

  @override
  Widget build(BuildContext context) {
    return OrderItemsWidget(
      priceSidebar: true,
      itemPositionsListener: itemPositionsListener,
      itemScrollController: itemScrollController,
      itemSelectingPositionsListener: itemSelectingPositionsListener,
      itemSelectingScrollController: itemSelectingScrollController,
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.15)
      ..strokeWidth = 1;
    const gridSize = 50.0;

    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

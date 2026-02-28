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
import 'package:aladdin_franchise/src/features/dialogs/order/create_new/view.dart';
import 'package:aladdin_franchise/src/features/pages/cart/widgets/order_items_widget.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/table_layout/widgets/floor_tab_view.dart';
// import 'package:aladdin_franchise/src/features/pages/table_layout_new/widgets/barrel_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/widgets/date_picker_dialog.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/history_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
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
import 'widgets/barrel_widget.dart';
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
      tableLayoutPageProvider.select((value) => value.isLayoutEditMode),
      _listenEvent(context, ref),
    );

    bool editMode = ref.watch(tableLayoutPageProvider.select((value) => value.isLayoutEditMode));
    var itemSelect = ref.watch(tableLayoutPageProvider.select((value) => value.itemSelect));
    var items = ref.watch(tableLayoutPageProvider.select((value) => value.items));
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

        final earliest = orders.firstWhereOrNull((e) => e.createdAt != null);
        final latest = orders.lastWhereOrNull((e) => e.createdAt != null);
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            ref
                .read(tableLayoutPageProvider.notifier)
                .getOrderHistory(from: earliest?.createdAt, to: latest?.createdAt);
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
                  ref
                      .read(tableLayoutPageProvider.notifier)
                      .onSaveDefaultLayoutItemSetting(res.setting!);
                }
              },
            ),
            ResponsiveIconButtonWidget(
              iconData: editMode ? Icons.save : Icons.edit,
              color: Colors.white,
              onPressed: () async {
                ref.read(tableLayoutPageProvider.notifier).onChangeEditMode();
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(child: FloorTabView()),
                        ],
                      ),
                    ),
                    StatusIndicator(),
                  ],
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xFFf9fafc),
                    child: DragTarget<String>(
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
                        ref.read(tableLayoutPageProvider.notifier).addLayoutItem(corrected);
                      },
                      builder: (context, candidateData, rejectedData) {
                        return InteractiveViewer(
                          transformationController: _controller,
                          // boundaryMargin: const EdgeInsets.all(double.infinity),
                          boundaryMargin: const EdgeInsets.all(0),
                          constrained: false,
                          minScale: editMode ? 1.0 : 0.6,
                          maxScale: editMode ? 1.0 : 2,
                          child: SizedBox(
                            width: _canvasWidth,
                            height: _canvasHeight,
                            child: Consumer(builder: (context, ref, child) {
                              // var itemSetting = ref.watch(
                              //     tableLayoutPageProvider.select((value) => value.itemSetting));
                              var data =
                                  ref.watch(tableLayoutPageProvider.select((value) => value.items));
                              var floorSelect = ref.watch(
                                  tableLayoutPageProvider.select((value) => value.floorSelect));
                              // var reservationTimeCheck = ref.watch(tableLayoutPageProvider
                              //     .select((value) => value.reservationTimeCheck));
                              // var fromTime = ref
                              //     .watch(tableLayoutPageProvider.select((value) => value.fromTime));
                              // var toTime = ref
                              //     .watch(tableLayoutPageProvider.select((value) => value.toTime));
                              // var date =
                              //     ref.watch(tableLayoutPageProvider.select((value) => value.date));

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
                                      child: Consumer(builder: (context, ref, child) {
                                        List<HistoryOrderModel> history = ref.watch(
                                            tableLayoutPageProvider
                                                .select((value) => value.historyOrder));

                                        var order = orders.firstWhereOrNull((e) {
                                          return e.getTableIds.contains(item.table?.id);
                                        });
                                        var draggerItem = DraggerTableWidget(
                                          history: history,
                                          order: order,
                                          onTap: (p0) async {
                                            ref
                                                .read(tableLayoutPageProvider.notifier)
                                                .onChangeItemSelect(p0.id);
                                          },
                                          onLongPress: (p0) {
                                            if (editMode) return;
                                            if (order == null) return;
                                            ref
                                                .read(homeProvider.notifier)
                                                .changeOrderSelect(order);
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return const DetailOrderBottomSheet();
                                              },
                                            );
                                          },
                                          item: item,
                                          // itemSetting: itemSetting,
                                          // reservations: ref
                                          //     .read(tableLayoutPageProvider.notifier)
                                          //     .getReservationsOfTable(
                                          //   // reservations: reservations,
                                          //   reservations: [],
                                          //   table: item.table,
                                          //   reservationTimeCheck: reservationTimeCheck,
                                          //   fromTime: fromTime,
                                          //   toTime: toTime,
                                          //   date: date,
                                          // ),
                                          selected:
                                              itemSelect.firstWhereOrNull((e) => e == item.id) !=
                                                  null,
                                        );

                                        return Draggable<TableLayoutItemModel>(
                                          maxSimultaneousDrags: editMode ? null : 0,
                                          data: item,
                                          feedback: Builder(builder: (context) {
                                            var scale = _controller.value.entry(0, 0);
                                            return Transform.scale(
                                              scale: scale,
                                              child: draggerItem,
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
                                          child: draggerItem,
                                        );
                                      }),
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

                                        anchorOffset = null;

                                        ref
                                            .read(tableLayoutPageProvider.notifier)
                                            .updateItemPosition(details.data.id, corrected);
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
                  ),
                ),
              ],
            ),
            if (editMode) ...[
              const Positioned(
                bottom: 80,
                right: 10,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BtnSettingLayoutItem(),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 2,
                child: Draggable<String>(
                  data: 'chair',
                  feedback: const Opacity(opacity: 0.7, child: DraggerTableWidget()),
                  childWhenDragging: const Opacity(opacity: 0.3, child: DraggerTableWidget()),
                  child: DraggerTableWidget(
                    size: const Size(80, 80),
                    item: TableLayoutItemModel(
                      topChair: 0,
                      bottomChair: 0,
                      leftChair: 0,
                      rightChair: 0,
                      table: const TableModel(id: 0, name: ''),
                      typeOrder: kTypeOrder,
                    ),
                  ),
                ),
              ),
            ] else ...[
              Consumer(builder: (context, ref, child) {
                final selectedIds = itemSelect.toSet();
                final tableIds = <int>{};

                for (final e in items) {
                  if (selectedIds.contains(e.id)) {
                    final tableId = e.table?.id;
                    if (tableId != null) {
                      tableIds.add(tableId);
                    }
                  }
                }
                if (tableIds.isEmpty && selectedIds.length > 1) {
                  return const SizedBox.shrink();
                }
                return Positioned(
                  bottom: 10,
                  right: 10,
                  child: Column(
                    children: [
                      const BtnSettingLayoutItem(),
                      BtnArrangeDefaultLayout(
                        allTables: allTables,
                      ),
                      const BtnDeleteLayoutItem(),
                      BtnCreateNewOrder(tableIdInit: tableIds),
                    ],
                  ),
                );
              }),
            ],
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

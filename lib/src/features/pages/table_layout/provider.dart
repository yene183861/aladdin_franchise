import 'dart:math';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/model/floor.dart';
import 'package:aladdin_franchise/src/data/model/table_layout_item.dart';
import 'package:aladdin_franchise/src/data/model/table_layout_setting.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/models/restaurant.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

final tableLayoutPageProvider =
    StateNotifierProvider.autoDispose<TableLayoutPageNotifier, TableLayoutPageState>((ref) {
  return TableLayoutPageNotifier(ref);
});

class TableLayoutPageNotifier extends StateNotifier<TableLayoutPageState> {
  TableLayoutPageNotifier(this.ref)
      : super(TableLayoutPageState(
          date: DateTime.now().onlyDate(),
          fromTime: const TimeOfDay(hour: 10, minute: 0),
          toTime: const TimeOfDay(hour: 12, minute: 0),
        )) {
    var now = DateTime.now();
    var today = now.onlyDate();
    var fromTime = now.copyWith(second: 0);
    if (!fromTime.checkInRangeTime(start: today, end: today, onlyDate: true)) {
      fromTime = today;
    }
    var toTime = fromTime.add(const Duration(minutes: 120));
    if (!toTime.checkInRangeTime(start: today, end: today, onlyDate: true)) {
      toTime = today.copyWith(hour: 23, minute: 59);
    }
    state = state.copyWith(
      fromTime: TimeOfDay(hour: fromTime.hour, minute: fromTime.minute),
      toTime: TimeOfDay(hour: toTime.hour, minute: toTime.minute),
    );
  }

  final Ref ref;
  RestaurantModel? restaurant;

  void init() async {
    restaurant = LocalStorage.getDataLogin()?.restaurant;
    var floors = List<FloorModel>.from(
        LocalStorage.getFloors().where((e) => e.restaurantId == restaurant?.id).toList());
    FloorModel? floorSelect;

    FloorModel? floorDefault = floors.firstWhereOrNull((e) => e.isDefault);
    if (floorDefault == null) {
      floorDefault = FloorModel(
        id: DateTimeUtils.formatToString(
          time: DateTime.now(),
          newPattern: DateTimePatterns.dateTime3,
        ),
        name: 'Tầng 1',
        restaurantId: restaurant?.id ?? -1,
        isDefault: true,
      );
      floors.insert(0, floorDefault);
      state = state.copyWith(floors: floors);
      await _saveFloors();
    }
    floorSelect = floors.firstOrNull;
    state = state.copyWith(
      floors: floors,
      floorSelect: floorSelect,
    );
    var item =
        LocalStorage.getTableLayout().where((e) => e.restaurantId == restaurant?.id).toList();

    List<TableLayoutItemModel> items = [];
    for (var e in item) {
      if (e.typeOrder == kTypeOrder) {
        if (e.floorId.trim().isEmpty) {
          items.add(e.copyWith(floorId: floorDefault.id));
        } else {
          items.add(e);
        }
      }
    }

    var setting = LocalStorage.getTableLayoutSetting()
        .where((e) => e.restaurantId == restaurant?.id)
        .toList();

    state = state.copyWith(
      items: items,
      itemSetting: setting.isEmpty
          ? TableLayoutSettingModel(restaurantId: restaurant?.id ?? -1)
          : setting.first,
    );
    await saveLayout();
    await _saveSetting();
  }

  void addItem(Offset position) {
    var items = List<TableLayoutItemModel>.from(state.items);
    var setting = state.itemSetting;
    var newItem = TableLayoutItemModel(
      xPos: position.dx,
      yPos: position.dy,
      topChair: setting.topChairs,
      bottomChair: setting.bottomChairs,
      leftChair: setting.leftChairs,
      rightChair: setting.rightChairs,
      id: DateTimeUtils.formatToString(
        time: DateTime.now(),
        newPattern: DateTimePatterns.dateTime3,
      ),
      floorId: state.floorSelect?.id ?? '',
      restaurantId: restaurant?.id ?? -1,
      typeOrder: kTypeOrder,
    );
    items.add(newItem);
    state = state.copyWith(items: items);
    saveLayout();
    // onChangeItemSelect(newItem);
  }

  void updatePosition(TableLayoutItemModel item, Offset offset) {
    try {
      var data = List<TableLayoutItemModel>.from(state.items);
      if (data.isEmpty) return;
      var index = data.indexWhere((element) => element.id == item.id);
      if (index == -1) return;
      try {
        data.removeAt(index);
      } catch (ex) {
        //
      }
      data.add(item.copyWith(xPos: offset.dx, yPos: offset.dy));
      state = state.copyWith(items: data);
    } catch (ex) {
      //
    }
    saveLayout();
  }

  Future<void> saveLayout() async {
    try {
      var settings = List<TableLayoutItemModel>.from(LocalStorage.getTableLayout());
      settings.removeWhere((e) => e.restaurantId == restaurant?.id);
      settings.addAll(state.items);
      await LocalStorage.setTableLayout(settings);
    } catch (ex) {
      showLogs(ex, flags: 'saveLayout error');
    }
  }

  void generateDefaultTable({
    List<TableModel> tables = const [],
    double viewportWidth = 0.0,
    double viewportHeight = 0.0,
  }) {
    if (tables.isEmpty) return;
    if (viewportWidth < 0 && viewportHeight < 0) return;
    List<TableLayoutItemModel> items = List<TableLayoutItemModel>.from(state.items);
    var setting = state.itemSetting;
    double xPos = 10.0;
    double yPos = 10.0;
    var padding = 4.0;

    /// số ghế hàng ngang tối đa (top/ bottom)
    int maxHorizontalChair = max(setting.topChairs, setting.bottomChairs);

    /// số ghế hàng dọc tối đa (left/ right)
    int maxVerticalChair = max(setting.leftChairs, setting.rightChairs);

    /// chiều cao của bàn
    double tableHeight = max(
        setting.minTableHeight,
        maxVerticalChair > 0
            ? maxVerticalChair * setting.chairWidth +
                setting.chairToChairSpacing * (maxVerticalChair - 1) +
                setting.tableEdge * 2
            : 0.0);

    /// chiều rộng của bàn
    double tableWidth = max(
        setting.minTableWidth,
        maxHorizontalChair > 0
            ? maxHorizontalChair * setting.chairWidth +
                setting.chairToChairSpacing * (maxHorizontalChair - 1) +
                setting.tableEdge * 2
            : 0.0);
    double totalWidgetHeight =
        (tableHeight + (setting.chairHeight + setting.chairToTableSpacing) * 2) + padding * 2;
    double totalWidgetWidth =
        (tableWidth + (setting.chairHeight + setting.chairToTableSpacing) * 2) + padding * 2;

    var time = DateTime.now();
    for (var table in tables) {
      if ((xPos + totalWidgetWidth) > viewportWidth) {
        xPos = 10;
        yPos += totalWidgetHeight + 30.0;
      }
      var newItem = TableLayoutItemModel(
        table: table,
        xPos: xPos,
        yPos: yPos,
        id: DateTimeUtils.formatToString(
          time: time,
          newPattern: DateTimePatterns.dateTime3,
        ),
        restaurantId: restaurant?.id ?? -1,
        floorId: state.floorSelect?.id ?? '',
        typeOrder: kTypeOrder,
      );
      xPos += totalWidgetWidth + 30;

      items.add(newItem);
      time = time.add(const Duration(milliseconds: 10));
    }

    state = state.copyWith(items: items);
    saveLayout();
  }

  void removeItem(TableLayoutItemModel item) {
    var data = List<TableLayoutItemModel>.from(state.items);
    data.removeWhere((element) => element.id == item.id);
    state = state.copyWith(items: data);
    saveLayout();
  }

  void onSaveItemSetting(TableLayoutSettingModel setting) async {
    state = state.copyWith(itemSetting: setting);
    await _saveSetting();
  }

  Future<void> _saveSetting() async {
    try {
      var settings = List<TableLayoutSettingModel>.from(LocalStorage.getTableLayoutSetting());
      settings.removeWhere((e) => e.restaurantId == restaurant?.id);
      settings.add(state.itemSetting);
      await LocalStorage.setTableLayoutSetting(settings);
    } catch (ex) {
      showLogs(ex, flags: '_saveSetting error');
    }
  }

  Future<FloorModel> addFloor(String name) async {
    var floors = List<FloorModel>.from(state.floors);
    var item = FloorModel(
      id: DateTimeUtils.formatToString(
        time: DateTime.now(),
        newPattern: DateTimePatterns.dateTime3,
      ),
      name: name,
      restaurantId: restaurant?.id ?? -1,
    );
    floors.add(item);
    state = state.copyWith(floors: floors);
    await _saveFloors();
    return item;
  }

  Future<FloorModel> updateFloor({
    required FloorModel item,
    String name = '',
    bool delete = false,
  }) async {
    var floors = List<FloorModel>.from(state.floors);
    var result = item;
    if (delete) {
      floors.removeWhere((e) => e.id == item.id);

      var layoutItems = List<TableLayoutItemModel>.from(state.items);
      List<TableLayoutItemModel> items = [];
      for (var item in layoutItems) {
        var floorDefault = floors.firstWhereOrNull((e) => e.isDefault);
        items.add(item.copyWith(floorId: floorDefault?.id ?? ''));
      }
      state = state.copyWith(items: items);
      await saveLayout();
    } else {
      var index = floors.indexOf(item);
      if (index != -1) {
        result = result.copyWith(name: name);
        floors[index] = result;
      }
    }

    var floorSelect = floors.firstWhereOrNull((e) => e.id == state.floorSelect?.id);
    state = state.copyWith(floors: floors, floorSelect: floorSelect);
    await _saveFloors();
    return result;
  }

  Future<void> _saveFloors() async {
    try {
      var floors = List<FloorModel>.from(LocalStorage.getFloors());
      floors.removeWhere((e) => e.restaurantId == restaurant?.id);
      floors.addAll(state.floors);

      await LocalStorage.setFloors(state.floors);
    } catch (ex) {
      showLogs(ex, flags: '_saveFloors ex');
    }
  }

  void onChangeLayoutItem({
    required TableLayoutItemModel item,
    TableModel? table,
    FloorModel? floor,
    TableLayoutSettingModel? setting,
  }) async {
    var items = List<TableLayoutItemModel>.from(state.items);
    var index = items.indexWhere((e) => e.id == item.id);
    if (index == -1) return;
    var itemChange = items[index];
    items[index] = item.copyWith(
      table: table,
      floorId: floor?.id ?? '',
      topChair: setting?.topChairs ?? itemChange.topChair,
      bottomChair: setting?.bottomChairs ?? itemChange.bottomChair,
      leftChair: setting?.leftChairs ?? itemChange.leftChair,
      rightChair: setting?.rightChairs ?? itemChange.rightChair,
    );

    state = state.copyWith(items: items);
    await saveLayout();
  }

  void onChangeFloorSelect(FloorModel? value) {
    state = state.copyWith(floorSelect: value);
  }

  List<ReservationModel> getReservationsOfTable({
    List<ReservationModel> reservations = const [],
    TableModel? table,
    int? reservationTimeCheck,
    TimeOfDay? fromTime,
    TimeOfDay? toTime,
    DateTime? date,
  }) {
    return reservations
        .where(
          (e) =>
              [
                ReservationStatus.pending,
                ReservationStatus.accept,
                ReservationStatus.process,
              ].contains(e.reservationStatus) &&
              (e.tableId ?? []).contains(table?.id) &&
              e.startDateTime.checkInRangeTime(start: startDateTime(), end: endDateTime()),
        )
        .toList();
  }

  void onChangeReservationTimeCheck(int minutes) {
    state = state.copyWith(reservationTimeCheck: minutes);
  }

  void onChangeTime({
    required TimeOfDay from,
    required TimeOfDay to,
  }) {
    state = state.copyWith(fromTime: from, toTime: to);
  }

  void onChangeDate(DateTime date) {
    state = state.copyWith(date: date.onlyDate());
  }

  DateTime startDateTime([TimeOfDay? start]) => state.date
      .onlyDate()
      .copyWith(hour: (start ?? state.fromTime).hour, minute: (start ?? state.fromTime).minute);
  DateTime endDateTime([TimeOfDay? end]) => state.date
      .onlyDate()
      .copyWith(hour: (end ?? state.toTime).hour, minute: (end ?? state.toTime).minute);

  void onChangeEnableDragLayout(bool? value) {
    state = state.copyWith(enableDragLayout: value ?? !state.enableDragLayout);
  }

  void onDeleteMulti() {
    var delete = state.itemDelete;
    if (delete.isEmpty) return;
    var ids = delete.map((e) => e.id).toList();
    var data = List<TableLayoutItemModel>.from(state.items);
    data.removeWhere((element) => ids.contains(element.id));
    state = state.copyWith(
      items: data,
      itemDelete: [],
    );
    saveLayout();
  }

  void addDeleteItem(TableLayoutItemModel item) {
    var delete = List<TableLayoutItemModel>.from(state.itemDelete);
    var check = delete.firstWhereOrNull((e) => e.id == item.id);
    if (check != null) {
      delete.remove(check);
    } else {
      delete.add(item);
    }
    state = state.copyWith(itemDelete: delete);
  }

  void onDeleteAll() {
    state = state.copyWith(
      itemDelete: [],
      items: [],
    );
    saveLayout();
  }
}

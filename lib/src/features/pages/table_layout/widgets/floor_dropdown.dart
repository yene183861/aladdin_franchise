import 'package:aladdin_franchise/src/data/model/floor.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_input.dart';
import 'package:aladdin_franchise/src/features/pages/table_layout/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/dropdown/dropdown_menu_function.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FloorDropdown extends ConsumerStatefulWidget {
  const FloorDropdown({
    super.key,
    this.floorInit,
    this.onChangeFloor,
    this.backgroundColor,
  });

  final FloorModel? floorInit;

  final Function(FloorModel?)? onChangeFloor;
  final Color? backgroundColor;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FloorDropdownState();
}

class _FloorDropdownState extends ConsumerState<FloorDropdown> {
  FloorModel? floorSelect;

  @override
  void initState() {
    super.initState();
    floorSelect = widget.floorInit;
  }

  @override
  void didUpdateWidget(covariant FloorDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.floorInit?.id != floorSelect?.id) {
      setState(() {
        floorSelect = widget.floorInit;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var floors = ref.watch(tableLayoutPageProvider.select((value) => value.floors));
    var floorChange = floors.firstWhereOrNull((e) => e.id == floorSelect?.id);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (floorChange != floorSelect) {
          setState(() {
            floorSelect = floorChange;
            widget.onChangeFloor?.call(floorChange);
          });
        }
      },
    );

    return AppDropdownMenuFunction<FloorModel>(
      datas: floors,
      itemInit: floorSelect,
      titleButton: 'Thêm tầng',
      backgroundColor: widget.backgroundColor,
      titleMenuItemBuilder: (p0) {
        return p0.name;
      },
      disableEditValues: floors.where((e) => e.isDefault).toList(),
      onDismissedItem: (p0) async {
        // await ref.read(tableLayoutPageProvider.notifier).updateFloor(
        //       item: p0,
        //       delete: true,
        //     );
        // if (p0 == floorSelect) {
        //   setState(() {
        //     floorSelect = floors.firstWhereOrNull((e) => e.isDefault);
        //     widget.onChangeFloor?.call(floorSelect);
        //   });
        // }
      },
      onSelectionItem: (p0) {
        floorSelect = p0;
        widget.onChangeFloor?.call(p0);
      },
      onClickIcon: (p0) async {
        // if (p0.isDefault) return;
        // var res = await showConfirmInputDialog(
        //   context,
        //   title: 'Thay đổi tên từ ${p0.name} thành',
        //   hintText: '',
        //   textAction: 'Lưu',
        //   initText: p0.name,
        //   validator: (p0) {
        //     if ((p0 ?? '').trim().isEmpty) {
        //       return 'Vui lòng nhập tên để dễ phân biệt';
        //     }
        //     return null;
        //   },
        // );
        // if ((res ?? '').trim().isNotEmpty) {
        //   var fl = await ref.read(tableLayoutPageProvider.notifier).updateFloor(
        //         item: p0,
        //         name: (res ?? '').trim(),
        //         delete: false,
        //       );
        //   if (p0 == floorSelect) {
        //     setState(() {
        //       floorSelect = fl;
        //       widget.onChangeFloor?.call(fl);
        //     });
        //   }
        // }
      },
      onTapButtonBottom: () async {
        Navigator.of(context).pop();
        var res = await showConfirmInputDialog(
          context,
          title: 'Thêm tầng',
          hintText: '',
          textAction: 'Thêm mới',
        );

        if ((res ?? '').trim().isNotEmpty) {
          var fl = await ref.read(tableLayoutPageProvider.notifier).addFloor((res ?? '').trim());

          setState(() {
            floorSelect = fl;
            widget.onChangeFloor?.call(fl);
          });
        }
      },
    );
  }
}

// import 'package:aladdin_franchise/src/configs/text_style.dart';
// import 'package:aladdin_franchise/src/models/reservation.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';

// class DropdownSearchButton<T> extends StatefulWidget {
//   const DropdownSearchButton({
//     super.key,
//     required this.data,
//     this.initData,
//     this.onChangeData,
//     this.hintText,
//     this.hintTextSearch,
//     this.onCloseDropdownMenu,
//     this.searchMatchFn,
//     this.itemSelectedBuilder,
//     this.itemBuilder,
//   });

//   final List<T> data;
//   final T? initData;

//   /// hàm được gọi khi chọn item trong menu
//   final Function(T?)? onChangeData;

//   final Widget Function(T data)? itemSelectedBuilder;
//   final Widget Function(T data, bool selected)? itemBuilder;

//   final String? hintText;
//   final String? hintTextSearch;

//   /// hàm được gọi khi  dropdown menu đóng
//   final Function(T?)? onCloseDropdownMenu;

//   final bool Function(DropdownMenuItem<T>, String)? searchMatchFn;

//   @override
//   State<DropdownSearchButton<T>> createState() => _DropdownSearchButtonState();
// }

// class _DropdownSearchButtonState<T> extends State<DropdownSearchButton<T>> {
//   late TextEditingController _controller;

//   T? itemSelect;

//   bool openDropdown = false;

//   bool isOpenDropdownMenu = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//     itemSelect = widget.initData;
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var datas = List<T>.from(widget.data);
//     double buttonHeight = 64;
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<T>(
//         isExpanded: true,
//         value: itemSelect,
//         onMenuStateChange: (isOpen) {
//           if (!isOpen) {
//             widget.onCloseDropdownMenu?.call(itemSelect);
//           }
//           setState(() {
//             isOpenDropdownMenu = isOpen;
//           });
//         },
//         items: datas.map((e) {
//           bool selected = (e as ReservationModel).id == (itemSelect as ReservationModel?)?.id;
//           return DropdownMenuItem<T>(
//             value: e,
//             child: widget.itemBuilder?.call(e, selected) ??
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   width: double.maxFinite,
//                   child: Text(
//                     e.toString(),
//                     style: styleConfig.textStyleMain,
//                   ),
//                 ),
//           );
//         }).toList(),
//         selectedItemBuilder: (context) {
//           return datas.map(
//             (item) {
//               return widget.itemSelectedBuilder?.call(item) ??
//                   Container(
//                     alignment: AlignmentDirectional.centerStart,
//                     child: Text(
//                       item.toString(),
//                       style: styleConfig.textStyleMain,
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 2,
//                     ),
//                   );
//             },
//           ).toList();
//         },
//         onChanged: (value) {
//           if (value == null) return;
//           itemSelect = ((value == itemSelect) ? null : value) as T?;

//           widget.onChangeData?.call(itemSelect);

//           setState(() {});
//         },
//         iconStyleData: IconStyleData(
//           icon: isOpenDropdownMenu
//               ? const Icon(Icons.keyboard_arrow_up_rounded)
//               : const Icon(Icons.keyboard_arrow_down_rounded),
//           iconDisabledColor: Colors.transparent,
//         ),
//         buttonStyleData: ButtonStyleData(
//           height: itemSelect == null ? 64 : 80,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             border: isOpenDropdownMenu
//                 ? Border.all(color: CustomStyle.mainColor)
//                 : Border.all(color: Colors.grey),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//         ),
//         dropdownStyleData: DropdownStyleData(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//           maxHeight: 400,
//           offset: const Offset(0, -10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           scrollbarTheme: const ScrollbarThemeData(
//             radius: Radius.circular(8),
//             thumbVisibility: MaterialStatePropertyAll(true),
//           ),
//           elevation: 1,
//         ),
//         menuItemStyleData: const MenuItemStyleData(padding: EdgeInsets.zero, height: 80),
//         dropdownSearchData: DropdownSearchData(
//           searchController: _controller,
//           searchInnerWidgetHeight: buttonHeight,
//           searchInnerWidget: Container(
//             height: buttonHeight,
//             padding: const EdgeInsets.symmetric(horizontal: 8).copyWith(top: 12),
//             child: TextFormField(
//               maxLines: 1,
//               minLines: 1,
//               controller: _controller,
//               onTapOutside: (event) {
//                 FocusManager.instance.primaryFocus?.unfocus();
//               },
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(
//                   Icons.search,
//                   size: 24,
//                 ),
//                 isDense: true,
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                 hintText: widget.hintTextSearch ?? '',
//                 hintStyle: styleConfig.textStyleMain
//                     .copyWith(color: Colors.grey.shade500)
//                     .copyWith(fontStyle: FontStyle.italic),
//               ),
//             ),
//           ),
//           searchMatchFn: widget.searchMatchFn,
//         ),
//         hint: Text(
//           widget.hintText ?? '',
//           style: styleConfig.textStyleMain
//               .copyWith(color: Colors.grey.shade500, fontStyle: FontStyle.italic),
//         ),
//       ),
//     );
//   }
// }

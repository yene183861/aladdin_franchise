// import 'package:aladdin_franchise/src/configs/app.dart';
// import 'package:aladdin_franchise/src/configs/color.dart';
// import 'package:aladdin_franchise/src/configs/text_style.dart';
// import 'package:aladdin_franchise/src/features/widgets/gap.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';

// class AppDropdownButton<T> extends StatefulWidget {
//   const AppDropdownButton({
//     super.key,
//     this.data = const [],
//     this.initData = const [],
//     this.onChangeData,
//     this.allowSelectMulti = false,
//     this.allowSearch = false,
//     this.buildTextDisplay,
//     this.hintText,
//     this.hintTextSearch,
//     this.onCloseDropdownMenu,
//     this.searchMatchFn,
//     this.allowSelectAll = false,
//     this.selectAllObj,
//     this.disableDropdown = false,
//     this.disableData = const [],
//     this.allObject,
//   }) : assert(!allowSelectAll || selectAllObj != null);

//   final List<T> data;
//   final List<T> initData;

//   /// hàm được gọi khi chọn item trong menu
//   final Function(List<T>)? onChangeData;

//   final bool allowSelectMulti;

//   final bool allowSearch;

//   final String Function(T data)? buildTextDisplay;

//   final String? hintText;
//   final String? hintTextSearch;

//   final Function(List<T> data)? onCloseDropdownMenu;

//   final bool Function(DropdownMenuItem<T>, String)? searchMatchFn;

//   // final bool allowSelectAll;
//   // final T? selectAllObj;

//   final bool disableDropdown;

//   final List<T> disableData;
//   final T? allObject;

//   @override
//   State<AppDropdownButton<T>> createState() => _AppDropdownButtonState();
// }

// class _AppDropdownButtonState<T> extends State<AppDropdownButton<T>> {
//   late TextEditingController _controller;

//   // List<T> selectedItems = [];

//   bool openDropdown = false;

//   // bool isOpenDropdownMenu = false;

//   List<T> disableData = [];
//   List<T> itemSelect = [];
//   List<T> dataView = [];

//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//     dataView = List<T>.from(widget.data);
//     disableData = List<T>.from(widget.disableData);
//     itemSelect.addAll(widget.initData);
//     if (dataView.length > 1 &&
//         widget.allowSelectMulti &&
//         widget.allObject != null) {
//       dataView.insert(0, widget.allObject!);
//     }
//     if (itemSelect.length == widget.data.length &&
//         widget.allowSelectMulti &&
//         widget.allObject != null) {
//       itemSelect.add(widget.allObject!);
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   void didUpdateWidget(covariant AppDropdownButton<T> oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // setState(() {
//     //   selectedItems = [];
//     //   if (widget.initData.length == widget.data.length &&
//     //       widget.allowSelectAll) {
//     //     selectedItems.add(widget.selectAllObj!);
//     //   }
//     //   selectedItems.addAll(widget.initData);
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // var datas = List<T>.from(widget.data);
//     // if (widget.allowSelectAll) {
//     //   datas.insert(0, widget.selectAllObj!);
//     // }
//     bool selectMulti = widget.selectMulti;
//     double buttonHeight = AppConfig.heightBtn;
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<T>(
//         isExpanded: true,
//         value: selectedItems.isEmpty ? null : selectedItems.first,
//         onMenuStateChange: (isOpen) {
//           if (!isOpen) {
//             widget.onCloseDropdownMenu?.call(selectedItems);
//           }
//           setState(() {
//             isOpenDropdownMenu = isOpen;
//           });
//         },
//         items: datas
//             .map((e) => DropdownMenuItem<T>(
//                   // enabled: widget.disableEnableValue != null
//                   //     ? widget.disableEnableValue == e
//                   //     : (selectMulti ? false : true),
//                   enabled: w,
//                   value: e,
//                   child: StatefulBuilder(builder: (context, menuSetState) {
//                     final isSelected = selectedItems.contains(e);
//                     return InkWell(
//                       onTap: !selectMulti
//                           ? null
//                           : () {
//                               if (widget.allowSelectAll) {
//                                 if (e == widget.selectAllObj) {
//                                   selectedItems =
//                                       isSelected ? [] : List<T>.from(datas);
//                                   widget.onChangeData?.call(selectedItems);
//                                   Navigator.of(context).pop();
//                                   setState(() {});
//                                 } else {
//                                   if (isSelected) {
//                                     if (selectedItems
//                                         .contains(widget.selectAllObj)) {
//                                       selectedItems.remove(widget.selectAllObj);
//                                     }
//                                     selectedItems.remove(e);
//                                   } else {
//                                     selectedItems.add(e);
//                                     if (selectedItems == widget.data) {
//                                       selectedItems.add(widget.selectAllObj!);
//                                     }
//                                   }

//                                   widget.onChangeData?.call(selectedItems);
//                                   menuSetState(() {});
//                                   setState(() {});
//                                   Navigator.of(context).pop();
//                                 }
//                               } else {
//                                 isSelected
//                                     ? selectedItems.remove(e)
//                                     : selectedItems.add(e);
//                                 widget.onChangeData?.call(selectedItems);
//                                 menuSetState(() {});
//                                 setState(() {});
//                                 Navigator.of(context).pop();
//                               }
//                             },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 8),
//                         width: double.maxFinite,
//                         child: Row(
//                           children: [
//                             if (widget.allowSearch) ...[
//                               Checkbox(
//                                 value: isSelected,
//                                 onChanged: !selectMulti
//                                     ? null
//                                     : (value) {
//                                         // : (value) {
//                                         //     isSelected ? selectedItems.remove(e) : selectedItems.add(e);

//                                         //     widget.onChangeData?.call(selectedItems);

//                                         //     setState(() {});
//                                         //     menuSetState(() {});
//                                         //   },

//                                         if (widget.allowSelectAll) {
//                                           if (e == widget.selectAllObj) {
//                                             if (isSelected) {
//                                               selectedItems = [];
//                                             } else {
//                                               selectedItems = List.from(datas);
//                                             }
//                                             widget.onChangeData
//                                                 ?.call(selectedItems);
//                                             Navigator.of(context).pop();
//                                             setState(() {});
//                                           } else {
//                                             if (isSelected) {
//                                               selectedItems
//                                                   .remove(widget.selectAllObj);
//                                               selectedItems.remove(e);
//                                             } else {
//                                               selectedItems.add(e);
//                                             }

//                                             widget.onChangeData
//                                                 ?.call(selectedItems);
//                                             setState(() {});
//                                             menuSetState(() {});
//                                           }
//                                         } else {
//                                           isSelected
//                                               ? selectedItems.remove(e)
//                                               : selectedItems.add(e);
//                                           widget.onChangeData
//                                               ?.call(selectedItems);
//                                           menuSetState(() {});
//                                           setState(() {});
//                                         }
//                                       },
//                                 visualDensity: const VisualDensity(
//                                     horizontal: -4, vertical: -4),
//                               ),
//                               const Gap(4),
//                             ],
//                             Expanded(
//                               child: Text(
//                                 widget.buildTextDisplay?.call(e) ??
//                                     e.toString(),
//                                 style: AppTextStyle.regular(),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//                 ))
//             .toList(),
//         selectedItemBuilder: (context) {
//           return datas.map(
//             (item) {
//               return Container(
//                 alignment: AlignmentDirectional.centerStart,
//                 child: Text(
//                   _selectedItemBuilder(),
//                   style: AppTextStyle.regular(),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 2,
//                 ),
//               );
//             },
//           ).toList();
//         },
//         onChanged: widget.disableDropdown
//             ? null
//             : (value) {
//                 if (value == null) return;
//                 selectedItems = [value];

//                 widget.onChangeData?.call(selectedItems);

//                 setState(() {});
//               },
//         iconStyleData: IconStyleData(
//           icon: isOpenDropdownMenu
//               ? const Icon(Icons.keyboard_arrow_up_rounded)
//               : const Icon(Icons.keyboard_arrow_down_rounded),
//           iconDisabledColor: Colors.transparent,
//         ),
//         buttonStyleData: ButtonStyleData(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: AppColors.grey500,
//             ),
//           ),
//           padding: const EdgeInsets.symmetric(
//             horizontal: 16,
//           ),
//         ),
//         dropdownStyleData: DropdownStyleData(
//           padding: EdgeInsets.zero,
//           maxHeight: 250,
//           offset: const Offset(0, -5),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           scrollbarTheme: const ScrollbarThemeData(
//             radius: Radius.circular(8),
//             thumbVisibility: MaterialStatePropertyAll(true),
//           ),
//           elevation: 1,
//         ),
//         menuItemStyleData: const MenuItemStyleData(padding: EdgeInsets.zero),
//         dropdownSearchData: widget.allowSearch
//             ? DropdownSearchData(
//                 searchController: _controller,
//                 searchInnerWidgetHeight: buttonHeight,
//                 searchInnerWidget: Container(
//                   height: buttonHeight,
//                   padding: const EdgeInsets.all(8),
//                   child: TextFormField(
//                     expands: true,
//                     maxLines: null,
//                     controller: _controller,
//                     onTapOutside: (event) {
//                       FocusManager.instance.primaryFocus?.unfocus();
//                     },
//                     decoration: InputDecoration(
//                       isDense: true,
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 10, vertical: 8),
//                       hintText: widget.hintTextSearch ?? '',
//                       hintStyle: AppTextStyle.regular(
//                         color: Colors.grey.shade500,
//                         rawFontSize: 13,
//                       ).copyWith(fontStyle: FontStyle.italic),
//                     ),
//                   ),
//                 ),
//                 searchMatchFn: widget.searchMatchFn,
//               )
//             : null,
//         hint: Text(
//           widget.hintText ?? '',
//           style: AppTextStyle.regular(
//             color: Colors.grey.shade500,
//             rawFontSize: 13,
//           ).copyWith(fontStyle: FontStyle.italic),
//         ),
//       ),
//     );
//   }

//   String _selectedItemBuilder() {
//     List<T> items = List<T>.from(selectedItems);
//     if (items.contains(widget.selectAllObj)) {
//       items.remove(widget.selectAllObj);
//     }
//     return items
//         .map((e) => widget.buildTextDisplay?.call(e) ?? e.toString())
//         .join(', ');
//   }
// }

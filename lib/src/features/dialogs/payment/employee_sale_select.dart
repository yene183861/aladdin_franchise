// import 'package:aladdin_franchise/generated/l10n.dart';
// import 'package:aladdin_franchise/src/configs/app.dart';
// import 'package:aladdin_franchise/src/configs/text_style.dart';
// import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
// import 'package:aladdin_franchise/src/features/pages/home/state.dart';
// import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
// import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
// import 'package:aladdin_franchise/src/features/widgets/custom_dropdown_button.dart';
// import 'package:aladdin_franchise/src/models/employee_sale.dart';
// import 'package:diacritic/diacritic.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class EmployeeSaleSelectWidget extends ConsumerWidget {
//   const EmployeeSaleSelectWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           child: Text.rich(
//             style: AppTextStyle.bold(),
//             TextSpan(
//               text: S.current.sale_staff,
//               children: [
//                 TextSpan(
//                   text: " *",
//                   style: AppTextStyle.bold(color: Colors.red),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Consumer(builder: (context, ref, child) {
//           final state = ref
//               .watch(homeProvider.select((value) => value.employeeSaleState));
//           final data =
//               ref.watch(homeProvider.select((value) => value.employeeSales));

//           var dataView = data
//               .where((e) => [
//                     0,
//                     kTypeOrder == AppConfig.orderOfflineValue ? 1 : 2
//                   ].contains(e.isOnline))
//               .toList();
//           final empSelect = ref
//               .watch(homeProvider.select((value) => value.employeeSaleSelect));
//           switch (state.status) {
//             case PageCommonState.loading:
//               return const AppLoadingLineWidget();
//             case PageCommonState.error:
//               return AppErrorSimpleWidget(
//                 onTryAgain: ref.read(homeProvider.notifier).getEmployeeSales,
//                 textButton: S.current.reload,
//                 message: state.messageError,
//               );
//             default:
//           }
//           if (dataView.isEmpty) {
//             return Text(S.current.no_sale_staff_set_up);
//           }

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomDropdownButton<EmployeeSaleModel>(
//                 data: dataView,
//                 allowSearch: true,
//                 buildTextDisplay: (data) {
//                   return data.fullName;
//                 },
//                 initData: empSelect == null ? [] : [empSelect],
//                 onChangeData: (p0) {
//                   ref
//                       .read(homeProvider.notifier)
//                       .onChangeEmployeeSaleSelect(p0.firstOrNull);
//                 },
//                 hintText: S.current.select_sales_staff,
//                 searchMatchFn: (p0, p1) {
//                   return removeDiacritics(
//                           (p0.value?.fullName ?? '').trim().toLowerCase())
//                       .contains(removeDiacritics(p1.trim().toLowerCase()));
//                 },
//               ),
//             ],
//           );
//         })
//       ],
//     );
//   }
// }

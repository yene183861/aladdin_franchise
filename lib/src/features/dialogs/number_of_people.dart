// import 'package:aladdin_franchise/generated/l10n.dart';
// import 'package:aladdin_franchise/src/configs/color.dart';
// import 'package:aladdin_franchise/src/configs/text_style.dart';
// import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
// import 'package:aladdin_franchise/src/features/widgets/gap.dart';
// import 'package:aladdin_franchise/src/features/widgets/title_line.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_spinbox/flutter_spinbox.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// class CheckoutNumberOfPeopleWidget extends ConsumerWidget {
//   const CheckoutNumberOfPeopleWidget({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final homeNotifier = ref.read(homeProvider.notifier);
//     final coupons = ref.watch(homeProvider.select((value) => value.coupons));

//     var requireApplyPolicy = coupons.any((e) => e.isType == 6);
//     bool allowChangeNumberOfAdults = !requireApplyPolicy;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TitleLineWidget(title: S.current.number_of_people),
//         const Gap(8),
//         SpinBox(
//           min: 1,
//           max: 200,
//           enabled: allowChangeNumberOfAdults,
//           incrementIcon: const Icon(CupertinoIcons.add),
//           decrementIcon: const Icon(CupertinoIcons.minus),
//           textStyle: AppTextStyle.bold(),
//           value: ref
//               .watch(homeProvider.select((value) => value.numberOfAdults))
//               .toDouble(),
//           decoration: InputDecoration(
//             label: Text(
//               S.current.number_of_adults,
//               style: AppTextStyle.regular(),
//             ),
//           ),
//           onChanged: (value) {
//             homeNotifier.changeNumberOfPeople(
//                 numberOfAdults: value.toInt(), applyPolicy: requireApplyPolicy);
//           },
//         ),
//         if (requireApplyPolicy) ...[
//           const Gap(8),
//           Text(
//             'Mã giảm giá theo số khách, thay đổi sổ khách người lớn trong mục Ưu đãi.',
//             style: AppTextStyle.regular(
//                 color: AppColors.redColor, fontSize: 12.sp),
//           )
//         ],
//         const GapH(24),
//         SpinBox(
//           min: 0,
//           max: 200,
//           incrementIcon: const Icon(CupertinoIcons.add),
//           decrementIcon: const Icon(CupertinoIcons.minus),
//           textStyle: AppTextStyle.bold(),
//           value: ref
//               .watch(homeProvider.select((value) => value.numberOfChildren))
//               .toDouble(),
//           decoration: InputDecoration(
//             label: Text(
//               S.current.number_of_children,
//               style: AppTextStyle.regular(),
//             ),
//           ),
//           onChanged: (value) {
//             homeNotifier.changeNumberOfPeople(
//               numberOfChildren: value.toInt(),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

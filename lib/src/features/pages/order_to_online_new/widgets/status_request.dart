// import 'package:aladdin_franchise/src/data/model/o2o/request_order.dart';
// import 'package:aladdin_franchise/src/features/widgets/gap.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:aladdin_franchise/src/configs/text_style.dart';

// class StatusRequestWidget extends StatelessWidget {
//   const StatusRequestWidget({
//     super.key,
//     required this.status,
//   });
//   final RequestProcessingStatus status;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
//       decoration: BoxDecoration(
//         color: status.color.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SvgPicture.asset(
//             status.iconSvg,
//             width: 20,
//             height: 20,
//             colorFilter: ColorFilter.mode(status.color, BlendMode.srcIn),
//           ),
//           const Gap(4),
//           Text(
//             status.title,
//             style: AppTextStyle.bold(
//               color: status.color,
//               rawFontSize: 12,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

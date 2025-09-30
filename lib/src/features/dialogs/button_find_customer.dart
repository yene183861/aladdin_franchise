import 'dart:io';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_input.dart';
import 'package:aladdin_franchise/src/features/dialogs/create_customer.dart';
import 'package:aladdin_franchise/src/features/dialogs/create_customer_zalo_oa.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/customer/view.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button_with_icon.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/title_line.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../generated/l10n.dart';
import 'error.dart';

onChooseCustomerOption(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: TitleDialogWithCloseWidget(
          title: S.current.customers,
        ),
        content: const _MenuFindCustomerWidget(),
      );
    },
  );
}

class _MenuFindCustomerWidget extends ConsumerWidget {
  const _MenuFindCustomerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var lockedOrder =
        ref.watch(homeProvider.select((value) => value.lockedOrder));
    bool enable = !lockedOrder;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer(
            builder: (context, ref, child) {
              var customer =
                  ref.watch(homeProvider.select((value) => value.customer));

              if (customer == null) {
                if (!enable) return Text(S.current.msg_locked_order);
                return const SizedBox.shrink();
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CustomerInfoWidget(
                  canAction: enable,
                  customer: customer,
                  // onCancelCustomer: () {
                  //   showConfirmAction(
                  //     context,
                  //     action: () async {
                  //       final result = await ref
                  //           .read(homeProvider.notifier)
                  //           .resetCustomer();
                  //       if (result != null) {
                  //         await showErrorDialog(
                  //           context,
                  //           message: result.toString(),
                  //           isNotifier: true,
                  //         );
                  //         // showMessageDialog(
                  //         //   context,
                  //         //   message: result.toString(),
                  //         // );
                  //       } else {
                  //         ref.read(homeProvider.notifier).syncInfoForCustomer();
                  //         // xoá khách xong thì áp dụng lại giảm giá
                  //         await ref
                  //             .read(homeProvider.notifier)
                  //             .applyCustomerPolicy();
                  //       }
                  //     },
                  //     message: S.current.removeCustomer,
                  //   );
                  // },
                ),
              );
            },
          ),
          if (enable) ...[
            const _ButtonFindByPhoneWidget(),
            // if (Platform.isAndroid) ...[
            //   const GapH(8),
            //   const _ButtonFindByQRBarcodeWidget(),
            // ],
            const GapH(8),
            const Divider(),
            const _ButtonCreateNewCustomerWidget(),
            // hiện ko dùng Zalo OA
            // Divider(),
            // _ButtonCreateCustomerFromQrZaloOAWidget(),
          ],
        ],
      ),
    );
  }
}

class _ButtonFindByPhoneWidget extends ConsumerWidget {
  const _ButtonFindByPhoneWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ButtonWithIconWidget(
      color: AppColors.secondColor,
      icon: Icons.phone_android,
      textAction: S.current.search_by_phone_number,
      onPressed: () async {
        var phone = await showConfirmInputDialog(
          context,
          title: S.current.findCustomer,
          hintText: "${S.current.input} ${S.current.phone}",
          textAction: S.current.check,
          keyboardType: TextInputType.number,
          maxLengthInput: 11,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        );
        if (phone != null && phone.isNotEmpty) {
          var result =
              await ref.read(homeProvider.notifier).findCustomer(phone);
          if (result != FindCustomerStatus.success) {
            var errorMessage = ref.read(homeProvider).messageError;
            // Hiển thị thông báo kèm theo nút tạo khách hàng mới
            if (result == FindCustomerStatus.notFound) {
              if (context.mounted) {
                await showConfirmAction(
                  context,
                  title: S.current.notification,
                  actionTitle: S.current.createNewCustomers,
                  message: errorMessage,
                  action: () async {
                    var result = await showCreateCustomerDialog(context, phone);
                    if (result != null) {
                      await ref.read(homeProvider.notifier).findCustomer(phone);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                  },
                );
              }
            } else {
              if (context.mounted) {
                await showErrorDialog(
                  context,
                  message: errorMessage,
                  isNotifier: true,
                );
                // await showMessageDialog(
                //   context,
                //   message: errorMessage,
                // );
              }
            }
          } else if (context.mounted) {
            Navigator.pop(context);
          }
        }
      },
    );
  }
}

// class _ButtonFindByQRBarcodeWidget extends ConsumerWidget {
//   const _ButtonFindByQRBarcodeWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ButtonWithIconWidget(
//       color: AppColors.secondColor,
//       icon: Icons.qr_code_scanner,
//       textAction: S.current.scan_code_zalo,
//       onPressed: () async {
//         if (Platform.isWindows) {
//           showMessageDialog(
//             context,
//             message: S.current.only_available_on_the_Order_Tab,
//           );
//           return;
//         }
//         String barcodeRes = await FlutterBarcodeScanner.scanBarcode(
//           "#000000",
//           S.current.cancel,
//           true,
//           ScanMode.DEFAULT,
//         );
//         showLog(barcodeRes);
//         if (barcodeRes != '-1') {
//           var result =
//               await ref.read(homeProvider.notifier).findCustomer(barcodeRes);
//           if (result != FindCustomerStatus.success) {
//             var errorMessage = ref.read(homeProvider).messageError;
//             if (context.mounted) {
//               await showErrorDialog(
//                 context,
//                 message: errorMessage,
//                 isNotifier: true,
//               );
//               // await showMessageDialog(
//               //   context,
//               //   message: errorMessage,
//               // );
//             }
//           } else if (context.mounted) {
//             Navigator.pop(context);
//           }
//         }
//       },
//     );
//   }
// }

class _ButtonCreateNewCustomerWidget extends ConsumerWidget {
  const _ButtonCreateNewCustomerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ButtonWithIconWidget(
      icon: Icons.person_add_alt,
      textAction: S.current.createNewCustomers,
      onPressed: () async {
        var result = await showCreateCustomerDialog(context, '');
        if (result != null) {
          await ref.read(homeProvider.notifier).findCustomer(result);
          if (context.mounted) {
            Navigator.pop(context);
          }
        }
      },
    );
  }
}

// class _ButtonCreateCustomerFromQrZaloOAWidget extends ConsumerWidget {
//   const _ButtonCreateCustomerFromQrZaloOAWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ButtonWithIconWidget(
//       icon: Icons.qr_code,
//       color: const Color(0xff0168fe),
//       textAction: S.current.create_new_customers_via_Zalo_OA,
//       onPressed: () {
//         showCreateCustomerZaloOADialog(context);
//       },
//     );
//   }
// }

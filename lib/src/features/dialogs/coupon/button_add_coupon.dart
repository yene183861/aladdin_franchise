import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/coupon_info.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_main.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../generated/l10n.dart';
import '../error.dart';

showCouponDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          S.current.discountCode,
        ),
        content: const _CouponDialogContent(),
      );
    },
  );
}

class _CouponDialogContent extends ConsumerStatefulWidget {
  const _CouponDialogContent();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __CouponDialogContentState();
}

class __CouponDialogContentState extends ConsumerState<_CouponDialogContent> {
  late TextEditingController _inputCtrl;
  @override
  void initState() {
    super.initState();
    _inputCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _inputCtrl.dispose();
    super.dispose();
  }

  void _addCoupon() async {
    var coupon = _inputCtrl.text.trim();
    if (_inputCtrl.text.trim().isEmpty) return;
    var result = await ref.read(homeProvider.notifier).addCoupon(code: coupon);
    if (result.error != null && context.mounted) {
      await showErrorDialog(
        context,
        message: result.error.toString(),
        isNotifier: true,
        titleMessage: result.titleError,
      );
    } else {
      _inputCtrl.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const _NumberOfAdultsWidget(),
          Consumer(
            builder: (context, ref, child) {
              var lockedOrder = ref.watch(homeProvider.select((value) => value.lockedOrder));
              if (lockedOrder) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFieldSimpleWidget(
                        hintText: S.current.inputCode,
                        prefixIcon: const Icon(Icons.keyboard_alt_outlined),
                        textController: _inputCtrl,
                        onTapOutside: _addCoupon,
                        onEditingComplete: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          _addCoupon();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      child: ButtonMainWidget(
                        textAction: S.current.confirm,
                        color: AppColors.secondColor,
                        onPressed: _addCoupon,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const Gap(8),
          const Expanded(
            child: _ListCouponWidget(),
          ),
          _CounponActionWidget()
        ],
      ),
    );
  }
}

class _NumberOfAdultsWidget extends ConsumerWidget {
  const _NumberOfAdultsWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var lockedOrder = ref.watch(homeProvider.select((value) => value.lockedOrder));
    var coupons = ref.watch(homeProvider.select((value) => value.coupons));
    bool enable = !lockedOrder;
    String message = '';
    if (coupons.any((e) => e.isType == 6)) {
      message =
          'Đơn bàn có sử dụng mã giảm giá theo số khách, vui lòng bấm áp dụng sau khi thay đổi số khách';
    }
    if (lockedOrder) {
      message = 'Đơn bàn đã tạm khóa';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const NumberOfAdultsWidget(),
        if (message.trim().isNotEmpty) ...[
          const Gap(4),
          Row(
            children: [
              const Icon(Icons.info_outline_rounded, color: Colors.red),
              const Gap(4),
              Expanded(
                child: Text(
                  message,
                  style: AppTextStyle.regular(rawFontSize: 12, color: Colors.red),
                ),
              )
            ],
          ),
        ],
      ],
    );
  }
}

class NumberOfAdultsWidget extends ConsumerWidget {
  const NumberOfAdultsWidget({super.key, this.labelText});
  final String? labelText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var lockedOrder = ref.watch(homeProvider.select((value) => value.lockedOrder));
    bool enable = !lockedOrder;
    return SpinBox(
      min: 1,
      max: 200,
      enabled: enable,
      incrementIcon: const Icon(CupertinoIcons.add),
      decrementIcon: const Icon(CupertinoIcons.minus),
      textStyle: AppTextStyle.bold(),
      value: ref.watch(homeProvider.select((value) => value.numberOfAdults)).toDouble(),
      decoration: InputDecoration(
        label: Text.rich(
          TextSpan(
            text: labelText ?? S.current.number_of_guest,
            children: [
              if (labelText == null)
                TextSpan(
                  text: ' (${S.current.number_of_adults})',
                  style: AppTextStyle.regular(),
                ),
            ],
            style: AppTextStyle.bold(),
          ),
        ),
      ),
      onChanged: (value) {
        bool requiredApplyPolicy = ref.read(homeProvider).coupons.any((e) => e.isType == 6);
        ref.read(homeProvider.notifier).changeNumberOfPeople(
              numberOfAdults: value.toInt(),
              //  applyPolicy: false
            );
      },
    );
  }
}

class _ListCouponWidget extends ConsumerWidget {
  const _ListCouponWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var coupons = ref.watch(homeProvider.select((value) => value.coupons));
    var productCheckout = ref.watch(homeProvider.select((value) => value.productCheckout));
    var lockedOrder = ref.watch(homeProvider.select((value) => value.lockedOrder));

    return
        // coupons.isEmpty
        //     ? Padding(
        //         padding: const EdgeInsets.only(bottom: 12),
        //         child: Text(S.current.notDiscountApply),
        //       )
        //     :
        CouponInfoWidget(
      canAction: !lockedOrder,
      // productCheckouts: productCheckout,
      // coupons: coupons,
      // onRemoveCoupon: (coupon) {
      //   showConfirmAction(
      //     context,
      //     message: S.current.deleteDiscountCode,
      //     action: () async {
      //       var resultRemove = await ref
      //           .read(homeProvider.notifier)
      //           .removeCoupon(coupon, applyPolicy: true);
      //       if (resultRemove != null) {
      //         showErrorDialog(
      //           context,
      //           message: resultRemove,
      //           isNotifier: true,
      //         );
      //         // showMessageDialog(context,
      //         //     message: resultRemove);
      //       }
      //     },
      //   );
      // },
    );
  }
}

class _CounponActionWidget extends ConsumerWidget {
  const _CounponActionWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var lockedOrder = ref.watch(homeProvider.select((value) => value.lockedOrder));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // if (!lockedOrder) ...[
        //   const _AddByInputCodeWidget(),
        //   const Gap(12),
        // ],
        // if (Platform.isAndroid && !lockedOrder) ...[
        //   _AddByScanQRBarcodeWidget(),
        //   const Gap(12),
        // ],
        if (!lockedOrder) ...[
          ButtonSimpleWidget(
            textAction: S.current.apply_policy_again,
            onPressed: () async {
              var res = await ref.read(homeProvider.notifier).applyCustomerPolicy();

              if (res != null && context.mounted) {
                showErrorDialog(
                  context,
                  message: res,
                  isNotifier: true,
                );
              }
            },
          ),
          const Gap(12),
        ],
        ButtonCancelWidget(
          onPressed: () => Navigator.pop(context),
          textAction: S.current.close,
        ),
      ],
    );
  }
}

// class _AddByInputCodeWidget extends ConsumerWidget {
//   const _AddByInputCodeWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ButtonWithIconWidget(
//       color: AppColors.secondColor,
//       icon: Icons.keyboard_alt_outlined,
//       textAction: S.current.inputCode,
//       onPressed: () async {
//         var coupon = await showConfirmInputDialog(
//           context,
//           title: S.current.discountCode,
//           hintText: S.current.inputCode,
//           textAction: S.current.apply,
//           textInputAction: TextInputAction.done,
//         );
//         if (coupon != null && coupon.trim().isNotEmpty) {
//           var result =
//               await ref.read(homeProvider.notifier).addCoupon(code: coupon);
//           if (result.error != null && context.mounted) {
//             await showErrorDialog(
//               context,
//               message: result.error.toString(),
//               isNotifier: true,
//               titleMessage: result.titleError,
//             );
//             // await showMessageDialog(
//             //   context,
//             //   message: result.error.toString(),
//             //   titleMessage: result.titleError,
//             // );
//           }
//         }
//       },
//     );
//   }
// }

// class _AddByScanQRBarcodeWidget extends ConsumerWidget {
//   const _AddByScanQRBarcodeWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ButtonWithIconWidget(
//       color: AppColors.secondColor,
//       icon: Icons.qr_code,
//       textAction: S.current.scan_qr_code,
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
//         if (barcodeRes != '-1') {
//           var result =
//               await ref.read(homeProvider.notifier).addCoupon(code: barcodeRes);
//           if (result.error != null && context.mounted) {
//             showMessageDialog(
//               context,
//               message: result.error.toString(),
//               titleMessage: result.titleError,
//             );
//           } else if (context.mounted) {
//             Navigator.pop(context);
//           }
//         }
//       },
//     );
//   }
// }

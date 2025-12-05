import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/enum/discount_type.dart';
import 'package:aladdin_franchise/src/features/dialogs/coupon_info.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_main.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/custom_dropdown_button.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

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
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __CouponDialogContentState();
}

class __CouponDialogContentState extends ConsumerState<_CouponDialogContent> {
  late TextEditingController _couponCtrl, _percentCtrl;
  late FocusNode _couponFocusNode, _percentFocusNode;

  late ValueNotifier<bool> _percentNotifier;

  final BehaviorSubject<String> _amountTextChange = BehaviorSubject<String>();

  bool _isFormatting = false;

  RegExp removeChars = RegExp(r'.,');
  @override
  void initState() {
    super.initState();
    _couponCtrl = TextEditingController();
    _percentCtrl = TextEditingController();
    _couponFocusNode = FocusNode();
    _percentFocusNode = FocusNode();
    _percentNotifier = ValueNotifier<bool>(false);
    _couponCtrl.addListener(
      () {
        _clearText();
      },
    );
    _percentCtrl.addListener(
      () {
        _changePrefixIcon();
        _clearText();
        if (_isFormatting) return;
        _amountTextChange.value = _percentCtrl.text.trim();
      },
    );

    _amountTextChange
        .debounceTime(const Duration(milliseconds: 0))
        .distinct()
        .listen((event) {
      final digits = event.replaceAll(removeChars, '');
      final number = int.tryParse(digits);
      if (number == null) return;

      final formatted =
          NumberFormat.currency(locale: 'vi', symbol: '').format(number);

      _isFormatting = true;
      _percentCtrl.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
      _isFormatting = false;
    });
  }

  @override
  void dispose() {
    _couponFocusNode.dispose();
    _percentFocusNode.dispose();
    _couponCtrl.dispose();
    _percentCtrl.dispose();
    _percentNotifier.dispose();
    super.dispose();
  }

  void _addCoupon() async {
    var coupon = _couponCtrl.text.trim();
    var percent = _percentCtrl.text.trim();
    if (coupon.isEmpty && percent.isEmpty) return;
    ({String? error, String? titleError}) result =
        (error: null, titleError: null);
    if (coupon.isNotEmpty) {
      result = await ref.read(homeProvider.notifier).addCoupon(code: coupon);
    } else if (percent.isNotEmpty) {
      result = await ref
          .read(homeProvider.notifier)
          .addPercentDiscount(value: _getAmountValue());
    }
    if (result.error != null) {
      if (context.mounted) {
        await showErrorDialog(
          context,
          message: result.error.toString(),
          isNotifier: true,
          titleMessage: result.titleError,
        );
      }
    } else {
      _couponCtrl.text = '';
      _percentCtrl.text = '';
    }
  }

  void _clearText() {
    if (_couponFocusNode.hasFocus && _percentCtrl.text.trim().isNotEmpty) {
      _percentCtrl.text = '';
    }
    if (_percentFocusNode.hasFocus && _couponCtrl.text.trim().isNotEmpty) {
      _couponCtrl.text = '';
    }
  }

  void _changePrefixIcon() {
    var text = _percentCtrl.text.trim();
    if (text.isEmpty) return;
    var value = _getAmountValue();
    if (value == 0) return;
    bool isPercent = _percentNotifier.value;
    if (value > 100) {
      if (isPercent) {
        _percentNotifier.value = false;
      }
    }
  }

  double _getAmountValue() {
    return double.tryParse(
            _percentCtrl.text.trim().replaceAll(removeChars, '')) ??
        0.0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _NumberOfAdultsWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Giảm giá VNĐ / %'),
                const Gap(4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Expanded(
                    //   child: AppTextFormField(
                    //     textInputType: TextInputType.number,
                    //     focusNode: _couponFocusNode,
                    //     hintText: S.current.inputCode,
                    //     prefixIcon: const ResponsiveIconWidget(
                    //       iconData: Icons.keyboard_alt_outlined,
                    //     ),
                    //     textController: _couponCtrl,
                    //     onTapOutside: _addCoupon,
                    //     onEditingComplete: () async {
                    //       FocusManager.instance.primaryFocus?.unfocus();
                    //       _addCoupon();
                    //     },
                    //   ),
                    // ),
                    // const Gap(8),
                    Expanded(
                      child: AppTextFormField(
                        focusNode: _percentFocusNode,
                        // hintText: 'Giảm theo số tiền (đ) hoặc %',
                        // prefixIcon: ValueListenableBuilder(
                        //   valueListenable: _percentNotifier,
                        //   builder: (context, value, child) {
                        //     bool isPercent = value;

                        //     return ResponsiveIconButtonWidget(
                        //       iconData: value
                        //           ? Icons.percent
                        //           : CupertinoIcons.money_dollar,
                        //       onPressed: () {
                        //         if (_getAmountValue() > 100.0 && !isPercent)
                        //           return;
                        //         _percentNotifier.value = !value;
                        //       },
                        //     );
                        //   },
                        // ),
                        textController: _percentCtrl,
                        // onTapOutside: _addCoupon,
                        onEditingComplete: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          // _addCoupon();
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    const Gap(8),
                    SizedBox(
                      width: 150,
                      child: CustomDropdownButton<DiscoundTypeEnum>(
                        data: DiscoundTypeEnum.values,
                        initData: [DiscoundTypeEnum.vnd],
                        buildTextDisplay: (data) => data.title,
                      ),
                    ),
                    const Gap(8),
                    AppButtonWidget(
                      textAction: S.current.confirm,
                      color: AppColors.secondColor,
                      onTap: _addCoupon,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(8),
          const Expanded(
            child: CouponInfoWidget(),
          ),
          const _CounponActionWidget()
        ],
      ),
    );
  }
}

class _NumberOfAdultsWidget extends ConsumerWidget {
  const _NumberOfAdultsWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var lockedOrder =
        ref.watch(homeProvider.select((value) => value.lockedOrder));
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
                  style: AppTextStyle.regular(
                    rawFontSize: AppConfig.defaultRawTextSize - 1.5,
                    color: Colors.red,
                  ),
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
    var lockedOrder =
        ref.watch(homeProvider.select((value) => value.lockedOrder));
    bool enable = !lockedOrder;
    return SpinBox(
      min: 1,
      max: 200,
      enabled: enable,
      incrementIcon: const Icon(CupertinoIcons.add),
      decrementIcon: const Icon(CupertinoIcons.minus),
      textStyle: AppTextStyle.bold(),
      value: ref
          .watch(homeProvider.select((value) => value.numberOfAdults))
          .toDouble(),
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
        bool requiredApplyPolicy =
            ref.read(homeProvider).coupons.any((e) => e.isType == 6);
        ref.read(homeProvider.notifier).changeNumberOfPeople(
              numberOfAdults: value.toInt(),
              //  applyPolicy: false
            );
      },
    );
  }
}

class _CounponActionWidget extends ConsumerWidget {
  const _CounponActionWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonSimpleWidget(
          textAction: S.current.apply_policy_again,
          onPressed: () async {
            var res =
                await ref.read(homeProvider.notifier).applyCustomerPolicy();

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
        ButtonCancelWidget(
          onPressed: () => Navigator.pop(context),
          textAction: S.current.close,
        ),
      ],
    );
  }
}

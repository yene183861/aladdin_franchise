import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/enum/discount_type.dart';
import 'package:aladdin_franchise/src/features/dialogs/coupon_info.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_main.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/custom_dropdown_button.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:flutter/cupertino.dart';
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
      return const Dialog(
        child: _CouponDialogContent(),
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
  late TextEditingController _percentCtrl;
  late FocusNode _percentFocusNode;

  final BehaviorSubject<String> _amountTextChange = BehaviorSubject<String>();

  bool _isFormatting = false;

  RegExp removeChars = RegExp(r'[.,]');

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _percentCtrl = TextEditingController();
    _percentFocusNode = FocusNode();
    _percentCtrl.addListener(
      () {
        if (_isFormatting) return;
        _amountTextChange.value = _percentCtrl.text.trim();
      },
    );

    _amountTextChange.debounceTime(const Duration(milliseconds: 0)).distinct().listen((event) {
      _formatValue(event);
    });
  }

  void _formatValue(String data) {
    var type = ref.read(homeProvider).discountTypeSelect;

    final digits = data.replaceAll(removeChars, '');
    final number = int.tryParse(digits);
    if (number == null) return;

    final formatted =
        type == DiscountTypeEnum.percent ? digits : AppUtils.formatCurrency(value: number);
    _isFormatting = true;
    _percentCtrl.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
    _isFormatting = false;
  }

  @override
  void dispose() {
    _percentFocusNode.dispose();
    _percentCtrl.dispose();
    _amountTextChange.close();
    super.dispose();
  }

  void _addCoupon() async {
    if (_formKey.currentState?.validate() ?? false) {
      var percent = _percentCtrl.text.trim();
      if (percent.isEmpty) return;
      ({String? error, String? titleError}) result = (error: null, titleError: null);
      result = await ref.read(homeProvider.notifier).addVoucher(value: _getAmountValue());
      if (result.error != null) {
        if (context.mounted) {
          showMessageDialog(context, message: result.error.toString());
          // await showErrorDialog(
          //   context,
          //   message: result.error.toString(),
          //   isNotifier: true,
          //   titleMessage: result.titleError,
          // );
        }
      } else {
        _percentCtrl.text = '';
      }
    }
  }

  double _getAmountValue() {
    return double.tryParse(_percentCtrl.text.trim().replaceAll(removeChars, '')) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        constraints: const BoxConstraints(minWidth: 400, minHeight: 500),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.current.discountCode),
            const Gap(20),
            const _NumberOfAdultsWidget(),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Giảm giá VND/%'),
                  const Gap(4),
                  Consumer(builder: (context, ref, child) {
                    var discoundType =
                        ref.watch(homeProvider.select((value) => value.discountTypeSelect));
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppTextFormField(
                            focusNode: _percentFocusNode,
                            textController: _percentCtrl,
                            onEditingComplete: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            validator: (value) {
                              var data = AppUtils.convertToDouble(value) ?? 0;
                              if (discoundType == DiscountTypeEnum.percent && data > 100.0) {
                                return 'Phần trăm không được vượt quá 100%';
                              }
                              return null;
                            },
                          ),
                        ),
                        const Gap(8),
                        SizedBox(
                          width: 100,
                          child: CustomDropdownButton<DiscountTypeEnum>(
                            data: DiscountTypeEnum.values,
                            initData: [discoundType],
                            buildTextDisplay: (data) => data.title,
                            onChangeData: (p0) {
                              if (p0.isEmpty) return;
                              ref.read(homeProvider.notifier).onChangeDiscountTypeSelect(p0.first);
                              final digits = _percentCtrl.text.trim().replaceAll(removeChars, '');
                              _formatValue(digits);
                            },
                          ),
                        ),
                        const Gap(8),
                        Consumer(
                          builder: (context, ref, child) {
                            var coupons = ref.watch(homeProvider.select((value) => value.coupons));
                            return AppButtonWidget(
                              textAction: S.current.confirm,
                              color: coupons.isNotEmpty ? Colors.grey : AppColors.secondColor,
                              onTap: coupons.isNotEmpty ? null : _addCoupon,
                            );
                          },
                        )
                      ],
                    );
                  }),
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

class _CounponActionWidget extends ConsumerWidget {
  const _CounponActionWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ButtonSimpleWidget(
        //   textAction: S.current.apply_policy_again,
        //   onPressed: () async {
        //     var res = await ref.read(homeProvider.notifier).applyCustomerPolicy(requireApply: true);

        //     if (res != null && context.mounted) {
        //       showErrorDialog(
        //         context,
        //         message: res,
        //         isNotifier: true,
        //       );
        //     }
        //   },
        // ),
        // const Gap(12),
        ButtonCancelWidget(
          onPressed: () => Navigator.pop(context),
          textAction: S.current.close,
        ),
      ],
    );
  }
}

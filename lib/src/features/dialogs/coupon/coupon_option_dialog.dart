import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/dev_config.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/data/enum/discount_type.dart';
import 'package:aladdin_franchise/src/features/dialogs/coupon/widgets/coupon_info.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/widgets/number_of_adults.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/custom_dropdown_button.dart';
import 'package:aladdin_franchise/src/features/widgets/dialog/title_with_close_icon.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../generated/l10n.dart';

void showCouponOptionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      bool smallDevice = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
      return FractionallySizedBox(
        widthFactor: smallDevice ? 0.9 : 0.75,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                TitleWithCloseIconDialog(
                  title: S.current.discountCode,
                ),
                const Flexible(child: _CouponDialogContent()),
              ],
            ),
          ),
        ),
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
  late TextEditingController _voucherCtrl, _couponCtrl;
  late FocusNode _voucherFocusNode, _couponFocusNode;

  final BehaviorSubject<String> _amountTextChange = BehaviorSubject<String>();

  bool _isFormatting = false;

  RegExp removeChars = RegExp(r'[.,]');

  final _formKey = GlobalKey<FormState>();

  late ValueNotifier<String?> _messageWarning;
  late ValueNotifier<bool> _enableBtnAdd;

  bool useCoupon = DevConfig.useCoupon;

  @override
  void initState() {
    super.initState();
    _messageWarning = ValueNotifier<String?>(null);
    _enableBtnAdd = ValueNotifier<bool>(false);
    _voucherCtrl = TextEditingController();
    _voucherFocusNode = FocusNode();
    _couponCtrl = TextEditingController();
    _couponFocusNode = FocusNode();
    _couponCtrl.addListener(
      () {
        _clearText();
        _listenChangeAddButtonStatus();
      },
    );
    _voucherCtrl.addListener(
      () {
        _clearText();
        _listenChangeAddButtonStatus();
        if (_isFormatting) return;
        _amountTextChange.value = _voucherCtrl.text.trim();
      },
    );

    _amountTextChange.debounceTime(const Duration(milliseconds: 0)).distinct().listen((event) {
      _formatValue(event);
    });
  }

  void _clearText() {
    if (_couponFocusNode.hasFocus && _voucherCtrl.text.trim().isNotEmpty) {
      _voucherCtrl.text = '';
    }
    if (_voucherFocusNode.hasFocus && _couponCtrl.text.trim().isNotEmpty) {
      _couponCtrl.text = '';
    }
  }

  void _listenChangeAddButtonStatus() {
    if (useCoupon) {
      _enableBtnAdd.value = _couponCtrl.text.trim().isNotEmpty;
    } else {
      var coupons = ref.read(checkoutProvider).coupons;
      _enableBtnAdd.value = coupons.isEmpty &&
          _voucherCtrl.text.trim().isNotEmpty &&
          (_messageWarning.value?.trim() ?? '').isEmpty;
    }
  }

  void _formatValue(String data) {
    var type = ref.read(checkoutProvider).discountTypeSelect;

    final digits = data.replaceAll(removeChars, '');
    final number = int.tryParse(digits);
    if (number == null) return;

    final formatted =
        type == DiscountTypeEnum.percent ? digits : AppUtils.formatCurrency(value: number);
    _isFormatting = true;
    _voucherCtrl.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
    _isFormatting = false;
  }

  @override
  void dispose() {
    _messageWarning.dispose();
    _enableBtnAdd.dispose();
    _couponCtrl.dispose();
    _couponFocusNode.dispose();
    _voucherFocusNode.dispose();
    _voucherCtrl.dispose();
    _amountTextChange.close();
    super.dispose();
  }

  void _submit() async {
    var coupon = _couponCtrl.text.trim();
    var voucher = _voucherCtrl.text.trim();
    if (coupon.isEmpty && voucher.isEmpty) return;
    if ((_messageWarning.value ?? '').trim().isNotEmpty) return;
    if (_formKey.currentState?.validate() ?? false) {
      ({String? error, String? titleError}) result = (error: null, titleError: null);
      if (coupon.isNotEmpty) {
        result =
            await ref.read(checkoutProvider.notifier).addCoupon(code: coupon, fetchDataBill: true);
      } else if (voucher.isNotEmpty) {
        result = await ref.read(checkoutProvider.notifier).addVoucher(value: _getAmountValue());
      }
      if (result.error != null) {
        if (context.mounted) {
          showMessageDialog(
            context,
            message: result.error.toString(),
            title: result.titleError,
          );
        }
      } else {
        _couponCtrl.text = '';
        _voucherCtrl.text = '';
      }
    }
  }

  double _getAmountValue() {
    return double.tryParse(_voucherCtrl.text.trim().replaceAll(removeChars, '')) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        constraints: const BoxConstraints(minWidth: 300, minHeight: 500),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (useCoupon) ...[
              const Gap(12),
              const NumberOfAdultsWidget(),
              const Gap(12),
            ],
            Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(useCoupon ? 'Nhập mã giảm' : S.current.discount_title),
                      const Gap(8),
                      Consumer(builder: (context, ref, child) {
                        return SizedBox(
                          height: 56,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: useCoupon
                                    ? AppTextFormField(
                                        focusNode: _couponFocusNode,
                                        textController: _couponCtrl,
                                        hintText: S.current.inputCode,
                                        prefixIcon: const Icon(Icons.keyboard_alt_outlined),
                                      )
                                    : AppTextFormField(
                                        focusNode: _voucherFocusNode,
                                        textController: _voucherCtrl,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        textInputType: TextInputType.number,
                                        hintText: 'Nhập số tiền giảm giá hoặc % giảm',
                                        validator: (value) {
                                          var data = AppUtils.convertToDouble(value) ?? 0;
                                          String? error;
                                          var discountType =
                                              ref.read(checkoutProvider).discountTypeSelect;
                                          if (discountType == DiscountTypeEnum.percent &&
                                              data > 100.0) {
                                            error = S.current.error_percentage_exceed_limit;
                                          }
                                          WidgetsBinding.instance.addPostFrameCallback(
                                            (timeStamp) {
                                              _messageWarning.value = error;
                                              _listenChangeAddButtonStatus();
                                            },
                                          );
                                          return null;
                                        },
                                      ),
                              ),
                              if (!useCoupon) ...[
                                const Gap(8),
                                SizedBox(
                                  width: 100,
                                  height: 48,
                                  child: Consumer(builder: (context, ref, child) {
                                    var discountType = ref.watch(checkoutProvider
                                        .select((value) => value.discountTypeSelect));
                                    return CustomDropdownButton<DiscountTypeEnum>(
                                      data: DiscountTypeEnum.values,
                                      initData: [discountType],
                                      buildTextDisplay: (data) => data.title,
                                      onChangeData: (p0) {
                                        if (p0.isEmpty) return;
                                        ref
                                            .read(checkoutProvider.notifier)
                                            .onChangeDiscountTypeSelect(p0.first);
                                        _formatValue(_voucherCtrl.text.trim());
                                      },
                                    );
                                  }),
                                ),
                              ],
                              const Gap(8),
                              ValueListenableBuilder(
                                  valueListenable: _enableBtnAdd,
                                  builder: (context, value, child) {
                                    return AppButton(
                                      height: 56,
                                      textAction: S.current.confirm,
                                      color: AppColors.secondColor,
                                      onPressed: value ? _submit : null,
                                      disabledColor: Colors.grey.shade400,
                                    );
                                  }),
                            ],
                          ),
                        );
                      }),
                      ValueListenableBuilder(
                        valueListenable: _messageWarning,
                        builder: (context, value, child) {
                          if ((value ?? '').trim().isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return Text(
                            value ?? '',
                            style: AppTextStyle.regular(
                              color: AppColors.redColor,
                              rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Gap(8),
            const Expanded(
              child: CouponList(),
            ),
            const _CounponActionWidget()
          ],
        ),
      ),
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
        const AppCloseButton(),
        const Gap(12),
        AppButton(
          textAction: S.current.apply_policy_again,
          onPressed: () async {
            if (DevConfig.useCoupon) {
              var res = await ref
                  .read(checkoutProvider.notifier)
                  .applyCustomerPolicy(requireApply: true, showLoading: true, fetchDataBill: true);

              if (res != null && context.mounted) {
                showMessageDialog(
                  context,
                  message: res,
                );
              }
            } else {
              var res = await ref.read(checkoutProvider.notifier).applyVoucher();
              var removeFailed = res.removeFailed;
              var addFailed = res.addFailed;
              // xem xét có hiện các mã giảm giá xoá thât bại không?
              if (removeFailed.isNotEmpty || addFailed.isNotEmpty) {
                var message = 'Áp dụng lại mã giảm giá thất bại!';
                if (addFailed.isNotEmpty) {
                  Set<String> vouchers = {};
                  for (var e in addFailed) {
                    var discount = e.discount.firstOrNull;
                    if (discount != null) {
                      var type = discount.type;
                      vouchers.add((type == 1
                              ? AppUtils.getPercentValue(discount.amount)
                              : AppUtils.formatCurrency(value: discount.amount))
                          .toString());
                    }
                  }
                  if (vouchers.isNotEmpty) {
                    message += '\nVui lòng nhập lại các mã giảm giá sau: ';
                    message += vouchers.join(', ');
                  }
                }
                if (context.mounted) showMessageDialog(context, message: message);
              }
            }
          },
        ),
      ],
    );
  }
}

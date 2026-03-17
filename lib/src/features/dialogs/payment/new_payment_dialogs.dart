import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/dev_config.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/enum/print_type.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/note_for_waiter.dart';
import 'package:aladdin_franchise/src/features/dialogs/number_of_people.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/confirm_payment.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/edit_tax_dialog.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment/payment_method_dialog.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/view.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/widgets/image_bill_checker.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/widgets/image_bill_checker_copy.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/widgets/number_of_adults.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/components/custom_checkbox.dart';
import 'package:aladdin_franchise/src/features/pages/payoo/view.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_simple_loading.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/dialog/title_with_close_icon.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:aladdin_franchise/src/utils/show_snackbar.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rxdart/rxdart.dart';

class PaymentMethodSelectDialog extends ConsumerStatefulWidget {
  const PaymentMethodSelectDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PaymentMethodSelectDialogState();
}

class _PaymentMethodSelectDialogState
    extends ConsumerState<PaymentMethodSelectDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(checkoutProvider.notifier).getPaymentMethods();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xffF5F5F5),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TitleWithCloseIconDialog(
              title: 'Thanh toán',
              onPressedCloseBtn: () {
                pop(context);
                ref.read(homeProvider.notifier).unlockOrder();
              },
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _PaymentLeft(),
                  ),
                  const Gap(12),
                  Expanded(
                    flex: 1,
                    child: _PaymentRight(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hình thức thanh toán",
            style: AppTextStyle.bold(),
          ),
          const Gap(12),
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              var paymentMethods = ref.watch(
                  checkoutProvider.select((value) => value.paymentMethods));
              var paymentMethodSelect = ref.watch(checkoutProvider
                  .select((value) => value.paymentMethodSelect));
              var state = ref.watch(
                  checkoutProvider.select((value) => value.paymentMethodState));

              switch (state.status) {
                case PageCommonState.loading:
                  return Center(
                    child: AppSimpleLoadingWidget(
                      message: S.current.loading_payment_method_list,
                    ),
                  );
                case PageCommonState.error:
                  return Center(
                    child: AppErrorSimpleWidget(
                      onTryAgain: () {
                        ref.read(checkoutProvider.notifier).getPaymentMethods();
                      },
                      message: state.messageError,
                    ),
                  );
                case PageCommonState.normal:
                default:
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                        maxHeight: min(
                            56 * 3, (paymentMethods.length / 2).ceil() * 56)),
                    child: MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      itemCount: paymentMethods.length,
                      itemBuilder: (context, index) {
                        var method = paymentMethods[index];
                        return _PaymentMethodItem(
                          item: method,
                          icon: method.getIcon(),
                          selected: paymentMethodSelect == method,
                        );
                      },
                    ),
                  ),
                  Gap(8),
                  Divider(),
                  Expanded(
                    child: EditTaxDialog1(
                      isDialog: false,
                      notAllowTaxs:
                          (paymentMethodSelect?.requireEditTax ?? false)
                              ? [0.0]
                              : [],
                      // onCheckBeforeUpdate: (p0) {
                      //   return null;
                      //   // if (paymentMethodSelect == null) return null;
                      //   // return ref.read(checkoutProvider.notifier).checkTaxOrderItem(
                      //   //     paymentMethod: paymentMethodSelect, orderLineItems: p0);
                      // },
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _TaxSection extends ConsumerStatefulWidget {
  const _TaxSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __TaxSectionState();
}

class __TaxSectionState extends ConsumerState<_TaxSection> {
  Map<int, double> taxMap = {};
  Map<int, Map<String, dynamic>> taxChange = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: EditTaxDialog1(
            onSave: (value) {
              taxChange = value;
            },
            isDialog: false,
          ),
        ),
      ],
    );
  }
}

class InfoATMPayment extends ConsumerStatefulWidget {
  const InfoATMPayment({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InfoATMPaymentState();
}

class _InfoATMPaymentState extends ConsumerState<InfoATMPayment> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(checkoutProvider.notifier).getAtmPos();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final listAtmPosState =
        ref.watch(checkoutProvider.select((value) => value.listAtmPosState));
    final listAtmPos =
        ref.watch(checkoutProvider.select((value) => value.listAtmPos));
    final atmPosSelect =
        ref.watch(checkoutProvider.select((value) => value.atmPosSelect));

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (atmPosSelect != null) {
          if (listAtmPos.isNotEmpty) {
            var exist = listAtmPos.firstWhereOrNull((e) => e == atmPosSelect);
            if (exist == null) {
              ref.read(checkoutProvider.notifier).onChangeBankSelect(null);
            }
          } else if (listAtmPos.isEmpty) {
            ref.read(checkoutProvider.notifier).onChangeBankSelect(null);
          }
        }
      },
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Danh sách máy POS',
          style: AppTextStyle.bold(),
        ),
        const Gap(8),
        Expanded(
          child: Center(
            child: switch (listAtmPosState.status) {
              PageCommonState.loading =>
                const Center(child: AppLoadingSimpleWidget()),
              PageCommonState.error => Center(
                  child: AppErrorSimpleWidget(
                    message: "${S.current.error_loading_payment_QR_code}\n"
                        "${S.current.ex_problem}: ${listAtmPosState.messageError}",
                    onTryAgain: () {
                      ref.read(checkoutProvider.notifier).getAtmPos();
                    },
                  ),
                ),
              PageCommonState.success => listAtmPos.isEmpty
                  ? Text(S.current.no_data)
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 8),
                      itemCount: listAtmPos.length,
                      itemBuilder: (context, index) {
                        var item = listAtmPos[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(checkoutProvider.notifier)
                                  .onChangeAtmPosSelect(item);
                            },
                            borderRadius: AppConfig.borderRadiusMain,
                            child: Container(
                              constraints: const BoxConstraints(minWidth: 500),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: atmPosSelect == item
                                        ? AppColors.mainColor
                                        : Colors.grey.shade300),
                                borderRadius: AppConfig.borderRadiusMain,
                              ),
                              child: Text(item.name),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Gap(6),
                    ),
              PageCommonState.normal => const SizedBox.shrink()
            },
          ),
        ),
      ],
    );
  }
}

class InfoBankPayment extends ConsumerStatefulWidget {
  const InfoBankPayment({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InfoBankPaymentState();
}

class _InfoBankPaymentState extends ConsumerState<InfoBankPayment> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(checkoutProvider.notifier).getBanks();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bankState =
        ref.watch(checkoutProvider.select((value) => value.banksState));
    final banks = ref.watch(checkoutProvider.select((value) => value.banks));
    final bankSelect =
        ref.watch(checkoutProvider.select((value) => value.bankSelect));
    final invoice =
        ref.watch(checkoutProvider.select((value) => value.invoice));
    bool flagInvoice = invoice != null && !invoice.isEmpty();
    var banksView = banks
        .where((element) =>
            (element.useInvoice == null || element.useInvoice == flagInvoice))
        .toList();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (bankSelect != null) {
          if (banksView.isNotEmpty) {
            var exist = banksView.firstWhereOrNull((e) => e == bankSelect);
            if (exist == null) {
              ref.read(checkoutProvider.notifier).onChangeBankSelect(null);
            }
          } else if (banksView.isEmpty) {
            ref.read(checkoutProvider.notifier).onChangeBankSelect(null);
          }
        }
      },
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Danh sách tài khoản ngân hàng',
          style: AppTextStyle.bold(),
        ),
        Expanded(
          child: Center(
            child: switch (bankState.status) {
              PageCommonState.loading => const AppLoadingSimpleWidget(),
              PageCommonState.error => AppErrorSimpleWidget(
                  message: "${S.current.error_loading_payment_QR_code}\n"
                      "${S.current.ex_problem}: ${bankState.messageError}",
                  onTryAgain: () {
                    ref.read(checkoutProvider.notifier).getBanks();
                  },
                ),
              PageCommonState.success => banks.isEmpty
                  ? AppErrorSimpleWidget(
                      message: S.current.bank_account_not_setup,
                      textButton: S.current.reload,
                      onTryAgain: () {
                        ref.read(checkoutProvider.notifier).getBanks();
                      },
                    )
                  : banksView.isEmpty
                      ? Text(
                          '${S.current.bank_account}${flagInvoice == true ? ' ${S.current.invoice_support}' : ''} ${S.current.not_set_up}')
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              ...banksView.map(
                                (e) {
                                  return Card(
                                    elevation: 0,
                                    color: Colors.grey.shade100,
                                    child: ListTile(
                                      shape: AppConfig.shapeBorderMain,
                                      onTap: () {
                                        ref
                                            .read(checkoutProvider.notifier)
                                            .onChangeBankSelect(e);
                                      },
                                      title: e.title.isEmpty
                                          ? null
                                          : Text(
                                              e.title,
                                              style: AppTextStyle.regular(),
                                            ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.bankName,
                                            style: AppTextStyle.regular(
                                                color: Colors.black),
                                          ),
                                          Text(
                                            e.bankNumber,
                                            style: AppTextStyle.regular(),
                                          ),
                                        ],
                                      ),
                                      trailing: bankSelect == e
                                          ? const Icon(
                                              Icons.check_circle,
                                              color: AppColors.mainColor,
                                            )
                                          : null,
                                    ),
                                  );
                                },
                              ).toList(),
                              if (bankSelect != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: bankSelect.qrCode.trim().isEmpty
                                      ? Text(
                                          S.current.no_qr_code,
                                          style: AppTextStyle.regular(),
                                        )
                                      : ImageQRWidget(
                                          imgUrl: bankSelect.qrCode),
                                ),
                            ],
                          ),
                        ),
              PageCommonState.normal => const SizedBox.shrink()
            },
          ),
        ),
      ],
    );
  }
}

class ExtraInfoCashPayment extends ConsumerStatefulWidget {
  const ExtraInfoCashPayment({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExtraInfoCashPaymentState();
}

class _ExtraInfoCashPaymentState extends ConsumerState<ExtraInfoCashPayment> {
  late TextEditingController _receivedAmount;
  final BehaviorSubject<String> _receivedAmountTextChange =
      BehaviorSubject<String>();

  bool _isFormatting = false;

  @override
  void initState() {
    super.initState();
    _receivedAmount = TextEditingController();
    _receivedAmount.addListener(() {
      showLogs(_isFormatting, flags: '_isFormatting');
      if (_isFormatting) return;
      _receivedAmountTextChange.value = _receivedAmount.text;
    });
    _receivedAmountTextChange
        .debounceTime(const Duration(milliseconds: 0))
        .distinct()
        .listen((event) {
      final digits = event.replaceAll(RegExp(r'[.,]'), '');
      // if (digits.isEmpty) {
      //   // ref.read(homeProvider.notifier).onChangeCashReceivedAmount(0.0);
      //   return;
      // }

      final number = int.tryParse(digits);
      ref.read(checkoutProvider.notifier).onChangeCashReceivedAmount(0.0);
      if (number == null) return;

      final formatted = AppUtils.formatCurrency(value: number);

      _isFormatting = true;
      _receivedAmount.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
      ref
          .read(checkoutProvider.notifier)
          .onChangeCashReceivedAmount(number * 1.0);
      _isFormatting = false;
    });
  }

  @override
  void dispose() {
    _receivedAmount.dispose();
    _receivedAmountTextChange.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var totalPriceFinal = ref.watch(checkoutProvider
        .select((value) => value.dataBill.price.totalPriceFinal));

    var priceFinal = AppUtils.convertToDouble(totalPriceFinal) ?? 0;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "KHÁCH CẦN TRẢ",
                style: AppTextStyle.regular(color: Colors.grey),
              ),
              const Gap(12),
              Expanded(
                child: Text(
                  AppUtils.formatCurrency(
                    value: priceFinal,
                    symbol: 'đ',
                  ),
                  style: AppTextStyle.bold(
                    rawFontSize: AppConfig.defaultRawTextSize + 2.0,
                    color: Colors.orange,
                  ),
                ),
              )
            ],
          ),
          const Gap(12),
          Text(
            "Khách đưa",
            style: AppTextStyle.regular(color: Colors.grey),
          ),
          const Gap(8),
          AppTextFormField(
            textInputType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textController: _receivedAmount,
          ),
          StreamBuilder(
              stream: _receivedAmountTextChange,
              builder: (context, snapshot) {
                var value = AppUtils.convertToDouble(snapshot.data ?? '0') ?? 0;

                List<int> listOptions = priceFinal > 0
                    ? [
                        if (priceFinal > 0) priceFinal.toInt(),
                        (priceFinal / 100000.0).ceil() * 100000,
                      ]
                    : [];
                if (listOptions.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Wrap(
                    spacing: 8,
                    children: listOptions.map((e) {
                      bool selected = value == e;
                      return _MoneySuggestion(
                        text: e == priceFinal
                            ? 'Đủ tiền'
                            : AppUtils.formatCurrency(value: e),
                        selected: selected,
                        onTap: () {
                          _receivedAmount.text = e.toString();
                        },
                      );
                    }).toList(),
                  ),
                );
              }),
          StreamBuilder(
            stream: _receivedAmountTextChange,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox.shrink();
              var remain =
                  (AppUtils.convertToDouble(snapshot.data ?? '0') ?? 0) -
                      totalPriceFinal;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(12),
                  Text(
                    // remain < 0
                    //     ? 'TIỀN KHÁCH CẦN ĐƯA THÊM'
                    //     :
                    "TIỀN THỪA TRẢ KHÁCH",
                    style: AppTextStyle.regular(color: Colors.grey),
                  ),
                  const Gap(8),
                  Text(
                    AppUtils.formatCurrency(
                      value: remain,
                      symbol: 'đ',
                    ),
                    style: AppTextStyle.bold(
                      rawFontSize: AppConfig.defaultRawTextSize + 2.0,
                      color: Colors.green,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PaymentRight extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var price =
        ref.watch(checkoutProvider.select((value) => value.dataBill.price));
    var paymentMethodSelect = ref
        .watch(checkoutProvider.select((value) => value.paymentMethodSelect));
    var state =
        ref.watch(checkoutProvider.select((value) => value.paymentMethodState));
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Xác nhận thanh toán",
            style: AppTextStyle.bold(),
          ),
          const Gap(12),
          _RowInfo("Tổng tiền",
              AppUtils.formatCurrency(value: price.totalPrice, symbol: 'đ')),
          const Gap(10),
          _RowInfo("Thuế",
              AppUtils.formatCurrency(value: price.totalPriceTax, symbol: 'đ')),
          const Gap(10),
          _RowInfo(
              "Giảm giá",
              AppUtils.formatCurrency(
                  value: price.totalPriceVoucher, symbol: 'đ')),
          const Gap(10),
          _RowInfo(
              "Tổng tiền thanh toán",
              AppUtils.formatCurrency(
                  value: price.totalPriceFinal, symbol: 'đ')),
          // const Gap(10),
          // _RowInfo("Phương thức", paymentMethodSelect?.name ?? ''),
          Expanded(
            child: Column(
              children: [
                if (paymentMethodSelect?.isCash ?? false) ...[
                  Gap(8),
                  Divider(),
                  Expanded(
                    child: ExtraInfoCashPayment(),
                  ),
                ],
                if (paymentMethodSelect?.isBank ?? false) ...[
                  Divider(),
                  Expanded(
                    child: InfoBankPayment(),
                  ),
                ],
                if (paymentMethodSelect?.isAtm ?? false) ...[
                  Divider(),
                  Expanded(
                    child: InfoATMPayment(),
                  ),
                ],
                if (paymentMethodSelect?.isGateway ?? false) ...[
                  const Gap(20),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          S.current.payment_method_open_gateway,
                          style: AppTextStyle.bold(
                            color: AppColors.redColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(4),
                        Text(
                          'Vui lòng kiểm tra tổng tiền khách cần thanh toán trước khi tiếp tục!',
                          style: AppTextStyle.regular(
                              rawFontSize: AppConfig.defaultRawTextSize - 1.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          Consumer(builder: (context, ref, child) {
            var orderLineItems = ref.watch(checkoutProvider
                .select((value) => value.dataBill.orderLineItems));
            var dataBillState = ref
                .watch(checkoutProvider.select((value) => value.dataBillState));
            var atmPosSelect = ref
                .watch(checkoutProvider.select((value) => value.atmPosSelect));
            var bankSelect =
                ref.watch(checkoutProvider.select((value) => value.bankSelect));
            var validatePaymentMethod = onCheckValidPaymentMethod(ref);
            String? validateTax = paymentMethodSelect == null
                ? null
                : ref.read(checkoutProvider.notifier).checkTaxOrderItem(
                    paymentMethod: paymentMethodSelect,
                    orderLineItems: orderLineItems);
            bool enable = paymentMethodSelect != null &&
                validatePaymentMethod.error == null &&
                validateTax == null &&
                dataBillState.status == PageCommonState.success &&
                ((paymentMethodSelect.isAtm && atmPosSelect != null) ||
                    (paymentMethodSelect.isBank && bankSelect != null ||
                        (!paymentMethodSelect.isAtm &&
                            !paymentMethodSelect.isBank)));

            List<String> messages = [
              if (validatePaymentMethod.error != null)
                validatePaymentMethod.error!,
              if (validateTax != null) validateTax,
              if ((paymentMethodSelect?.isAtm ?? false) && atmPosSelect == null)
                'Vui lòng chọn máy cà thẻ trước khi tiếp tục',
              if ((paymentMethodSelect?.isBank ?? false) && bankSelect == null)
                'Vui lòng chọn ngân hàng thanh toán khi tiếp tục',
            ];

            return Column(
              children: [
                if (messages.isNotEmpty) ...[
                  Tooltip(
                    message: messages.join('\n'),
                    child: Text(
                      messages.join('\n'),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.regular(
                          rawFontSize: AppConfig.defaultRawTextSize - 1.0),
                    ),
                  ),
                  const Gap(8),
                ],
                switch (dataBillState.status) {
                  PageCommonState.loading => AppLoadingLineWidget(
                      message: 'Đang tải thông tin thanh toán'),
                  PageCommonState.error => Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: AppErrorSimpleWidget(
                        message: dataBillState.messageError,
                        onTryAgain: () {
                          ref.read(checkoutProvider.notifier).getDataBill();
                        },
                      ),
                    ),
                  PageCommonState.normal => const SizedBox.shrink(),
                  PageCommonState.success => const SizedBox.shrink(),
                },
                AppButton(
                  minWidth: double.infinity,
                  textAction: 'Hoàn tất đơn bàn',
                  onPressed: !enable
                      ? null
                      : () async {
                          var totalPriceFinal = ref
                              .read(checkoutProvider)
                              .dataBill
                              .price
                              .totalPriceFinal;

                          /// với cà thẻ động (setting = 2) thì gửi lệnh tới máy cà trước khi tiếp tục
                          if (paymentMethodSelect.isAtm) {
                            if (atmPosSelect == null) return;
                            if (atmPosSelect.setting == 2) {
                              var action = await showConfirmAction(
                                context,
                                message: 'Nhấn “Tiếp tục” để chuẩn bị cà thẻ.\n'
                                    'Khi máy sẵn sàng, vui lòng đưa thẻ vào POS.\n'
                                    'Số tiền thanh toán là: ${AppUtils.formatCurrency(value: totalPriceFinal, symbol: 'đ')}',
                                actionTitle: S.current.continue_text,
                              );
                              if (action != true) return;
                              var resultPos = await ref
                                  .read(checkoutProvider.notifier)
                                  .dynamicAtmPosCallback();
                              if (resultPos != null) {
                                if (context.mounted)
                                  showMessageDialog(context,
                                      message: resultPos);
                                return;
                              }
                            }
                          } else if (paymentMethodSelect.isGateway) {
                            // với gateway thì cần phải mở cổng thanh toán
                            onLoadPaymentGateway(context, ref);
                            return;
                          }

                          showMoreInfoPayment(context);
                        },
                  icon: Icons.check_circle_outline,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  ({List<CustomerPolicyModel> coupons, String? error})
      onCheckValidPaymentMethod(WidgetRef ref) {
    var state = ref.read(checkoutProvider);
    try {
      // updateEvent(HomeEvent.checkPaymentMethod);
      if (state.coupons.isEmpty) {
        // updateEvent(HomeEvent.normal);
        return (coupons: [], error: null);
      }
      List<CustomerPolicyModel> couponInvalidResult = [];
      // kiểm tra với danh sách giảm giá đang có
      for (final c in state.coupons) {
        if (c.paymentNotAllowed
            .any((element) => element.key == state.paymentMethodSelect?.key)) {
          couponInvalidResult.add(c);
        }
      }
      // updateEvent(HomeEvent.normal);
      if (couponInvalidResult.isNotEmpty) {
        return (
          coupons: couponInvalidResult,
          error: S.current.msg_coupons_invalid_with_payment_method(
              couponInvalidResult.length.toString(),
              couponInvalidResult.join(','),
              state.paymentMethodSelect?.name.toUpperCase() ?? ''),
          // "Có ${couponInvalidResult.length} mã giảm giá ${couponInvalidResult.join(',')}"
          // " không được phép dùng với PTTT (${method.name.toUpperCase()}).\n"
          // " Vui lòng xoá bỏ mã hoặc chọn phương thức thanh toán khác!"
        );
      }
      return (coupons: [], error: null);
    } catch (ex) {
      // updateEvent(HomeEvent.normal);
      return (
        coupons: [],
        error: "${S.current.can_not_check_payment_method}\n${ex.toString()}"
      );
    }
  }
}

void onLoadPaymentGateway(BuildContext context, WidgetRef ref) async {
  final result = await ref.read(checkoutProvider.notifier).getPaymentGateway();
  if (result.url != null) {
    final state = ref.read(homeProvider);
    // List<ProductCheckoutModel> sortProductCheckout = [];
    // state.productsSelecting.forEach((element) {
    //   var p = state.productCheckout
    //       .firstWhereOrNull((e) => e?.id == element?.id);
    //   if (p != null) {
    //     var exist = sortProductCheckout
    //         .firstWhereOrNull((e) => e.id == element?.id);
    //     if (exist == null) {
    //       sortProductCheckout.add(p);
    //     }
    //   }
    // });
    // ref.read(homeProvider.notifier).syncInfoCustomerPage(
    //   method: WindowsMethodEnum.payoo,
    //   arguments: {
    //     'expire_time':
    //         max(0, (((result.expiryMin ?? 0) * 60).toInt()) - 5),
    //     'url': result.qr,
    //   },
    // );
    var pmSelect = ref.read(checkoutProvider).paymentMethodSelect;
    if (pmSelect == null) return;
    if (!context.mounted) return;
    final paymentResult = await push(
      context,
      PaymentGatewayPage(
        paymentMethod: pmSelect,
        gatewayUrl: result.url!,
        qr: result.qr ?? '',
        order: ref.read(homeProvider).orderSelect!,
      ),
    );
    showLogs(paymentResult, flags: 'paymentResult');
    if (paymentResult != null && paymentResult.status == true) {
      ref.read(checkoutProvider.notifier).updatePaymentGatewayInfo(
            status: paymentResult.status,
            amount: paymentResult.amount,
          );

      // ref.read(homeProvider.notifier).syncInfoCustomerPage(
      //   method: WindowsMethodEnum.payoo,
      //   arguments: {
      //     'expire_time': 0,
      //     'url': '',
      //   },
      // );
      // if (context.mounted) {
      //   await showMessageDialog(
      //     context,
      //     message: S.current.paid_order,
      //   );
      // }
      if (context.mounted) showMoreInfoPayment(context);
    } else {
      ref.read(checkoutProvider.notifier).resetPaymentInfo();
      if (context.mounted) {
        showMessageDialog(
          context,
          message: S.current.unpaid_order_select_payment_method_again,
        );
      }
    }
  } else {
    /// 407 Đơn bàn đã được thanh toán bởi cổng thanh toán này
    if (result.statusCode == 407) {
      // await showConfirmAction(
      //   context,
      //   //title: 'Đơn bàn đã được khách hàng thanh toán, vui lòng Hoàn tất thanh toán!',
      //   message: "${result.error}",
      //   notCancel: true,
      //   action: () {
      //     ref.read(homeProvider.notifier).updatePaymentGatewayInfo(
      //           status: true,
      //           amount: 0.0,
      //           usePriceDataBillForAmount: true,
      //         );

      //     showConfirmCompleteBillDialog(
      //       context,
      //       ref,
      //     );
      //   },
      // );
    } else {
      if (context.mounted) {
        await showConfirmAction(
          context,
          title: S.current.failed_load_gateway_url,
          message: "${result.error}",
          actionTitle: S.current.tryAgain,
          action: () {
            onLoadPaymentGateway(context, ref);
          },
        );
      }
    }
  }
}

void showMoreInfoPayment(
  BuildContext context, {
  bool allowCancelPayment = true,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return CompletePaymentDialog(allowCancelPayment: allowCancelPayment);
    },
  );
}

class CompletePaymentDialog extends ConsumerWidget {
  const CompletePaymentDialog({super.key, this.allowCancelPayment = true});
  final bool allowCancelPayment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 520,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleWithCloseIconDialog(
              title: "Hoàn tất thanh toán",
              notClose: !allowCancelPayment,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Bạn có muốn hoàn thành và in bill hay không?",
                style: AppTextStyle.regular(color: Colors.grey),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(16),
                    _SectionTitle("Ảnh đính kèm"),
                    const Gap(8),
                    ImageBillCheckerWidget1(),
                    const Gap(16),
                    Consumer(
                      builder: (context, ref, child) {
                        var checked = ref.watch(checkoutProvider
                            .select((value) => value.printNumberOfPeople));
                        return GestureDetector(
                          onTap: ref
                              .read(checkoutProvider.notifier)
                              .onChangePrintNumberOfPeople,
                          child: Row(
                            children: [
                              CustomCheckbox(
                                onChange: ref
                                    .read(checkoutProvider.notifier)
                                    .onChangePrintNumberOfPeople,
                                checked: checked,
                              ),
                              const Gap(4),
                              Flexible(
                                child: Text(
                                  'In số người khi hoàn thành đơn',
                                  style: AppTextStyle.regular(),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const Gap(16),
                    _SectionTitle("Số lượng người"),
                    const Gap(16),
                    NumberOfAdultsWidget(),
                    const Gap(12),
                    SpinBox(
                      min: 0,
                      max: 200,
                      incrementIcon: const Icon(CupertinoIcons.add),
                      decrementIcon: const Icon(CupertinoIcons.minus),
                      textStyle: AppTextStyle.bold(),
                      value: ref
                          .watch(checkoutProvider
                              .select((value) => value.numberOfChildren))
                          .toDouble(),
                      decoration: InputDecoration(
                        label: Text(
                          S.current.number_of_children,
                          style: AppTextStyle.regular(),
                        ),
                      ),
                      onChanged: (value) {
                        ref
                            .read(checkoutProvider.notifier)
                            .onChangeNumberOfPeople(
                              numberOfChildren: value.toInt(),
                            );
                      },
                    ),
                    const Gap(16),
                    _SectionTitle("Ghi chú"),
                    const Gap(8),
                    AppTextFormField(
                      label: null,
                      minLines: 2,
                      maxLines: 5,
                      multiLine: true,
                      textInputAction: TextInputAction.newline,
                      hintText: S.current.enter_note_content,
                      initialValue: ref.read(checkoutProvider).completeNote,
                      onChanged: (value) {
                        ref
                            .read(checkoutProvider.notifier)
                            .onChangeCompleteNote(value.trim());
                      },
                    ),
                    const Gap(16),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (allowCancelPayment)
                  AppCloseButton(
                    onPressed: () async {
                      // if (!allowCancelPayment) {
                      //   var confirm = await showConfirmAction(
                      //     context,
                      //     message:
                      //         'Giao dịch cà thẻ đã được hệ thống ghi nhận. Vui lòng hoàn thành đơn. Hoặc, '
                      //         'nếu bạn không tiếp tục hoàn thành đơn này, thì khi thực hiện hoàn thành đơn với ATM thu ngân không cần nhập số tiền trên máy thì có thể bị tính 2 lần.'
                      //         'Bạn vẫn muốn tiếp tục ĐÓNG không?',
                      //   );
                      //   if (confirm == true) {
                      //     pop(context);
                      //   }
                      //   return;
                      // }
                      pop(context);
                    },
                  ),
                AppButton(
                  textAction: "Hoàn thành & In bill",
                  onPressed: () async {
                    var confirm = await showConfirmAction(
                      context,
                      message:
                          'Vui lòng kiểm tra và xác nhận khách hàng đã thanh toán hay chưa.\n'
                          'Nếu đã thanh toán, bạn có thể đính kèm hình ảnh biên lai để đối chiếu trước khi xác nhận.',
                      actionTitle: S.current.continue_text,
                    );
                    if (confirm == true && context.mounted) {
                      onConfirmPayment(context: context, ref: ref);
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/// tạm tính + hoàn thành đơn
///
/// [notAllowCancelPayment] = false - bắt buộc phải tạm tính bill (chỉ với cà thẻ động thành công)
///
void onConfirmPayment({
  required WidgetRef ref,
  required BuildContext context,
  bool notAllowCancelPayment = false,
}) async {
  final result = await ref.read(checkoutProvider.notifier).onPayment(context);
  if (result.errorType != null) {
    showLogs(result.errorType, flags: 'result.errorType');
    switch (result.errorType!) {
      case HomePaymentError.temp:
        if (notAllowCancelPayment) {
          await showMessageDialog(context,
              message:
                  '${S.current.payment_done_but_not_complete_order}\n${S.current.ex_problem}: ${result.msg}',
              textAction: S.current.tryAgain);
          onConfirmPayment(
            context: context,
            ref: ref,
            notAllowCancelPayment: notAllowCancelPayment,
          );
          break;
        }
        await showMessageDialog(context, message: result.msg);
        // ref.read(homeProvider.notifier).syncInfoCustomerPage(
        //       method: WindowsMethodEnum.payment,
        //       arguments: PaymentStatusEnum.cancel.name,
        //     );

        break;
      case HomePaymentError.complete:
        onConfirmCompleteAgain(
          ref: ref,
          context: context,
          errorMessage: result.msg,
          printers: result.tmpPrinters,
        );
        break;
      case HomePaymentError.printCompleteError:
        if (result.requestPrint != null) {
          await showConfirmAction(
            context,
            message: 'Đơn đã được hoàn thành\n\n'
                'Tuy nhiên, hệ thống chưa nhận được yêu cầu in.\n'
                'Bạn có muốn gửi lệnh trực tiếp tới máy in không?',
            actionTitle: 'In ngay',
            textCancel: 'Đóng',
            title: 'Thông báo',
            action: () {
              ref.read(homeProvider.notifier).sendPrintData(
                    type: PrintTypeEnum.payment,
                    printDirectly: true,
                    paymentData: result.requestPrint,
                  );
            },
          );
        }
        for (int i = 0; i < (2 + (openCheckoutPage ? 1 : 0)); i++) {
          pop(context);
        }

        showDoneSnackBar(
          context: context,
          message: S.current.payment_success,
        );
        ref.invalidate(tablesAndOrdersProvider);

        ref.read(homeProvider.notifier).changeOrderSelect(null);
        break;

      default:
    }
  } else {
    for (int i = 0; i < (2 + (openCheckoutPage ? 1 : 0)); i++) {
      pop(context);
    }

    showDoneSnackBar(
      context: context,
      message: S.current.payment_success,
    );
    ref.invalidate(tablesAndOrdersProvider);

    ref.read(homeProvider.notifier).changeOrderSelect(null);
  }
}

// đã tạm tính nhưng hoàn thành lại lỗi
void onConfirmCompleteAgain({
  required WidgetRef ref,
  required BuildContext context,
  String? errorMessage,
  List<IpOrderModel> printers = const [],
}) async {
  await showConfirmAction(
    context,
    message: '${S.current.pending_order_requried_complete_order}'
        '\nMã đơn: ${ref.read(homeProvider).orderSelect?.getOrderMisc()}'
        '${(errorMessage ?? '').trim().isNotEmpty ? '\n\nSự cố: $errorMessage' : ''}',
    actionTitle: S.current.completed,
    notCancel: false,
    action: () async {
      var res = await ref.read(checkoutProvider.notifier).completeBill(
            context: context,
            printKitchenBill: true,
            printers: printers,
          );
      if (res.error != null) {
        onConfirmCompleteAgain(
            ref: ref, context: context, errorMessage: res.error);
        return;
      }
      if (res.errorSendPrint != null) {
        if (res.requestPrint != null) {
          await showConfirmAction(
            context,
            message: 'Đơn đã được hoàn thành\n\n'
                'Tuy nhiên, hệ thống chưa nhận được yêu cầu in.\n'
                'Bạn có muốn gửi lệnh trực tiếp tới máy in không?',
            actionTitle: 'In ngay',
            textCancel: 'Đóng',
            title: 'Thông báo',
            action: () {
              ref.read(homeProvider.notifier).sendPrintData(
                    type: PrintTypeEnum.payment,
                    printDirectly: true,
                    paymentData: res.requestPrint,
                  );
            },
          );
        }
      }
      for (var i = 0; i < 2 + (openCheckoutPage ? 1 : 0); i++) {
        pop(context);
      }

      ref.invalidate(tablesAndOrdersProvider);

      ref.read(homeProvider.notifier).changeOrderSelect(null);
    },
    actionCancel: () {
      for (var i = 0; i < 2 + (openCheckoutPage ? 1 : 0); i++) {
        pop(context);
      }
      ref.invalidate(tablesAndOrdersProvider);

      ref.read(homeProvider.notifier).changeOrderSelect(null);
    },
    textCancel: S.current.another_time,
  );
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: AppTextStyle.bold(),
      ),
    );
  }
}

class _PaymentMethodItem extends ConsumerWidget {
  final PaymentMethod item;
  final IconData? icon;
  final bool selected;

  const _PaymentMethodItem({
    required this.item,
    this.icon,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        if (selected) return;
        ref.read(checkoutProvider.notifier).onChangePaymentMethodSelect(item);
      },
      borderRadius: AppConfig.borderRadiusMain,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: selected ? const Color(0xffE8F6ED) : Colors.grey.shade100,
          borderRadius: AppConfig.borderRadiusMain,
          border: Border.all(
            color: selected ? Colors.green : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon),
              const Gap(8),
            ],
            Text(
              item.name,
              style: AppTextStyle.bold(),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoneySuggestion extends StatelessWidget {
  const _MoneySuggestion({
    super.key,
    required this.text,
    this.onTap,
    this.selected = false,
  });

  final String text;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppConfig.borderRadiusSecond,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.mainColor : Colors.grey.shade200,
          borderRadius: AppConfig.borderRadiusSecond,
        ),
        child: Text(
          text,
          style: AppTextStyle.regular(
            color: selected ? Colors.white : null,
          ),
        ),
      ),
    );
  }
}

class _RowInfo extends StatelessWidget {
  final String title;
  final String value;
  final Color? color;

  const _RowInfo(this.title, this.value, {this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        )
      ],
    );
  }
}

BoxDecoration _boxDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
      )
    ],
  );
}

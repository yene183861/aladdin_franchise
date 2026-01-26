import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';
import 'package:aladdin_franchise/src/utils/field_validation.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> showCreateInvoiceOrderDialog(BuildContext context,
    {OrderInvoice? orderInvoice}) async {
  await showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (context) => _CreateInvoiceOrderDialog(orderInvoice: orderInvoice),
  );
}

class _CreateInvoiceOrderDialog extends ConsumerStatefulWidget {
  const _CreateInvoiceOrderDialog({
    super.key,
    this.orderInvoice,
  });
  final OrderInvoice? orderInvoice;
  @override
  ConsumerState createState() => __CreateInvoiceOrderDialogState();
}

class __CreateInvoiceOrderDialogState extends ConsumerState<_CreateInvoiceOrderDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController ctrlName,
      ctrlTax,
      ctrlCompanyName,
      ctrlAddress,
      ctrlEmail,
      ctrlBank,
      ctrlBankNumber,
      ctrlPhone,
      ctrlDvqhnsCode,
      ctrlCCCD;

  late ValueNotifier<String?> errorTaxCode;
  late ValueNotifier<bool> requireTaxCode;
  late ValueNotifier<bool> requireData;

  @override
  void initState() {
    super.initState();
    ctrlName = TextEditingController();
    ctrlTax = TextEditingController();
    ctrlCompanyName = TextEditingController();
    ctrlAddress = TextEditingController();
    ctrlEmail = TextEditingController();
    ctrlBank = TextEditingController();
    ctrlBankNumber = TextEditingController();
    ctrlPhone = TextEditingController();
    ctrlDvqhnsCode = TextEditingController();
    ctrlCCCD = TextEditingController();
    errorTaxCode = ValueNotifier<String?>(null);
    requireTaxCode = ValueNotifier<bool>(true);
    requireData = ValueNotifier<bool>(true);
    _onChangeUI(widget.orderInvoice);
  }

  @override
  void dispose() {
    ctrlName.dispose();
    ctrlTax.dispose();
    ctrlCompanyName.dispose();
    ctrlAddress.dispose();
    ctrlEmail.dispose();
    ctrlBank.dispose();
    ctrlBankNumber.dispose();
    ctrlPhone.dispose();
    ctrlDvqhnsCode.dispose();
    ctrlCCCD.dispose();
    errorTaxCode.dispose();
    requireTaxCode.dispose();
    requireData.dispose();
    super.dispose();
  }

  _listenOrderInvoice(BuildContext context, WidgetRef ref) =>
      (OrderInvoice? previous, OrderInvoice? next) {
        _onChangeUI(next);
      };

  void _onChangeUI(OrderInvoice? invoice) {
    ctrlName.text = invoice?.name ?? '';
    ctrlTax.text = invoice?.taxCode ?? '';
    ctrlCompanyName.text = invoice?.companyName ?? '';
    ctrlAddress.text = invoice?.address ?? '';
    ctrlEmail.text = invoice?.email ?? '';
    ctrlBank.text = invoice?.bank ?? '';
    ctrlBankNumber.text = invoice?.accountNumber ?? '';
    ctrlPhone.text = invoice?.phone ?? '';
    ctrlDvqhnsCode.text = invoice?.maDvqhns ?? '';
    ctrlCCCD.text = invoice?.cccdan ?? '';

    requireData.value = invoice?.isValidate ?? true;
    requireTaxCode.value = invoice?.maDvqhns.isEmpty ?? true;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<OrderInvoice?>(
      checkoutPageProvider.select((value) => value.invoice),
      _listenOrderInvoice(context, ref),
    );
    var lockedOrder = ref.watch(homeProvider.select((value) => value.lockedOrder));
    bool enable = !lockedOrder;
    bool isMobile = AppDeviceSizeUtil.checkMobileDevice();
    return AlertDialog(
      title: Row(
        children: [
          Expanded(
            child: Text(
              widget.orderInvoice == null
                  ? S.current.add_invoice_information
                  : S.current.update_invoice_information,
              style: AppTextStyle.bold(rawFontSize: AppConfig.defaultRawTextSize + 1.0),
            ),
          ),
          const CloseButton(),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      actionsPadding: const EdgeInsets.all(16),
      content: SizedBox(
        width: isMobile ? 95.w : 50.w,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const GapH(8),
                AppTextFormField(
                  label: "${S.current.firstName} & ${S.current.lastName}",
                  textInputAction: TextInputAction.next,
                  textController: ctrlName,
                  enabled: enable,
                ),
                const GapH(12),
                SizedBox(
                  height: 58,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ValueListenableBuilder(
                            valueListenable: requireTaxCode,
                            builder: (context, require, child) {
                              return AppTextFormField(
                                label: S.current.tax_code,
                                textInputAction: TextInputAction.next,
                                textController: ctrlTax,
                                required: require,
                                enabled: enable,
                                validator: (value) {
                                  if (require) {
                                    var check = FieldValidationUtils.checkRequired(value);
                                    WidgetsBinding.instance.addPostFrameCallback(
                                      (timeStamp) {
                                        errorTaxCode.value = check;
                                      },
                                    );
                                  }
                                  return null;
                                },
                              );
                            }),
                      ),
                      const Gap(12),
                      AppButton(
                        onPressed: () => _onSearchTax(),
                        textAction: S.current.search,
                        color: AppColors.secondColor,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ValueListenableBuilder(
                      valueListenable: errorTaxCode,
                      builder: (context, value, child) {
                        if ((value ?? '').trim().isEmpty) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            (value ?? '').trim(),
                            style: AppTextStyle.regular(color: AppColors.redColor),
                          ),
                        );
                      }),
                ),
                const Gap(12),
                AppTextFormField(
                  textController: ctrlDvqhnsCode,
                  label: S.current.budget_relationship_unit_code,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  enabled: enable,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(7),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    }
                    if (value.length != 7) {
                      return 'Mã không hợp lệ. Mã phải có 7 chữ số';
                    }

                    return null;
                  },
                  onChanged: (text) {
                    WidgetsBinding.instance.addPostFrameCallback(
                      (timeStamp) {
                        requireTaxCode.value = text.trim().isEmpty;
                      },
                    );
                  },
                ),
                const GapH(12),
                AppTextFormField(
                  textController: ctrlCCCD,
                  label: S.current.citizen_id_card,
                  textInputAction: TextInputAction.next,
                  enabled: enable,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(12),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    }
                    if (![9, 12].contains(value.length)) {
                      return 'Không hợp lệ. Mã phải là 9 hoặc 12 số';
                    }
                    return null;
                  },
                ),
                const GapH(12),
                AppTextFormField(
                  textController: ctrlCompanyName,
                  label: S.current.company_name,
                  textInputAction: TextInputAction.next,
                  required: true,
                  enabled: enable,
                  validator: (value) => FieldValidationUtils.checkRequired(value),
                ),
                const GapH(12),
                AppTextFormField(
                  textController: ctrlAddress,
                  label: S.current.address,
                  multiLine: true,
                  textInputAction: TextInputAction.next,
                  required: true,
                  enabled: enable,
                  validator: (value) => FieldValidationUtils.checkRequired(value),
                ),
                const GapH(12),
                ValueListenableBuilder(
                    valueListenable: requireData,
                    builder: (context, require, child) {
                      return AppTextFormField(
                        key: UniqueKey(),
                        label: S.current.email,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.emailAddress,
                        textController: ctrlEmail,
                        required: require,
                        enabled: enable,
                        validator: (value) {
                          return require ? FieldValidationUtils.validateEmail(value) : null;
                        },
                      );
                    }),
                // AppTextFormField(
                //   textController: ctrlEmail,
                //   label: S.current.email,
                //   textInputAction: TextInputAction.next,
                //   textInputType: TextInputType.emailAddress,
                //   required: isRequiredData,
                //   enabled: enable,
                //   validator:
                //       isRequiredData ? (value) => FieldValidationUtils.validateEmail(value) : null,
                // ),
                const GapH(12),
                AppTextFormField(
                  textController: ctrlBank,
                  label: S.current.bank,
                  textInputAction: TextInputAction.next,
                  enabled: enable,
                ),
                const GapH(12),
                AppTextFormField(
                  textController: ctrlBankNumber,
                  label: S.current.bank_number,
                  textInputAction: TextInputAction.next,
                  enabled: enable,
                ),
                const GapH(12),
                ValueListenableBuilder(
                    valueListenable: requireData,
                    builder: (context, require, child) {
                      return AppTextFormField(
                        key: UniqueKey(),
                        textController: ctrlPhone,
                        label: S.current.phone,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.number,
                        required: require,
                        enabled: enable,
                        maxLength: 12,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (value) {
                          return require ? FieldValidationUtils.checkRequired(value) : null;
                        },
                      );
                    }),
                // AppTextFormField(
                //   textController: ctrlPhone,
                //   label: S.current.phone,
                //   textInputAction: TextInputAction.done,
                //   textInputType: TextInputType.number,
                //   enabled: enable,
                //   required: isRequiredData,
                //   validator:
                //       isRequiredData ? (value) => FieldValidationUtils.checkRequired(value) : null,
                //   maxLength: 12,
                //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                // ),
                // const GapH(12),
              ],
            ),
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        Consumer(
          builder: (context, ref, child) {
            var invoice = ref.watch(checkoutPageProvider.select((value) => value.invoice));
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const AppCloseButton(),
                if (!(invoice?.isEmpty() ?? true))
                  AppButton(
                    onPressed: () async {
                      showConfirmAction(
                        context,
                        message: 'Bạn có chắc chắn muốn xoá thông tin hoá đơn?',
                        action: () async {
                          await ref.read(checkoutPageProvider.notifier).onUpdateOrderInvoice(
                                const OrderInvoice(),
                                isUpdate: widget.orderInvoice != null,
                              );
                        },
                      );
                    },
                    color: AppColors.secondColor,
                    textAction: S.current.delete_info,
                  ),
                AppButton(onPressed: _onConfirm),
              ],
            );
          },
        ),
      ],
    );
  }

  Future<void> _onSearchTax() async {
    final String taxCode = ctrlTax.text.trim();
    if (taxCode.isNotEmpty) {
      final result = await ref.read(checkoutPageProvider.notifier).searchTaxCodeInfo(taxCode);
      final minvoice = result.mInvoiceInfo;
      final error = result.error;
      if (minvoice != null) {
        ctrlName.text = minvoice.name;
        ctrlCompanyName.text = minvoice.companyName;
        ctrlAddress.text = minvoice.address;
        ctrlEmail.text = minvoice.email;
        ctrlBank.text = minvoice.bank;
        ctrlBankNumber.text = minvoice.accountNumber;
        ctrlPhone.text = minvoice.phone;

        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            requireData.value = minvoice.isValidate;
          },
        );
      } else {
        if (context.mounted) {
          showMessageDialog(
            context,
            message: error.toString(),
          );
        }
      }
    }
  }

  Future<void> _onConfirm() async {
    if (_formKey.currentState!.validate()) {
      if ((errorTaxCode.value ?? '').trim().isNotEmpty) return;
      final OrderInvoice invoice = OrderInvoice(
        name: ctrlName.text.trim(),
        taxCode: ctrlTax.text.trim(),
        companyName: ctrlCompanyName.text.trim(),
        address: ctrlAddress.text.trim(),
        email: ctrlEmail.text.trim(),
        bank: ctrlBank.text.trim(),
        accountNumber: ctrlBankNumber.text.trim(),
        phone: ctrlPhone.text.trim(),
        isValidate: requireData.value,
        maDvqhns: ctrlDvqhnsCode.text.trim(),
        cccdan: ctrlCCCD.text.trim(),
      );
      await ref.read(checkoutPageProvider.notifier).onUpdateOrderInvoice(
            invoice,
            isUpdate: widget.orderInvoice != null,
          );
    }
  }
}

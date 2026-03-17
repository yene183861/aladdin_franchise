import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/dialog/title_with_close_icon.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';
import 'package:aladdin_franchise/src/utils/field_validation.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void showInvoiceFormDialog(BuildContext context) async {
  await showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (context) => const _InvoiceForm(),
  );
}

class _InvoiceForm extends ConsumerStatefulWidget {
  const _InvoiceForm();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __InvoiceFormState();
}

class __InvoiceFormState extends ConsumerState<_InvoiceForm> {
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
  bool isRequiredData = true;
  bool isRequiredTaxCode = true;
  bool initInfoSuccess = false;

  late ValueNotifier<String?> errorTaxCode;

  @override
  void initState() {
    super.initState();
    errorTaxCode = ValueNotifier<String?>(null);
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
  }

  void _mapInvoiceData(OrderInvoice? invoice) {
    if (ref.read(checkoutProvider).invoiceState.status == PageCommonState.success) {
      initInfoSuccess = true;
    }
    if (invoice == null || invoice.isEmpty()) return;

    ctrlName.text = invoice.name;
    ctrlTax.text = invoice.taxCode;
    ctrlCompanyName.text = invoice.companyName;
    ctrlAddress.text = invoice.address;
    ctrlEmail.text = invoice.email;
    ctrlBank.text = invoice.bank;
    ctrlBankNumber.text = invoice.accountNumber;
    ctrlPhone.text = invoice.phone;
    ctrlDvqhnsCode.text = invoice.maDvqhns;
    ctrlCCCD.text = invoice.cccdan;
    setState(() {
      isRequiredTaxCode = invoice.maDvqhns.isEmpty;
    });
  }

  @override
  void dispose() {
    errorTaxCode.dispose();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool enable = true;
    bool isMobile = AppDeviceSizeUtil.checkMobileDevice();

    var invoice = ref.watch(checkoutProvider.select((value) => value.invoice));
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (initInfoSuccess) return;
        _mapInvoiceData(invoice);
      },
    );
    return AlertDialog(
      title: TitleWithCloseIconDialog(
        title: (invoice == null || invoice.isEmpty())
            ? S.current.add_invoice_information
            : S.current.update_invoice_information,
      ),
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      content: SizedBox(
        width: isMobile ? 95.w : 50.w,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    var state = ref.watch(checkoutProvider.select((value) => value.invoiceState));
                    switch (state.status) {
                      case PageCommonState.error:
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                'Thông tin hoá đơn chưa được đồng bộ',
                                style: AppTextStyle.regular(color: AppColors.redColor),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  ref.read(checkoutProvider.notifier).getInvoice();
                                },
                                icon: const Icon(
                                  Icons.refresh,
                                  color: AppColors.redColor,
                                )),
                          ],
                        );
                      case PageCommonState.loading:
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CupertinoActivityIndicator(color: AppColors.blue),
                            const Gap(8),
                            Flexible(
                              child: Text(
                                'Đang tải thông tin hoá đơn',
                                style: AppTextStyle.regular(color: AppColors.blue),
                              ),
                            ),
                          ],
                        );
                      default:
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const GapH(8),
                AppTextFormField(
                  label: "${S.current.firstName} & ${S.current.lastName}",
                  textInputAction: TextInputAction.next,
                  textController: ctrlName,
                  enabled: enable,
                ),
                const GapH(12),
                SizedBox(
                  height: 56,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: AppTextFormField(
                          enabled: enable,
                          textInputAction: TextInputAction.next,
                          textController: ctrlTax,
                          label: S.current.tax_code,
                          required: isRequiredTaxCode,
                          validator: (value) {
                            String? errorMsg;
                            if (isRequiredTaxCode) {
                              errorMsg = FieldValidationUtils.checkRequired(value);
                            }

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              errorTaxCode.value = errorMsg;
                            });
                            return null;
                          },
                          onEditingComplete: _onSearchTax,
                        ),
                      ),
                      const Gap(8),
                      AppButton(
                        height: 56,
                        color: AppColors.secondColor,
                        onPressed: _onSearchTax,
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: errorTaxCode,
                  builder: (context, value, child) {
                    if ((value ?? '').trim().isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        value ?? '',
                        style: AppTextStyle.regular(
                          color: AppColors.redColor,
                          rawFontSize: AppConfig.defaultRawTextSize - 1.0,
                        ),
                      ),
                    );
                  },
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
                    setState(() {
                      isRequiredTaxCode = text.trim().isEmpty;
                    });
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
                AppTextFormField(
                  textController: ctrlEmail,
                  label: S.current.email,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.emailAddress,
                  required: isRequiredData,
                  enabled: enable,
                  validator:
                      isRequiredData ? (value) => FieldValidationUtils.validateEmail(value) : null,
                ),
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
                AppTextFormField(
                  textController: ctrlPhone,
                  label: S.current.phone,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.number,
                  enabled: enable,
                  required: isRequiredData,
                  validator:
                      isRequiredData ? (value) => FieldValidationUtils.checkRequired(value) : null,
                  maxLength: 12,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const GapH(32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const AppCloseButton(),
                    if (invoice != null && !invoice.isEmpty() && enable) ...[
                      const GapW(8),
                      AppButton(
                        onPressed: () async {
                          final result =
                              await ref.read(checkoutProvider.notifier).onUpdateOrderInvoice(
                                    const OrderInvoice(),
                                    isUpdate: true,
                                  );
                          if (result && context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        color: AppColors.secondColor,
                        textAction: S.current.delete_info,
                      ),
                    ],
                    if (enable) ...[
                      const Gap(8),
                      AppButton(
                        onPressed: () {
                          _onConfirm(update: invoice != null && !invoice.isEmpty());
                        },
                      ),
                    ],
                  ],
                ),
                const GapH(24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onSearchTax() async {
    final String taxCode = ctrlTax.text.trim();
    if (taxCode.isNotEmpty) {
      final result = await ref.read(homeProvider.notifier).searchTaxCodeInfo(taxCode);
      final minvoice = result.$1;
      final error = result.$2;
      if (minvoice != null) {
        ctrlName.text = minvoice.name;
        ctrlCompanyName.text = minvoice.companyName;
        ctrlAddress.text = minvoice.address;
        ctrlEmail.text = minvoice.email;
        ctrlBank.text = minvoice.bank;
        ctrlBankNumber.text = minvoice.accountNumber;
        ctrlPhone.text = minvoice.phone;
        setState(() {
          isRequiredData = minvoice.isValidate;
        });
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

  Future<void> _onConfirm({bool update = false}) async {
    if (_formKey.currentState!.validate()) {
      final OrderInvoice invoice = OrderInvoice(
        name: ctrlName.text.trim(),
        taxCode: ctrlTax.text.trim(),
        companyName: ctrlCompanyName.text.trim(),
        address: ctrlAddress.text.trim(),
        email: ctrlEmail.text.trim(),
        bank: ctrlBank.text.trim(),
        accountNumber: ctrlBankNumber.text.trim(),
        phone: ctrlPhone.text.trim(),
        isValidate: isRequiredData,
        maDvqhns: ctrlDvqhnsCode.text.trim(),
        cccdan: ctrlCCCD.text.trim(),
      );
      final result = await ref.read(checkoutProvider.notifier).onUpdateOrderInvoice(
            invoice,
            isUpdate: update,
          );
      if (result) {
        Navigator.pop(context);
      }
    } else {
      showMessageDialog(
        context,
        message: S.current.require_enter_info,
      );
    }
  }
}

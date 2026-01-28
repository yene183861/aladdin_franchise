import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button/close_button.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';
import 'package:aladdin_franchise/src/utils/field_validation.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'error.dart';

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

class __CreateInvoiceOrderDialogState
    extends ConsumerState<_CreateInvoiceOrderDialog> {
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

  @override
  void initState() {
    super.initState();
    ctrlName = TextEditingController(text: widget.orderInvoice?.name);
    ctrlTax = TextEditingController(text: widget.orderInvoice?.taxCode);
    ctrlCompanyName =
        TextEditingController(text: widget.orderInvoice?.companyName);
    ctrlAddress = TextEditingController(text: widget.orderInvoice?.address);
    ctrlEmail = TextEditingController(text: widget.orderInvoice?.email);
    ctrlBank = TextEditingController(text: widget.orderInvoice?.bank);
    ctrlBankNumber =
        TextEditingController(text: widget.orderInvoice?.accountNumber);
    ctrlPhone = TextEditingController(text: widget.orderInvoice?.phone);
    ctrlDvqhnsCode = TextEditingController(text: widget.orderInvoice?.maDvqhns);
    ctrlCCCD = TextEditingController(text: widget.orderInvoice?.cccdan);
    isRequiredData = widget.orderInvoice?.isValidate ?? true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isRequiredTaxCode = widget.orderInvoice?.maDvqhns.isEmpty ?? true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var lockedOrder =
        ref.watch(homeProvider.select((value) => value.lockedOrder));
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
              style: AppTextStyle.bold(),
            ),
          ),
          const CloseButton(),
        ],
      ),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                Row(
                  children: [
                    Expanded(
                      child: AppTextFormField(
                        label: S.current.tax_code,
                        textInputAction: TextInputAction.next,
                        textController: ctrlTax,
                        required: isRequiredTaxCode,
                        enabled: enable,
                        validator: isRequiredTaxCode
                            ? (value) =>
                                FieldValidationUtils.checkRequired(value)
                            : null,
                      ),
                    ),
                    if (enable) ...[
                      const GapW(12),
                      ButtonSimpleWidget(
                        onPressed: () => _onSearchTax(),
                        textAction: S.current.search,
                        color: AppColors.secondColor,
                      ),
                    ],
                  ],
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
                  validator: (value) =>
                      FieldValidationUtils.checkRequired(value),
                ),
                const GapH(12),
                AppTextFormField(
                  textController: ctrlAddress,
                  label: S.current.address,
                  multiLine: true,
                  textInputAction: TextInputAction.next,
                  required: true,
                  enabled: enable,
                  validator: (value) =>
                      FieldValidationUtils.checkRequired(value),
                ),
                const GapH(12),
                AppTextFormField(
                  textController: ctrlEmail,
                  label: S.current.email,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.emailAddress,
                  required: isRequiredData,
                  enabled: enable,
                  validator: isRequiredData
                      ? (value) => FieldValidationUtils.validateEmail(value)
                      : null,
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
                  validator: isRequiredData
                      ? (value) => FieldValidationUtils.checkRequired(value)
                      : null,
                  maxLength: 12,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const GapH(32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const AppCloseButton(),
                    // ButtonCancelWidget(
                    //   onPressed: () => Navigator.pop(context),
                    //   textAction: S.current.close,
                    // ),
                    if (widget.orderInvoice != null &&
                        !widget.orderInvoice!.isEmpty() &&
                        enable) ...[
                      const GapW(8),
                      ButtonSimpleWidget(
                        onPressed: () async {
                          final result = await ref
                              .read(checkoutPageProvider.notifier)
                              .onUpdateOrderInvoice(
                                const OrderInvoice(),
                                isUpdate: widget.orderInvoice != null,
                              );
                          if (result) {
                            Navigator.pop(context);
                          }
                        },
                        color: AppColors.secondColor,
                        textAction: S.current.delete_info,
                      ),
                    ],
                    if (enable) ...[
                      const GapW(8),
                      ButtonSimpleWidget(
                        onPressed: _onConfirm,
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
      final result = await ref
          .read(checkoutPageProvider.notifier)
          .searchTaxCodeInfo(taxCode);
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
        setState(() {
          isRequiredData = minvoice.isValidate;
        });
      } else {
        if (context.mounted) {
          // await showErrorDialog(
          //   context,
          //   message: error.toString(),
          //   isNotifier: true,
          // );
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
      final result =
          await ref.read(checkoutPageProvider.notifier).onUpdateOrderInvoice(
                invoice,
                isUpdate: widget.orderInvoice != null,
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

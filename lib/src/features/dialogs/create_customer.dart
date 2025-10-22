import 'dart:io';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/button_with_icon.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/utils/date_input.dart';
import 'package:aladdin_franchise/src/utils/id_card_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../generated/l10n.dart';
import '../../utils/app_log.dart';
import 'error.dart';

class CreateCustomerDialog extends ConsumerStatefulWidget {
  final String? phone;
  const CreateCustomerDialog({
    Key? key,
    this.phone,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateCustomerDialogState();
}

class _CreateCustomerDialogState extends ConsumerState<CreateCustomerDialog> {
  String? gender, address, idCardNumber;
  String inputBirthday = "";
  late TextEditingController ctrlPhone, ctrlFirstName, ctrlLastName, ctrlBirthday;
  bool _noBOD = true;
  @override
  void initState() {
    super.initState();
    ctrlPhone = TextEditingController(text: widget.phone);
    ctrlFirstName = TextEditingController();
    ctrlLastName = TextEditingController();
    ctrlBirthday = TextEditingController();
    gender = appConfig.gender[0];
  }

  @override
  void dispose() {
    ctrlPhone.dispose();
    ctrlFirstName.dispose();
    ctrlLastName.dispose();
    ctrlBirthday.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lockedOrder = ref.watch(homeProvider.select((value) => value.lockedOrder));
    bool enable = !lockedOrder;
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              S.current.createNewCustomers,
              // style: AppTextStyle.medium(
              //   rawFontSize: 15,
              // ),
            ),
            content: SizedBox(
              width: 45.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextFieldWidget(
                    label: S.current.phone,
                    textController: ctrlPhone,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    required: true,
                    enabled: enable,
                    maxLength: 12,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: 16),
                  // if (Platform.isAndroid && enable) ...[
                  //   ButtonWithIconWidget(
                  //     icon: CupertinoIcons.creditcard,
                  //     textAction: S.current.scan_info_from_id,
                  //     color: AppColors.secondColor,
                  //     onPressed: () => _onScanIdCard(context),
                  //   ),
                  //   const SizedBox(height: 16),
                  // ],
                  Row(
                    children: [
                      Expanded(
                        child: AppTextFieldWidget(
                          label: S.current.firstName,
                          textController: ctrlFirstName,
                          textInputAction: TextInputAction.next,
                          required: true,
                          enabled: enable,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppTextFieldWidget(
                          label: S.current.lastName,
                          textController: ctrlLastName,
                          textInputAction: TextInputAction.next,
                          required: true,
                          enabled: enable,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    S.current.gender,
                    style: AppTextStyle.regular(),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          toggleable: enable,
                          tileColor: Colors.grey.shade100,
                          shape: AppConfig.shapeBorderMain,
                          value: appConfig.gender[0],
                          groupValue: gender,
                          title: Text(
                            S.current.male,
                            style: AppTextStyle.regular(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RadioListTile(
                          tileColor: Colors.grey.shade100,
                          toggleable: true,
                          shape: AppConfig.shapeBorderMain,
                          value: appConfig.gender[1],
                          groupValue: gender,
                          title: Text(
                            S.current.female,
                            style: AppTextStyle.regular(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppTextFieldWidget(
                    label: S.current.bod,
                    hintText: "dd/MM/yyyy",
                    enabled: !_noBOD && enable,
                    textInputType: TextInputType.number,
                    textController: ctrlBirthday,
                    inputFormatters: [
                      DateText2Formatter(),
                    ],
                    required: !_noBOD,
                    validator: (value) {
                      if (value?.isNotEmpty ?? false) {
                        return checkInputDate(value!);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  CheckboxListTile(
                    value: _noBOD,
                    enabled: enable,
                    //tileColor: Colors.grey.shade200,
                    controlAffinity: ListTileControlAffinity.leading,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: Text(S.current.no_identified_bod),
                    onChanged: (value) {
                      setState(() {
                        _noBOD = value ?? true;
                        if (_noBOD) {
                          ctrlBirthday.text = '';
                        }
                      });
                    },
                  )
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            actions: [
              ButtonCancelWidget(
                onPressed: () => Navigator.pop(context, null),
              ),
              if (enable)
                ButtonSimpleWidget(
                  onPressed: () async {
                    String phone = ctrlPhone.text.trim();
                    String firstName = ctrlFirstName.text.trim();
                    String lastName = ctrlLastName.text.trim();
                    // ngay sinh
                    if (_noBOD == false) {
                      var checkDob = checkInputDate(ctrlBirthday.text);
                      if (checkDob != null) {
                        showMessageDialog(context, message: S.current.dob_not_format);
                        return;
                      }
                      final dob = DateFormat("dd/MM/yyyy").parse(ctrlBirthday.text);
                      inputBirthday = appConfig.dateFormatYYYYMMDD.format(dob);
                    }
                    final result = await ref.read(homeProvider.notifier).createCustomer(
                          phone: phone,
                          firstName: firstName,
                          lastName: lastName,
                          birthday: inputBirthday,
                          gender: gender,
                          idCardNumber: idCardNumber,
                          address: address,
                          noBOD: _noBOD,
                        );
                    if (result != null) {
                      if (context.mounted) {
                        await showErrorDialog(
                          context,
                          message: result,
                          isNotifier: true,
                        );
                        // showMessageDialog(context, message: result);
                      }
                      return;
                    }
                    if (context.mounted) {
                      Navigator.pop(context, phone);
                    }
                  },
                  color: AppColors.bgButtonMain,
                  textColor: AppColors.tcButtonMain,
                  textAction: S.current.confirm,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // _onScanIdCard(BuildContext context) async {
  //   if (Platform.isWindows) {
  //     showMessageDialog(
  //       context,
  //       message: S.current.not_available_feature,
  //     );
  //     return;
  //   }
  //   String barcodeRes = await FlutterBarcodeScanner.scanBarcode(
  //     "#000000",
  //     S.current.cancel,
  //     true,
  //     ScanMode.DEFAULT,
  //   );
  //   showLog(barcodeRes);
  //   if (barcodeRes != '-1') {
  //     var idCard = IDCardHelper.getIdCardFromCCCD(barcodeRes);
  //     if (idCard != null) {
  //       ctrlFirstName.text = idCard.firstName;
  //       ctrlLastName.text = idCard.lastName;
  //       gender = idCard.gender;
  //       address = idCard.address;
  //       idCardNumber = idCard.id;
  //       ctrlBirthday.text = DateFormat("dd/MM/yyyy").format(idCard.dob);
  //       setState(() {});
  //     } else {
  //       // ignore: use_build_context_synchronously
  //       showMessageDialog(
  //         context,
  //         message: S.current.can_not_read_info,
  //       );
  //     }
  //   }
  // }
}

Future<String?> showCreateCustomerDialog(
  BuildContext context,
  String phone,
) async {
  var result = await showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (context) => CreateCustomerDialog(phone: phone),
  );
  result = result.toString();
  return result == "null" ? null : result;
}

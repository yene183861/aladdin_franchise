import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/customer/create_customer.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/customer/view.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/button/app_buton.dart';
import 'package:aladdin_franchise/src/features/widgets/button/btn_with_icon.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/title_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../../generated/l10n.dart';

onChooseCustomerOption(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      var smallDevice =
          ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE);
      return FractionallySizedBox(
        widthFactor: smallDevice ? 0.8 : 0.5,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      S.current.customers,
                      style: AppTextStyle.bold(
                        rawFontSize: AppConfig.defaultRawTextSize + 1.0,
                      ),
                    )),
                    const CloseButton(),
                  ],
                ),
                const Gap(4),
                // TitleDialogWithCloseWidget(
                //   title: S.current.customers,
                // ),
                const Flexible(child: _CustomerOptionDialog()),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _CustomerOptionDialog extends ConsumerStatefulWidget {
  const _CustomerOptionDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __CustomerOptionDialogState();
}

class __CustomerOptionDialogState extends ConsumerState<_CustomerOptionDialog> {
  late TextEditingController _textController;
  final _formKey = GlobalKey<FormState>();
  late ValueNotifier<String?> error;

  @override
  void initState() {
    super.initState();
    error = ValueNotifier<String?>(null);
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    error.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lockedOrder =
        ref.watch(homeProvider.select((value) => value.lockedOrder));
    bool enable = !lockedOrder;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(4),
          SizedBox(
            height: 56,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Form(
                    key: _formKey,
                    child: AppTextFormField(
                      enabled: enable,
                      textInputType: TextInputType.number,
                      hintText: "${S.current.input} ${S.current.phone}",
                      maxLength: 11,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textController: _textController,
                      validator: (value) {
                        var text = (value ?? '').trim();
                        String? errorMsg;
                        if (value != null &&
                            text.isNotEmpty &&
                            text.length < 10) {
                          errorMsg = S.current.phone_invalid;
                        }
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          error.value = errorMsg;
                        });
                        return null;
                      },
                    ),
                  ),
                ),
                if (enable) ...[
                  const Gap(8),
                  AppButton(
                    height: 56,
                    onPressed: () async {
                      var phone = _textController.text.trim();
                      if ((error.value ?? '').trim().isNotEmpty) return;
                      if (_formKey.currentState?.validate() ?? false) {
                        var result = await ref
                            .read(homeProvider.notifier)
                            .findCustomer(phone);
                        if (result != FindCustomerStatus.success) {
                          var errorMessage =
                              ref.read(homeProvider).messageError;
                          // Hiển thị thông báo kèm theo nút tạo khách hàng mới
                          if (result == FindCustomerStatus.notFound) {
                            if (context.mounted) {
                              await showConfirmAction(
                                context,
                                title: S.current.notification,
                                actionTitle: S.current.createNewCustomers,
                                message: errorMessage,
                                action: () async {
                                  var result = await showCreateCustomerDialog(
                                      context, phone);
                                  if (result != null) {
                                    await ref
                                        .read(homeProvider.notifier)
                                        .findCustomer(phone);
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                              );
                            }
                          } else {
                            if (context.mounted) {
                              await showMessageDialog(
                                context,
                                message: errorMessage,
                              );
                            }
                          }
                          return;
                        }
                        _textController.text = '';
                      }
                    },
                  ),
                ],
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: error,
            builder: (context, value, child) {
              if ((value ?? '').trim().isEmpty) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
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
          Consumer(
            builder: (context, ref, child) {
              var customer =
                  ref.watch(homeProvider.select((value) => value.customer));

              if (customer == null) {
                if (!enable) return Text(S.current.msg_locked_order);
                return const SizedBox.shrink();
              }

              return CustomerInfoWidget(
                canAction: enable,
                customer: customer,
              );
            },
          ),
          const Gap(12),
          if (enable) ...[
            ButtonWithIconWidget(
              color: AppColors.secondColor,
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
            ),
          ]
        ],
      ),
    );
  }
}

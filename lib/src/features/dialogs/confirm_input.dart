import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/button_cancel.dart';
import 'package:aladdin_franchise/src/features/widgets/button_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/textfield_simple.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ConfirmInputDialog extends ConsumerStatefulWidget {
  final String title;
  final String? message;
  final String hintText;
  final String? labelInput;
  final String? textAction;
  final TextInputType? keyboardType;
  final int? maxLineInput;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final int? maxLength;
  final List<TextInputFormatter> inputFormatters;
  final String? initText;
  final String? Function(String?)? validator;
  const ConfirmInputDialog({
    Key? key,
    this.textAction,
    this.title = "Input",
    this.hintText = "Input",
    this.keyboardType,
    this.message,
    this.labelInput,
    this.maxLineInput,
    this.textInputAction,
    this.obscureText = false,
    this.maxLength,
    this.inputFormatters = const [],
    this.initText,
    this.validator,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ConfirmInputDialogState();
}

class _ConfirmInputDialogState extends ConsumerState<ConfirmInputDialog> {
  late TextEditingController ctrlInput;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    ctrlInput = TextEditingController(text: (widget.initText ?? '').trim());
  }

  @override
  void dispose() {
    ctrlInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: AppConfig.borderRadiusMain),
        title: Text(
          widget.title,
          // style: AppTextStyle.regular(rawFontSize: 15),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.message == null
                  ? Container()
                  : Text(widget.message ?? "", style: AppTextStyle.regular()),
              const Gap(8),
              AppTextFormField(
                textController: ctrlInput,
                minLines: widget.maxLineInput,
                textInputType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                hintText: widget.hintText,
                label: widget.labelInput == null ? null : widget.labelInput ?? "",
                maxLength: widget.maxLength,
                obscureText: widget.obscureText,
                inputFormatters: widget.inputFormatters,
                maxLines: widget.maxLineInput,
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ButtonCancelWidget(
            onPressed: () {
              Navigator.pop(context, null);
            },
          ),
          const SizedBox(width: 8),
          ButtonSimpleWidget(
            color: AppColors.bgButtonMain,
            textColor: AppColors.tcButtonMain,
            textAction: widget.textAction ?? S.current.confirm,
            onPressed: () {
              String data = ctrlInput.text.trim();
              Navigator.pop(context, data);
            },
          ),
        ],
      ),
    );
  }
}

Future<String?> showConfirmInputDialog(
  BuildContext context, {
  String title = "Input",
  String hintText = "Input",
  String? textAction,
  TextInputType? keyboardType,
  String? message,
  String? labelInput,
  int? maxLineInput,
  TextInputAction? textInputAction,
  bool obscureText = false,
  int? maxLengthInput,
  List<TextInputFormatter> inputFormatters = const [],
  String? initText,
  String? Function(String?)? validator,
}) async {
  var result = await showDialog(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (context) => ConfirmInputDialog(
      title: title,
      hintText: hintText,
      textAction: textAction ?? S.current.confirm,
      keyboardType: keyboardType,
      message: message,
      labelInput: labelInput,
      maxLineInput: maxLineInput,
      textInputAction: textInputAction,
      obscureText: obscureText,
      maxLength: maxLengthInput,
      inputFormatters: inputFormatters,
      initText: initText,
      validator: validator,
    ),
  );
  return result;
}

import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppTextFieldWidget extends StatelessWidget {
  final String? label;
  final bool required;
  final String? hintText;
  final TextEditingController? textController;
  final Function(String value)? onChanged;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool? enabled;
  final String? initialValue;
  final Key? textFieldKey;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String? value)? validator;
  final bool multiLine;
  final bool readOnly;
  final int? minLines;

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;
  final bool obscureText;

  final Function? onTapOutside;
  final Function()? onEditingComplete;

  const AppTextFieldWidget({
    Key? key,
    this.label,
    this.onChanged,
    this.textController,
    this.textInputAction,
    this.textInputType,
    this.enabled,
    this.initialValue,
    this.textFieldKey,
    this.inputFormatters,
    this.validator,
    this.multiLine = false,
    this.required = false,
    this.readOnly = false,
    this.minLines,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.maxLength,
    this.obscureText = false,
    this.onTapOutside,
    this.onEditingComplete,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      validator: (value) {
        return validator?.call(value);
      },
      minLines: minLines,
      maxLines: multiLine ? null : 1,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: textFieldKey,
      enabled: enabled,
      initialValue: initialValue,
      controller: textController,
      style: AppTextStyle.regular(),
      textInputAction: textInputAction,
      keyboardType: textInputType,
      maxLength: maxLength,
      decoration: InputDecoration(
        counter: const SizedBox.shrink(),
        contentPadding: contentPadding,
        errorStyle: AppTextStyle.regular(color: AppColors.redColor),
        hintText: hintText,
        label: label == null
            ? null
            : required
                ? Text.rich(
                    style: AppTextStyle.regular(color: AppColors.tcHintText, rawFontSize: 13.5),
                    TextSpan(
                      text: label ?? "Input",
                      children: [
                        TextSpan(
                          text: " *",
                          style: AppTextStyle.regular(color: AppColors.redColor, rawFontSize: 13.5),
                        )
                      ],
                    ),
                  )
                : Text(
                    label ?? "Input",
                    style: AppTextStyle.regular(color: AppColors.tcHintText, rawFontSize: 13.5),
                  ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle: AppTextStyle.regular(rawFontSize: 12, color: AppColors.tcHintText),
      ),
      onChanged: (value) {
        onChanged?.call(value);
      },
      readOnly: readOnly,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
        onTapOutside?.call();
      },
      obscureText: obscureText,
      onEditingComplete: onEditingComplete,
    );
  }
}

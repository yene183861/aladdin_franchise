import 'package:aladdin_franchise/src/features/pages/checkout/widgets/customer_section.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _red = Color(0xFFC62828);

class InvoiceSection extends StatefulWidget {
  const InvoiceSection({super.key});

  @override
  State<InvoiceSection> createState() => _InvoiceSectionState();
}

class _InvoiceSectionState extends State<InvoiceSection> {
  bool _enabled = false;

  late ExpansionTileController controller;
  late TextEditingController _nameCtrl,
      _taxCtrl,
      _budgetRelationUnitCodeCtrl,
      _citizenIdCtrl,
      _companyCtrl,
      _addressCtrl,
      _emailCtrl,
      _bankCtrl,
      _phoneCtrl;

  @override
  void initState() {
    super.initState();
    controller = ExpansionTileController();
    _nameCtrl = TextEditingController();
    _taxCtrl = TextEditingController();
    _budgetRelationUnitCodeCtrl = TextEditingController();
    _citizenIdCtrl = TextEditingController();
    _companyCtrl = TextEditingController();
    _addressCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _bankCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _companyCtrl.dispose();
    _nameCtrl.dispose();
    _taxCtrl.dispose();
    _budgetRelationUnitCodeCtrl.dispose();
    _citizenIdCtrl.dispose();
    _companyCtrl.dispose();
    _addressCtrl.dispose();
    _emailCtrl.dispose();
    _bankCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _toggle(bool value) {
    setState(() => _enabled = value);
    if (value) {
      controller.expand();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ExpansionTile(
        controller: controller,
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tilePadding: const EdgeInsets.only(right: 16),
        title: const TitleSectionWithIcon(
          icon: Icons.receipt_long_outlined,
          title: 'Xuất hóa đơn đỏ',
        ),
        trailing: Switch(
          value: _enabled,
          onChanged: _toggle,
          activeColor: Colors.white,
          activeTrackColor: _red,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey.shade300,
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
        ),
        children: [
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InvoiceField(
                  label: 'Họ & Tên',
                  controller: _nameCtrl,
                  maxLines: 1,
                ),
                const Gap(16),
                InvoiceField(
                  label: 'Mã số thuế',
                  controller: _taxCtrl,
                  maxLines: 1,
                  require: true,
                  onlyLabel: true,
                ),
                SizedBox(
                  height: 48,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 56,
                            maxHeight: 56,
                          ),
                          child: InvoiceField(
                            controller: _taxCtrl,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      const Gap(12),
                      AppOutlinedIconButton(
                        textAction: 'Tìm kiếm',
                        icon: const Icon(CupertinoIcons.search, color: _red, size: 18),
                        onPressed: () {},
                        height: 48,
                      )
                    ],
                  ),
                ),
                const Gap(16),
                InvoiceField(
                  label: 'Mã đơn vị quan hệ ngân sách',
                  controller: _budgetRelationUnitCodeCtrl,
                  maxLines: 1,
                ),
                const Gap(16),
                InvoiceField(
                  label: 'Căn cước công dân',
                  controller: _citizenIdCtrl,
                  maxLines: 1,
                ),
                const Gap(16),
                InvoiceField(
                  label: 'Tên công ty',
                  controller: _companyCtrl,
                  maxLines: 1,
                  require: true,
                ),
                const Gap(16),
                InvoiceField(
                  label: 'Địa chỉ',
                  controller: _addressCtrl,
                  maxLines: 3,
                  require: true,
                ),
                const Gap(16),
                InvoiceField(
                  label: 'Email',
                  controller: _emailCtrl,
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  require: true,
                ),
                const Gap(16),
                InvoiceField(
                  label: 'Ngân hàng',
                  controller: _bankCtrl,
                  maxLines: 1,
                ),
                const Gap(16),
                InvoiceField(
                  label: 'Số điện thoại',
                  controller: _phoneCtrl,
                  maxLines: 1,
                ),
                const Gap(20),
                Row(
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: AppOutlinedIconButton(
                            textAction: 'Xoá',
                            icon: const Icon(Icons.delete_outline, color: _red, size: 18),
                            onPressed: () {},
                            height: 56,
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: AppOutlinedIconButton(
                        textAction: 'Lưu thông tin',
                        icon: const Icon(Icons.save_outlined, color: _red, size: 18),
                        onPressed: () {},
                        height: 56,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class InvoiceSection extends StatefulWidget {
//   const InvoiceSection({super.key});

//   @override
//   State<InvoiceSection> createState() => _InvoiceSectionState();
// }

// class _InvoiceSectionState extends State<InvoiceSection> with SingleTickerProviderStateMixin {
//   late TextEditingController _nameCtrl,
//       _taxCtrl,
//       _budgetRelationUnitCodeCtrl,
//       _citizenIdCtrl,
//       _companyCtrl,
//       _addressCtrl,
//       _emailCtrl,
//       _bankCtrl,
//       _phoneCtrl;

//   late AnimationController _animationCtrl;
//   late Animation<double> _expandAnimation;

//   bool _enabled = false;
//   bool _isExpanded = false;

//   @override
//   void initState() {
//     super.initState();
//     _nameCtrl = TextEditingController();
//     _taxCtrl = TextEditingController();
//     _budgetRelationUnitCodeCtrl = TextEditingController();
//     _citizenIdCtrl = TextEditingController();
//     _companyCtrl = TextEditingController();
//     _addressCtrl = TextEditingController();
//     _emailCtrl = TextEditingController();
//     _bankCtrl = TextEditingController();
//     _phoneCtrl = TextEditingController();

//     _animationCtrl = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 280),
//     );
//     _expandAnimation = CurvedAnimation(
//       parent: _animationCtrl,
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   void dispose() {
//     _animationCtrl.dispose();
//     _companyCtrl.dispose();
//     _nameCtrl.dispose();
//     _taxCtrl.dispose();
//     _budgetRelationUnitCodeCtrl.dispose();
//     _citizenIdCtrl.dispose();
//     _companyCtrl.dispose();
//     _addressCtrl.dispose();
//     _emailCtrl.dispose();
//     _bankCtrl.dispose();
//     _phoneCtrl.dispose();
//     super.dispose();
//   }

//   void _toggle(bool value) {
//     setState(() => _enabled = value);
//     if (value) {
//       _isExpanded = true;
//       _animationCtrl.forward();
//     } else {
//       _isExpanded = false;
//       _animationCtrl.reverse();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.07),
//             blurRadius: 10,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           InkWell(
//             onTap: !_enabled
//                 ? null
//                 : () {
//                     if (_isExpanded) {
//                       _isExpanded = false;
//                       _animationCtrl.reverse();
//                     } else {
//                       _isExpanded = true;
//                       _animationCtrl.forward();
//                     }
//                   },
//             borderRadius: BorderRadius.circular(14),
//             child: TitleSectionWithIcon(
//               icon: Icons.receipt_long_outlined,
//               title: 'Xuất hóa đơn đỏ',
//               trailing: Switch(
//                 value: _enabled,
//                 onChanged: _toggle,
//                 activeColor: Colors.white,
//                 activeTrackColor: _red,
//                 inactiveThumbColor: Colors.white,
//                 inactiveTrackColor: Colors.grey.shade300,
//                 trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
//               ),
//             ),
//           ),
//           SizeTransition(
//             sizeFactor: _expandAnimation,
//             axisAlignment: -1,
//             child: FadeTransition(
//               opacity: _expandAnimation,
//               child: Column(
//                 children: [
//                   const Divider(height: 1, color: Color(0xFFEEEEEE)),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         InvoiceField(
//                           label: 'Họ & Tên',
//                           controller: _nameCtrl,
//                           maxLines: 1,
//                         ),
//                         const Gap(16),
//                         InvoiceField(
//                           label: 'Mã số thuế',
//                           controller: _taxCtrl,
//                           maxLines: 1,
//                           require: true,
//                           onlyLabel: true,
//                         ),
//                         SizedBox(
//                           height: 48,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Expanded(
//                                 child: ConstrainedBox(
//                                   constraints: const BoxConstraints(
//                                     minHeight: 56,
//                                     maxHeight: 56,
//                                   ),
//                                   child: InvoiceField(
//                                     controller: _taxCtrl,
//                                     maxLines: 1,
//                                   ),
//                                 ),
//                               ),
//                               const Gap(12),
//                               AppOutlinedIconButton(
//                                 textAction: 'Tìm kiếm',
//                                 icon: const Icon(CupertinoIcons.search, color: _red, size: 18),
//                                 onPressed: () {},
//                                 height: 48,
//                               )
//                             ],
//                           ),
//                         ),
//                         const Gap(16),
//                         InvoiceField(
//                           label: 'Mã đơn vị quan hệ ngân sách',
//                           controller: _budgetRelationUnitCodeCtrl,
//                           maxLines: 1,
//                         ),
//                         const Gap(16),
//                         InvoiceField(
//                           label: 'Căn cước công dân',
//                           controller: _citizenIdCtrl,
//                           maxLines: 1,
//                         ),
//                         const Gap(16),
//                         InvoiceField(
//                           label: 'Tên công ty',
//                           controller: _companyCtrl,
//                           maxLines: 1,
//                           require: true,
//                         ),
//                         const Gap(16),
//                         InvoiceField(
//                           label: 'Địa chỉ',
//                           controller: _addressCtrl,
//                           maxLines: 3,
//                           require: true,
//                         ),
//                         const Gap(16),
//                         InvoiceField(
//                           label: 'Email',
//                           controller: _emailCtrl,
//                           maxLines: 1,
//                           keyboardType: TextInputType.emailAddress,
//                           require: true,
//                         ),
//                         const Gap(16),
//                         InvoiceField(
//                           label: 'Ngân hàng',
//                           controller: _bankCtrl,
//                           maxLines: 1,
//                         ),
//                         const Gap(16),
//                         InvoiceField(
//                           label: 'Số điện thoại',
//                           controller: _phoneCtrl,
//                           maxLines: 1,
//                         ),
//                         const Gap(20),
//                         Row(
//                           children: [
//                             Consumer(
//                               builder: (context, ref, child) {
//                                 return Padding(
//                                   padding: const EdgeInsets.only(right: 12),
//                                   child: AppOutlinedIconButton(
//                                     textAction: 'Xoá',
//                                     icon: const Icon(Icons.delete_outline, color: _red, size: 18),
//                                     onPressed: () {},
//                                     height: 56,
//                                   ),
//                                 );
//                               },
//                             ),
//                             Expanded(
//                               child: AppOutlinedIconButton(
//                                 textAction: 'Lưu thông tin',
//                                 icon: const Icon(Icons.save_outlined, color: _red, size: 18),
//                                 onPressed: () {},
//                                 height: 56,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class AppOutlinedIconButton extends StatelessWidget {
  const AppOutlinedIconButton({
    super.key,
    required this.textAction,
    this.textStyle,
    this.onPressed,
    this.icon,
    this.height,
  });

  final String textAction;

  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final Widget? icon;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: _red, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: icon,
        label: Text(
          textAction,
          style: textStyle ??
              TextStyle(
                color: _red,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}

class AppSquareIconButton extends StatelessWidget {
  const AppSquareIconButton({
    super.key,
    this.onTap,
    this.icon,
    this.width = 46,
    this.borderColor = const Color(0xFFE0E0E0),
  });

  final VoidCallback? onTap;
  final Widget? icon;
  final double width;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
        ),
        child: Center(child: icon),
      ),
    );
  }
}

class InvoiceField extends ConsumerWidget {
  const InvoiceField({
    super.key,
    this.controller,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.require = false,
    this.onlyLabel = false,
    this.contentPadding,
    this.labelIcon,
    this.inputFormatters,
    this.suffixIcon,
    this.prefixIcon,
  });

  final TextEditingController? controller;
  final String label;
  final TextInputType keyboardType;
  final int? maxLines;
  final String? hintText;

  final bool require;

  final bool onlyLabel;

  final EdgeInsetsGeometry? contentPadding;

  final Widget? labelIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.trim().isNotEmpty) ...[
          Row(
            children: [
              if (labelIcon != null) ...[
                labelIcon!,
                const Gap(6),
              ],
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.black45,
                  letterSpacing: 0.6,
                ),
              ),
              if (require)
                Text(
                  ' *',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                    letterSpacing: 0.6,
                  ),
                ),
            ],
          ),
          const Gap(12),
        ],
        if (!onlyLabel)
          TextField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
              filled: true,
              fillColor: const Color(0xFFF7F7F7),
              contentPadding:
                  contentPadding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: _red, width: 1.5),
              ),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
            ),
          ),
      ],
    );
  }
}

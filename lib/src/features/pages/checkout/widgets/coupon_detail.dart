import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/widgets/coupon_section.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'invoice_section.dart';

const _red = Color(0xFFC62828);
const _bg = Color(0xFFF5F5F5);

// ─── Screen ───────────────────────────────────────────────────────────────────

class VoucherDetailScreen extends StatefulWidget {
  const VoucherDetailScreen({super.key});
  @override
  State<VoucherDetailScreen> createState() => _VoucherDetailScreenState();
}

class _VoucherDetailScreenState extends State<VoucherDetailScreen> {
  bool _termsExpanded = false;
  final List<String> _attachments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              children: [
                _buildVoucherCodeCard(),
                const SizedBox(height: 12),
                AppExpansionTile(
                  title: const TitleSectionWithIcon(
                    icon: Icons.receipt_long_outlined,
                    // title: 'Terms & Conditions',
                    title: 'Điều kiện áp dụng',
                  ),
                  children: [
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    const Padding(
                      padding: EdgeInsets.only(top: 12, bottom: 12),
                      child: Text(
                        '• Voucher is valid for one-time use only.\n'
                        '• Cannot be combined with other promotions.\n'
                        '• Valid on selected products only.\n'
                        '• Discount applies before tax and service charges.',
                        style: TextStyle(fontSize: 13, color: Colors.black54, height: 1.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                AppExpansionTile(
                  title: const TitleSectionWithIcon(
                    icon: Icons.payment_outlined,
                    // title: 'Applicable Payments',
                    title: 'Không được áp dụng với phương thức thanh toán (0)',
                  ),
                  children: [
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    const Gap(16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        (Icons.payments_outlined, 'Cash'),
                        (Icons.credit_card_outlined, 'Visa/Master'),
                        (Icons.swap_horiz_outlined, 'Transfer'),
                        (Icons.account_balance_wallet_outlined, 'Momo'),
                      ].map((m) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(m.$1, size: 16, color: Colors.black54),
                              const SizedBox(width: 6),
                              Text(m.$2,
                                  style: const TextStyle(fontSize: 13, color: Colors.black87)),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const Gap(12),
                  ],
                ),
                const SizedBox(height: 12),
                AppExpansionTile(
                  title: const TitleSectionWithIcon(
                    icon: Icons.fastfood_outlined,
                    // title: 'Applicable Products',
                    title: 'Sản phẩm áp dụng',
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     TitleSectionWithIcon(
                  //       // icon: Icons.fastfood_outlined,
                  //       // title: 'Applicable Products',
                  //       title: 'Sản phẩm áp dụng',
                  //       padding: EdgeInsets.symmetric(vertical: 14),
                  //     ),
                  //     Text(
                  //       'Không áp dụng với món thành phần trong Set/Combo',
                  //       style: AppTextStyle.regular(),
                  //     )
                  //   ],
                  // ),
                  // leading: Icon(Icons.fastfood_outlined, size: 20, color: _red),
                  // tilePadding: EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    const Divider(height: 1, color: Color(0xFFEEEEEE)),
                    const Gap(16),
                    ...[
                      ('Bánh bao', 42),
                      ('Há cảo', 17),
                      ('Xíu mại tôm', 13),
                    ].map((p) => Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(p.$1,
                                    style: const TextStyle(fontSize: 14, color: Colors.black87)),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F0F0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'x${p.$2}',
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                        )),
                    const Gap(12),
                  ],
                ),
                const SizedBox(height: 12),
                _buildBillSummary(),
                const SizedBox(height: 12),
                _buildAttachments(),
              ],
            ),
          ),
          // _buildApplyButton(),
        ],
      ),
    );
  }

  // ── AppBar ──────────────────────────────────────────────────────────────────

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      leading: const BackButton(color: Colors.black87),
      title: const Text(
        'Voucher Details',
        style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w600),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.black54),
          onPressed: () {},
        ),
      ],
    );
  }

  // ── Voucher code card ────────────────────────────────────────────────────────

  Widget _buildVoucherCodeCard() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ACTIVE VOUCHER',
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w700, color: Colors.black45, letterSpacing: 1),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              // Code pill
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  // decoration: BoxDecoration(
                  //   color: const Color(0xFFF7F7F7),
                  //   borderRadius: BorderRadius.circular(10),
                  //   border: Border.all(color: Colors.grey.shade200),
                  // ),
                  child: const Text(
                    'TL4ZW9QO2',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // QR placeholder
              // Container(
              //   width: 52,
              //   height: 52,
              //   decoration: BoxDecoration(
              //     color: const Color(0xFFF0F0F0),
              //     borderRadius: BorderRadius.circular(8),
              //     border: Border.all(color: Colors.grey.shade200),
              //   ),
              //   child: const Icon(Icons.qr_code_2, size: 30, color: Colors.black38),
              // ),
            ],
          ),
          Divider(),
          Row(
            children: const [
              Icon(Icons.info_outline, size: 13, color: _red),
              SizedBox(width: 4),
              Text(
                'Limited to payment method',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          const Gap(8),
          Row(
            children: const [
              Icon(Icons.info_outline, size: 13, color: _red),
              SizedBox(width: 4),
              Text(
                'Mã giảm theo số khách',
                style: TextStyle(fontSize: 12, color: _red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Bill Summary ─────────────────────────────────────────────────────────────

  Widget _buildBillSummary() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(Icons.receipt_outlined, 'Bill Summary'),
          const SizedBox(height: 14),
          _billRow('Subtotal', '\$42.50'),
          const SizedBox(height: 8),
          _billRow(
            'Voucher Discount',
            '-10%',
            valueColor: _red,
            icon: Icons.local_offer_outlined,
          ),
          const SizedBox(height: 8),
          _billRow('Tax & Service', '\$2.40'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Colors.grey.shade200, height: 1),
          ),
          Row(
            children: const [
              Expanded(
                child: Text(
                  'Total Payable',
                  style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
              Text(
                '\$41.65',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _billRow(String label, String value, {Color? valueColor, IconData? icon}) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 14, color: Colors.black38),
          const SizedBox(width: 6),
        ],
        Expanded(
          child: Text(label, style: const TextStyle(fontSize: 13, color: Colors.black54)),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: valueColor ?? Colors.black87,
          ),
        ),
      ],
    );
  }

  // ── Attachments ──────────────────────────────────────────────────────────────

  Widget _buildAttachments() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'Attachments',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
              SizedBox(width: 8),
              Text(
                'OPTIONAL',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.black38,
                    letterSpacing: 0.8),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                // Add button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add, size: 24, color: Colors.black38),
                        SizedBox(height: 4),
                        Text('Add', style: TextStyle(fontSize: 11, color: Colors.black38)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Placeholder attachment
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Center(
                          child: Icon(Icons.image_outlined, size: 28, color: Colors.grey.shade400)),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration:
                                const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                            child: const Icon(Icons.close, size: 12, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Apply button ─────────────────────────────────────────────────────────────

  Widget _buildApplyButton() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: _red,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(color: _red.withOpacity(0.35), blurRadius: 12, offset: const Offset(0, 4))
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_offer_outlined, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'Apply Voucher',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Section title ─────────────────────────────────────────────────────────────

  Widget _sectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 18, color: _red),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
      ],
    );
  }
}

class AppExpansionTile extends StatelessWidget {
  const AppExpansionTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.children = const [],
    this.tilePadding,
  });
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;

  final List<Widget> children;
  final EdgeInsetsGeometry? tilePadding;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ExpansionTile(
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tilePadding: tilePadding ?? const EdgeInsets.only(right: 16),
        title: title,
        subtitle: subtitle,
        leading: leading,
        trailing: trailing,
        children: children,
      ),
    );
  }
}

// ─── Shared card ──────────────────────────────────────────────────────────────

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))
        ],
      ),
      child: child,
    );
  }
}

import 'package:aladdin_franchise/src/features/pages/checkout/widgets/customer_section.dart';
import 'package:aladdin_franchise/src/features/pages/checkout/widgets/invoice_section.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';

import '../checkout/widgets/coupon_section.dart';

class CartItem {
  final String name;
  final int unitPrice;
  int quantity;
  final Color imageColor; // placeholder color
  final IconData imageIcon;

  CartItem({
    required this.name,
    required this.unitPrice,
    required this.quantity,
    required this.imageColor,
    required this.imageIcon,
  });

  int get total => unitPrice * quantity;
}

// ─── Screen ───────────────────────────────────────────────────────────────────

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> items = [
    CartItem(
      name: 'Há cảo tôm tươi',
      unitPrice: 55000,
      quantity: 2,
      imageColor: const Color(0xFF4A2C2A),
      imageIcon: Icons.ramen_dining,
    ),
    CartItem(
      name: 'Bánh bao xá xíu',
      unitPrice: 45000,
      quantity: 1,
      imageColor: const Color(0xFF8D6E63),
      imageIcon: Icons.lunch_dining,
    ),
    CartItem(
      name: 'Xíu mại gạch cua',
      unitPrice: 65000,
      quantity: 1,
      imageColor: const Color(0xFF558B6E),
      imageIcon: Icons.set_meal,
    ),
  ];

  final TextEditingController _voucherController = TextEditingController();

  static const Color primaryRed = Color(0xFFC62828);

  String _fmt(int price) {
    final s = price.toString();
    final buf = StringBuffer();
    int c = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      if (c > 0 && c % 3 == 0) buf.write('.');
      buf.write(s[i]);
      c++;
    }
    return buf.toString().split('').reversed.join();
  }

  int get _totalItems => items.fold(0, (s, e) => s + e.quantity);
  int get _totalPrice => items.fold(0, (s, e) => s + e.total);

  void _increment(int index) => setState(() => items[index].quantity++);
  void _decrement(int index) {
    setState(() {
      if (items[index].quantity > 1) {
        items[index].quantity--;
      } else {
        items.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              children: [
                // Cart items card
                _buildCartCard(),
                const SizedBox(height: 16),

                const Gap(12),
                CouponSection(), const Gap(12),
                CustomerSection(), const Gap(12),
                InvoiceSection(),
              ],
            ),
          ),
          // Bottom CTA
          _buildBottomBar(),
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
      title: const Column(
        children: [
          Text(
            'Giỏ hàng',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Bàn 19',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.black54),
          onPressed: () => setState(() => items.clear()),
        ),
      ],
    );
  }

  // ── Cart items card ─────────────────────────────────────────────────────────

  Widget _buildCartCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: List.generate(items.length, (i) {
          final item = items[i];
          return Column(
            children: [
              _buildCartItem(item, i),
              if (i < items.length - 1) const Divider(height: 1, indent: 16, endIndent: 16),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildCartItem(CartItem item, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Thumbnail
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: item.imageColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(item.imageIcon, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 14),
          // Name + price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${_fmt(item.unitPrice)}đ',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: primaryRed,
                  ),
                ),
              ],
            ),
          ),
          // Quantity stepper
          _buildStepper(index, item.quantity),
        ],
      ),
    );
  }

  Widget _buildStepper(int index, int qty) {
    return Row(
      children: [
        _stepBtn(
          icon: Icons.remove,
          onTap: () => _decrement(index),
        ),
        SizedBox(
          width: 28,
          child: Text(
            '$qty',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        _stepBtn(
          icon: Icons.add,
          onTap: () => _increment(index),
          filled: true,
        ),
      ],
    );
  }

  Widget _stepBtn({
    required IconData icon,
    required VoidCallback onTap,
    bool filled = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: filled ? primaryRed : Colors.white,
          shape: BoxShape.circle,
          border: filled ? null : Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(
          icon,
          size: 16,
          color: filled ? Colors.white : Colors.black54,
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: primaryRed,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: primaryRed.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'GỌI MÓN',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right, color: Colors.white, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}

class VatInvoiceToggle extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const VatInvoiceToggle({
    super.key,
    this.initialValue = false,
    this.onChanged,
  });

  @override
  State<VatInvoiceToggle> createState() => _VatInvoiceToggleState();
}

class _VatInvoiceToggleState extends State<VatInvoiceToggle> {
  late bool _enabled;

  @override
  void initState() {
    super.initState();
    _enabled = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          const Icon(Icons.receipt_long_outlined, size: 20, color: Colors.black54),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Xuất hóa đơn đỏ (VAT)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Switch(
            value: _enabled,
            onChanged: (val) {
              setState(() => _enabled = val);
              widget.onChanged?.call(val);
            },
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFFC62828),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade300,
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          ),
        ],
      ),
    );
  }
}

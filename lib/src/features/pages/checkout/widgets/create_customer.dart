import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'invoice_section.dart';

const _red = Color(0xFFC62828);
const _redLight = Color(0xFFFFF0F0);

class CreateCustomerScreen extends StatefulWidget {
  const CreateCustomerScreen({super.key});

  @override
  State<CreateCustomerScreen> createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends State<CreateCustomerScreen> {
  final _phoneCtrl = TextEditingController();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();

  String _gender = 'Male';
  bool _hasBirthday = true;

  String _day = '';
  String _month = 'JAN';
  String _year = '';

  final List<String> _months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    super.dispose();
  }

  void _save() {
    // TODO: handle save
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      children: [
                        const Gap(12),
                        _Card(
                          child: InvoiceField(
                            controller: _phoneCtrl,
                            label: 'Phone numer',
                            require: true,
                            labelIcon: const Icon(Icons.phone_outlined, size: 16, color: _red),
                            hintText: 'e.g. +1 (555) 000-0000',
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        const Gap(12),
                        _Card(
                          child: Row(
                            children: [
                              Expanded(
                                  child: InvoiceField(
                                controller: _firstNameCtrl,
                                label: 'First Name',
                                require: true,
                                hintText: 'John',
                              )),
                              const Gap(12),
                              Expanded(
                                  child: InvoiceField(
                                controller: _lastNameCtrl,
                                label: 'Last Name',
                                require: true,
                                hintText: 'Doe',
                              )),
                            ],
                          ),
                        ),
                        const Gap(12),
                        _buildGenderCard(),
                        const Gap(12),
                        _buildBirthdayCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(12),
          _buildBottomBar(),
        ],
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // // Active avatar
              // Container(
              //   width: 64,
              //   height: 64,
              //   decoration: BoxDecoration(
              //     color: _redLight,
              //     shape: BoxShape.circle,
              //     border: Border.all(color: _red.withOpacity(0.3), width: 2),
              //   ),
              //   child: const Icon(Icons.person, color: _red, size: 32),
              // ),
              // const SizedBox(width: 16),
              // // Inactive add
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: [
                    Center(child: Icon(Icons.person, color: Colors.grey.shade400, size: 28)),
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 11),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Customer Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Fill in the details to enroll in loyalty',
            style: TextStyle(fontSize: 13, color: _red),
          ),
        ],
      ),
    );
  }

  // ── Phone card ───────────────────────────────────────────────────────────────

  Widget _buildPhoneCard() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.phone_outlined, size: 16, color: _red),
              SizedBox(width: 6),
              Text(
                'Phone number ',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
              Text('*', style: TextStyle(color: _red, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          _buildInput(
            controller: _phoneCtrl,
            hint: 'e.g. +1 (555) 000-0000',
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  // ── Name card ────────────────────────────────────────────────────────────────

  Widget _buildNameCard() {
    return _Card(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _FieldLabel('First Name'),
                const SizedBox(height: 8),
                _buildInput(controller: _firstNameCtrl, hint: 'John'),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _FieldLabel('Last Name'),
                const SizedBox(height: 8),
                _buildInput(controller: _lastNameCtrl, hint: 'Doe'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Gender card ──────────────────────────────────────────────────────────────

  Widget _buildGenderCard() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _FieldLabel('Gender'),
          const SizedBox(height: 10),
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: ['Male', 'Female'].map((g) {
                final selected = _gender == g;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _gender = g),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: selected ? _red : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          g,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: selected ? Colors.white : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ── Birthday card ────────────────────────────────────────────────────────────

  Widget _buildBirthdayCard() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Known birthday?',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Used for birthday rewards and discounts',
                      style: TextStyle(fontSize: 12, color: Colors.black45),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _hasBirthday,
                onChanged: (v) => setState(() => _hasBirthday = v),
                activeColor: Colors.white,
                activeTrackColor: _red,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey.shade300,
                trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
              ),
            ],
          ),
          // Birthday fields
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: _hasBirthday
                ? Padding(
                    padding: const EdgeInsets.only(top: 14),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: InvoiceField(
                            label: 'DAY',
                            hintText: 'DD',
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                            ],
                            // onChanged: (v) => _day = v,
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const InvoiceField(
                                onlyLabel: true,
                                label: 'MONTH',
                              ),
                              _buildMonthDropdown(),
                            ],
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          flex: 3,
                          child: InvoiceField(
                            label: 'YEAR',
                            hintText: 'YYYY',
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            // onChanged: (v) => _year = v,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthDropdown() {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _month,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.black45),
          style: const TextStyle(fontSize: 14, color: Colors.black87),
          items: _months.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
          onChanged: (v) => setState(() => _month = v!),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      child: Row(
        children: [
          // Discard
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.close, size: 20, color: Colors.black45),
                SizedBox(height: 2),
                Text('Discard', style: TextStyle(fontSize: 12, color: Colors.black45)),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // Save button
          Expanded(
            child: GestureDetector(
              onTap: _save,
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: _red,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: _red.withOpacity(0.35), blurRadius: 12, offset: const Offset(0, 4))
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add_outlined, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Save Customer',
                      style:
                          TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Shared input builder ─────────────────────────────────────────────────────

  Widget _buildInput({
    TextEditingController? controller,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onChanged,
  }) {
    return SizedBox(
      height: 46,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
          filled: true,
          fillColor: const Color(0xFFF7F7F7),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
          isCollapsed: true,
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
        ),
      ),
    );
  }
}

// ─── Shared components ────────────────────────────────────────────────────────

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

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black54, letterSpacing: 0.3),
    );
  }
}

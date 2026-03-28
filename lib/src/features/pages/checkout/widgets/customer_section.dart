import 'package:aladdin_franchise/src/features/pages/checkout/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/view.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'create_customer.dart';
import 'invoice_section.dart';

const _red = Color(0xFFC62828);

enum FindCustomerStatusEnum { normal, loading, success, notFound, error }

class CustomerSection extends ConsumerStatefulWidget {
  const CustomerSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomerSectionState();
}

class _CustomerSectionState extends ConsumerState<CustomerSection> {
  late TextEditingController _controller;

  late ValueNotifier<FindCustomerStatusEnum> _findCustomerStatus;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _findCustomerStatus = ValueNotifier<FindCustomerStatusEnum>(FindCustomerStatusEnum.normal);
  }

  @override
  void dispose() {
    _findCustomerStatus.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleSectionWithIcon(icon: Icons.person, title: 'Thông tin khách hàng'),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 48,
                  child: Row(
                    children: [
                      Expanded(
                        child: InvoiceField(
                          controller: _controller,
                          hintText: 'Số điện thoại',
                        ),
                      ),
                      const Gap(8),
                      ValueListenableBuilder(
                          valueListenable: _findCustomerStatus,
                          builder: (context, value, child) {
                            bool isLoading = value == FindCustomerStatusEnum.loading;
                            return AppSquareIconButton(
                              icon: isLoading
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2, color: Colors.black54),
                                    )
                                  : const Icon(Icons.search, size: 18, color: Colors.black54),
                              onTap: () {},
                            );
                          }),
                      const Gap(8),
                      AppSquareIconButton(
                        icon: const Icon(Icons.person_add_outlined, size: 18, color: _red),
                        borderColor: _red,
                        onTap: () {
                          push(context, CreateCustomerScreen());
                        },
                      ),
                    ],
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  child: ValueListenableBuilder(
                    valueListenable: _findCustomerStatus,
                    builder: (context, value, child) {
                      switch (value) {
                        case FindCustomerStatusEnum.success:
                        case FindCustomerStatusEnum.normal:
                          return const SizedBox.shrink();
                        case FindCustomerStatusEnum.notFound:
                          return const _InfoBanner(
                            message: 'Không tìm thấy khách hàng. Vui lòng tạo mới.',
                            icon: Icons.info_outline,
                            color: Colors.orange,
                          );
                        case FindCustomerStatusEnum.error:
                          return const _InfoBanner(
                            message: 'Không tìm thấy do có lỗi',
                            icon: Icons.info_outline,
                            color: _red,
                          );
                        case FindCustomerStatusEnum.loading:
                          return const _InfoBanner(
                            message: 'Đang tìm kiếm thông tin khách hàng',
                            icon: Icons.crisis_alert_sharp,
                            color: Colors.blue,
                          );
                        default:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  child: Consumer(builder: (context, ref, child) {
                    var customer = ref.watch(checkoutProvider.select((value) => value.customer));
                    if (customer == null) return const SizedBox.shrink();
                    // customer = CustomerModel(
                    //     id: 1, name: 'Nguyễn Minh Hoàng', phone: '090 **** 888', dob: '2000-01-01');

                    return _CustomerInfo(
                      customer: customer,
                      onRemove: () {},
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TitleSectionWithIcon extends StatelessWidget {
  const TitleSectionWithIcon({
    super.key,
    required this.title,
    this.icon,
    this.trailing,
  });

  final String title;
  final IconData? icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: _red),
            const Gap(10),
          ],
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          if (trailing != null) ...[
            const Gap(10),
            trailing!,
          ],
        ],
      ),
    );
  }
}

// class CustomerInfoCard extends StatefulWidget {
//   final ValueChanged<Customer?>? onCustomerChanged;
//   final VoidCallback? onNewCustomer;

//   const CustomerInfoCard({
//     super.key,
//     this.onCustomerChanged,
//     this.onNewCustomer,
//   });

//   @override
//   State<CustomerInfoCard> createState() => _CustomerInfoCardState();
// }

// class _CustomerInfoCardState extends State<CustomerInfoCard> {
//   final _controller = TextEditingController();
//   Customer? _customer;
//   bool _loading = false;
//   bool _notFound = false;

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _doSearch() async {
//     final q = _controller.text.trim();
//     if (q.isEmpty) return;
//     setState(() {
//       _loading = true;
//       _notFound = false;
//       _customer = null;
//     });

//     final result = await searchCustomer(q);
//     setState(() {
//       _loading = false;
//       _customer = result;
//       _notFound = result == null;
//     });
//     widget.onCustomerChanged?.call(result);
//   }

//   void _clear() {
//     setState(() {
//       _controller.clear();
//       _customer = null;
//       _notFound = false;
//     });
//     widget.onCustomerChanged?.call(null);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.07), blurRadius: 10, offset: const Offset(0, 3))
//         ],
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Text(
//             'Thông tin khách hàng',
//             style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black54,
//                 letterSpacing: 0.3),
//           ),
//           const SizedBox(height: 12),

//           // ── Search row ──
//           SizedBox(
//             height: 46,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Input
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF7F7F7),
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: Colors.grey.shade200),
//                     ),
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.search, size: 18, color: Colors.black38),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: TextField(
//                             controller: _controller,
//                             onSubmitted: (_) => _doSearch(),
//                             style: const TextStyle(fontSize: 14, color: Colors.black87),
//                             decoration: const InputDecoration(
//                               hintText: 'Số điện thoại / Tên khách hàng',
//                               hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
//                               border: InputBorder.none,
//                               isDense: true,
//                               contentPadding: EdgeInsets.zero,
//                               isCollapsed: true,
//                             ),
//                           ),
//                         ),
//                         if (_controller.text.isNotEmpty)
//                           GestureDetector(
//                             onTap: _clear,
//                             child: const Icon(Icons.close, size: 16, color: Colors.black38),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),

//                 // Search button
//                 _SquareIconButton(
//                   icon: _loading
//                       ? const SizedBox(
//                           width: 18,
//                           height: 18,
//                           child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black54))
//                       : const Icon(Icons.search, size: 18, color: Colors.black54),
//                   onTap: _doSearch,
//                 ),
//                 const SizedBox(width: 8),

//                 // New customer button
//                 _SquareIconButton(
//                   icon: const Icon(Icons.person_add_outlined, size: 18, color: _red),
//                   borderColor: _red,
//                   onTap: widget.onNewCustomer,
//                 ),
//               ],
//             ),
//           ),

//           // ── Result ──
//           AnimatedSize(
//             duration: const Duration(milliseconds: 250),
//             curve: Curves.easeInOut,
//             child: _customer != null
//                 ? _CustomerResult(customer: _customer!, onRemove: _clear)
//                 : _notFound
//                     ? _NotFoundBanner()
//                     : const SizedBox.shrink(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// ─── Square icon button ───────────────────────────────────────────────────────

class _SquareIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onTap;
  final Color borderColor;

  const _SquareIconButton({
    required this.icon,
    this.onTap,
    this.borderColor = const Color(0xFFE0E0E0),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
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

// ─── Customer result card ─────────────────────────────────────────────────────

// class _CustomerResult extends StatelessWidget {
//   final Customer customer;
//   final VoidCallback onRemove;

//   const _CustomerResult({required this.customer, required this.onRemove});

//   String _fmtPoints(int p) {
//     return p.toString().replaceAllMapped(
//           RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
//           (m) => '${m[1]}.',
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(top: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF7F7F7),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Row(
//         children: [
//           // Avatar
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: _red,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(Icons.person, color: Colors.white, size: 30),
//               ),
//               if (customer.isVip)
//                 Positioned(
//                   bottom: -4,
//                   right: -4,
//                   child: Container(
//                     width: 18,
//                     height: 18,
//                     decoration: const BoxDecoration(
//                       color: Color(0xFFF59E0B),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.star, size: 11, color: Colors.white),
//                   ),
//                 ),
//             ],
//           ),
//           const SizedBox(width: 12),

//           // Info
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       customer.name,
//                       style: const TextStyle(
//                           fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
//                     ),
//                     if (customer.isVip) ...[
//                       const SizedBox(width: 6),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFFEF3C7),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: const Text(
//                           'VIP MEMBER',
//                           style: TextStyle(
//                               fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF92400E)),
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//                 const SizedBox(height: 3),
//                 Row(
//                   children: [
//                     const Icon(Icons.phone_outlined, size: 12, color: Colors.black45),
//                     const SizedBox(width: 4),
//                     Text(customer.phone,
//                         style: const TextStyle(fontSize: 13, color: Colors.black54)),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     const Icon(Icons.star_outline, size: 13, color: Color(0xFF059669)),
//                     const SizedBox(width: 4),
//                     Text(
//                       '${_fmtPoints(customer.points)} điểm tích lũy',
//                       style: const TextStyle(
//                           fontSize: 12, color: Color(0xFF059669), fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           // Delete button
//           GestureDetector(
//             onTap: onRemove,
//             child: Container(
//               width: 34,
//               height: 34,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(Icons.delete_outline, size: 17, color: Colors.black38),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _CustomerInfo extends StatelessWidget {
  final CustomerModel customer;
  final VoidCallback? onRemove;

  const _CustomerInfo({required this.customer, this.onRemove});

  String _fmtPoints(int p) {
    return p.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]}.',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 30),
              ),
              // if (customer.isVip)
              Positioned(
                bottom: -4,
                right: -4,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF59E0B),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.star, size: 11, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      customer.name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
                    ),
                    // if (customer.isVip) ...[
                    //   const SizedBox(width: 6),
                    //   Container(
                    //     padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    //     decoration: BoxDecoration(
                    //       color: const Color(0xFFFEF3C7),
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //     child: const Text(
                    //       'VIP MEMBER',
                    //       style: TextStyle(
                    //           fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF92400E)),
                    //     ),
                    //   ),
                    // ],
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.phone_outlined, size: 12, color: Colors.black45),
                    const SizedBox(width: 4),
                    Text(customer.phone,
                        style: const TextStyle(fontSize: 13, color: Colors.black54)),
                  ],
                ),
                // const SizedBox(height: 4),
                // Row(
                //   children: [
                //     const Icon(Icons.star_outline, size: 13, color: Color(0xFF059669)),
                //     const SizedBox(width: 4),
                //     Text(
                //       '${_fmtPoints(customer.points)} điểm tích lũy',
                //       style: const TextStyle(
                //           fontSize: 12, color: Color(0xFF059669), fontWeight: FontWeight.w500),
                //     ),
                //   ],
                // ),
                // const Gap(4),
                // Row(
                //   children: [
                //     const Icon(Icons.phone_outlined, size: 12, color: Colors.black45),
                //     const SizedBox(width: 4),
                //     Text(customer.phone,
                //         style: const TextStyle(fontSize: 13, color: Colors.black54)),
                //   ],
                // ),
              ],
            ),
          ),

          if (onRemove != null)
            GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.delete_outline, size: 17, color: Colors.black38),
              ),
            ),
        ],
      ),
    );
  }
}

// ─── Not found banner ─────────────────────────────────────────────────────────
class CustomerStatusBanner extends StatelessWidget {
  const CustomerStatusBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F0),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFCDD2)),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline, size: 15, color: _red),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Không tìm thấy khách hàng. Thử tên khác hoặc tạo mới.',
              style: TextStyle(fontSize: 13, color: _red),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({
    super.key,
    required this.message,
    required this.icon,
    required this.color,
  });

  final String message;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        // color: const Color(0xFFFFF0F0),
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        // border: Border.all(color: const Color(0xFFFFCDD2)),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 15, color: color),
          const Gap(8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(fontSize: 13, color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotFoundBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F0),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFCDD2)),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline, size: 15, color: _red),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Không tìm thấy khách hàng. Vui lòng tạo mới.',
              style: TextStyle(fontSize: 13, color: _red),
            ),
          ),
        ],
      ),
    );
  }
}



/// tạo mới
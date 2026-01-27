import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/model/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online_new/state.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'provider.dart';
import 'widgets/barrel_widget.dart';

enum RequestStatus { pending, confirmed, cancelled }

class OrderRequest {
  final int id;
  final String tableName;
  final String itemName;
  final int quantity;
  final DateTime createdAt;
  final String staff;
  final RequestStatus status;

  OrderRequest({
    required this.id,
    required this.tableName,
    required this.itemName,
    required this.quantity,
    required this.createdAt,
    required this.staff,
    required this.status,
  });
}

class StatusFilterBar extends StatelessWidget {
  const StatusFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          StatusChip(label: 'Tất cả', selected: false),
          StatusChip(label: 'Chờ xử lý', selected: true),
          StatusChip(label: 'Đã xác nhận'),
          StatusChip(label: 'Đã huỷ'),
        ],
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  final String label;
  final bool selected;

  const StatusChip({
    super.key,
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        selectedColor: const Color(0xFFE3F2FD),
        onSelected: (_) {},
      ),
    );
  }
}

class OrderRequestList extends StatelessWidget {
  const OrderRequestList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        OrderRequestCard(
          index: 4,
          itemName: 'Kim chi',
          quantity: 1,
          minutesAgo: 8,
          staff: 'yenlt',
        ),
        OrderRequestCard(
          index: 3,
          itemName: 'Chân gà hấp tàu xì',
          quantity: 1,
          minutesAgo: 8,
          staff: 'yenlt',
        ),
        OrderRequestCard(
          index: 2,
          itemName: 'Gà chiên Karaage',
          quantity: 1,
          minutesAgo: 12,
          staff: 'yenlt',
        ),
      ],
    );
  }
}

class OrderRequestCard extends StatelessWidget {
  final int index;
  final String itemName;
  final int quantity;
  final int minutesAgo;
  final String staff;

  const OrderRequestCard({
    super.key,
    required this.index,
    required this.itemName,
    required this.quantity,
    required this.minutesAgo,
    required this.staff,
  });

  @override
  Widget build(BuildContext context) {
    final isLate = minutesAgo >= 10;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Lượt #$index', style: const TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                Chip(
                  backgroundColor: isLate ? Colors.orange.shade100 : Colors.green.shade100,
                  label: Text('$minutesAgo phút trước'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              itemName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text('SL: $quantity'),
            const Divider(height: 24),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                const Text('16:18 22-01-2026'),
                const Spacer(),
                Icon(Icons.person, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(staff),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.check),
                    label: const Text('Xác nhận'),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.close),
                    label: const Text('Huỷ'),
                    onPressed: () {},
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class NewOrderToOnlinePage extends ConsumerWidget {
  const NewOrderToOnlinePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<TableRequest> requests = [
      TableRequest(
        table: 'B10',
        item: 'Kim chi',
        quantity: 1,
        time: DateTime.now().subtract(const Duration(minutes: 8)),
        status: RequestStatus.pending,
      ),
      TableRequest(
        table: 'B08',
        item: 'Gà chiên Karaage',
        quantity: 1,
        time: DateTime.now().subtract(const Duration(minutes: 12)),
        status: RequestStatus.pending,
      ),
    ];
    bool showChat = true;
    bool smallDevice = ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE);
    final orderToOnline = ref.watch(orderToOnlineProvider);
    final orderSelect = ref.watch(orderToOnlinePageProvider.select((value) => value.orderSelect));
    var isMobile = AppDeviceSizeUtil.checkMobileDevice();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yêu cầu tại bàn'),
        backgroundColor: const Color(0xFFC0392B),
      ),
      body: Stack(
        children: [
          orderToOnline.when(
            skipError: false,
            data: (data) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                O2OOrderModel? order = orderSelect;

                if (data.isNotEmpty) {
                  if (orderSelect == null) {
                    order = data.keys.first;
                  } else {
                    order = data.keys
                        .toList()
                        .firstWhereOrNull((e) => e.orderId == orderSelect.orderId);
                  }
                }
                if (order != orderSelect) {
                  ref.read(orderToOnlinePageProvider.notifier).changeOrderSelect(order);
                }
              });
              return data.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            Assets.imagesProductEmpty,
                            width: isMobile ? 100 : 300,
                            height: isMobile ? 100 : 300,
                          ),
                          Text(
                            S.current.no_orders,
                            style: AppTextStyle.regular(),
                          ),
                        ],
                      ),
                    )
                  : Row(
                      children: [
                        const Gap(8),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: OrderO2oSidebar(
                              o2oData: data,
                            ),
                          ),
                        ),
                        const Gap(12),
                        const VerticalDivider(width: 1),
                        const Gap(12),
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              const Gap(12),
                              const O2oModeSwitcher(),
                              // const FilterBar(),
                              // Gap(20),
                              Expanded(child: ListO2oRequest(o2oData: data)),

                              // AnimatedContainer(
                              //   duration: const Duration(milliseconds: 250),
                              //   width: showChat ? 320 : 0,
                              //   child: showChat
                              //       ? ChatPanel(
                              //           request: requests[0],
                              //           onClose: () => setState(() => showChat = false),
                              //         )
                              //       : null,
                            ],
                          ),
                        ),
                        const Gap(12),
                      ],
                    );
            },
            error: (error, stackTrace) {
              return Center(
                child: AppErrorSimpleWidget(
                  onTryAgain: () {
                    ref.refresh(orderToOnlineProvider);
                  },
                ),
              );
            },
            loading: () {
              return const AppLoadingSimpleWidget();
            },
          ),

          Positioned(
            right: 16,
            bottom: 88,
            child: QRFloatingButton(
              onTap: () {},
            ),
          ),
          // AnimatedPositioned(
          //   duration: const Duration(milliseconds: 300),
          //   curve: Curves.easeOut,
          //   right: 16,
          //   bottom: showChat ? 90 : -420,
          //   child: const FloatingChatPanel(),
          // ),

          /// CHAT BUTTON (NEO)
          Positioned(
            right: 16,
            bottom: 16,
            child: ChatAnchorButton(
              hasUnread: true,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumn(
    String title,
    RequestStatus status,
    Color color,
  ) {
    return Container();
    // final items = requests.where((e) => e.status == status).toList();

    // return Expanded(
    //   child: Container(
    //     margin: const EdgeInsets.symmetric(horizontal: 6),
    //     decoration: BoxDecoration(
    //       color: color.withOpacity(0.08),
    //       borderRadius: BorderRadius.circular(16),
    //     ),
    //     child: Column(
    //       children: [
    //         _KanbanHeader(title: title, count: items.length, color: color),
    //         Expanded(
    //           child: ListView.builder(
    //             padding: const EdgeInsets.all(8),
    //             itemCount: items.length,
    //             itemBuilder: (_, i) => _KanbanCard(
    //               request: items[i],
    //               onConfirm: () {
    //                 setState(() => items[i].status = RequestStatus.confirmed);
    //               },
    //               onCancel: () {
    //                 setState(() => items[i].status = RequestStatus.cancelled);
    //               },
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class QRFloatingButton extends StatelessWidget {
  final VoidCallback onTap;

  const QRFloatingButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black26,
            )
          ],
        ),
        child: const Icon(Icons.qr_code, color: Colors.white),
      ),
    );
  }
}

class ChatAnchorButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool hasUnread;

  const ChatAnchorButton({
    super.key,
    required this.onTap,
    this.hasUnread = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 12,
                  color: Colors.black26,
                )
              ],
            ),
            child: const Icon(Icons.chat, color: Colors.white),
          ),
          if (hasUnread)
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            )
        ],
      ),
    );
  }
}

class FloatingChatPanel extends StatelessWidget {
  const FloatingChatPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 320,
        height: 420,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: const [
            _ChatHeader(),
            Divider(height: 1),
            Expanded(child: _ChatMessages()),
            _ChatInput(),
          ],
        ),
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  const _ChatHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: const [
          Icon(Icons.restaurant),
          SizedBox(width: 8),
          Text(
            'Chat – Bàn B10',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ChatMessages extends StatelessWidget {
  const _ChatMessages();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        _Bubble(isMe: true, text: 'Món này làm trước giúp em'),
        _Bubble(isMe: false, text: 'Ok'),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  final bool isMe;
  final String text;

  const _Bubble({required this.isMe, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text),
      ),
    );
  }
}

class _ChatInput extends StatelessWidget {
  const _ChatInput();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Nhập ghi chú...',
                isDense: true,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: const [
          _FilterChip(label: 'Tất cả bàn'),
          _FilterChip(label: 'Chờ xử lý'),
          _FilterChip(label: '≤ 10 phút'),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;

  const _FilterChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.grey.shade100,
      side: BorderSide(color: Colors.grey.shade300),
    );
  }
}

class ChatPanel extends StatelessWidget {
  final TableRequest? request;
  final VoidCallback onClose;

  const ChatPanel({
    super.key,
    required this.request,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    if (request == null) return const SizedBox();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide(color: Colors.black12)),
      ),
      child: Column(
        children: [
          // _ChatHeader(request: request!, onClose: onClose),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: const [
                _ChatBubble(
                  sender: 'yenlt',
                  message: 'Món này làm trước giúp em',
                  isMe: true,
                ),
                _ChatBubble(
                  sender: 'bếp',
                  message: 'Ok',
                  isMe: false,
                ),
              ],
            ),
          ),
          const _ChatInput(),
        ],
      ),
    );
  }
}

// class _ChatHeader extends StatelessWidget {
//   final TableRequest request;
//   final VoidCallback onClose;

//   const _ChatHeader({
//     required this.request,
//     required this.onClose,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12),
//       child: Row(
//         children: [
//           Text(
//             'Bàn ${request.table} – ${request.item}',
//             style: const TextStyle(fontWeight: FontWeight.bold),
//           ),
//           const Spacer(),
//           IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: onClose,
//           )
//         ],
//       ),
//     );
//   }
// }

class _ChatBubble extends StatelessWidget {
  final String sender;
  final String message;
  final bool isMe;

  const _ChatBubble({
    required this.sender,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isMe ? Colors.green.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(message),
      ),
    );
  }
}

// class _ChatInput extends StatelessWidget {
//   const _ChatInput();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               decoration: const InputDecoration(
//                 hintText: 'Nhập ghi chú...',
//                 border: OutlineInputBorder(),
//                 isDense: true,
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           IconButton(
//             icon: const Icon(Icons.send),
//             onPressed: () {},
//           )
//         ],
//       ),
//     );
//   }
// }

class _KanbanHeader extends StatelessWidget {
  final String title;
  final int count;
  final Color color;

  const _KanbanHeader({
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          CircleAvatar(
            radius: 12,
            backgroundColor: color,
            child: Text(
              count.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}

// enum RequestStatus { pending, confirmed, cancelled }

class TableRequest {
  final String table;
  final String item;
  final int quantity;
  final DateTime time;
  RequestStatus status;

  TableRequest({
    required this.table,
    required this.item,
    required this.quantity,
    required this.time,
    required this.status,
  });
}

class _KanbanCard extends StatelessWidget {
  final TableRequest request;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const _KanbanCard({
    required this.request,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final minutes = DateTime.now().difference(request.time).inMinutes;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _TableBadge(request.table),
              const Spacer(),
              Text(
                '$minutes phút trước',
                style: TextStyle(
                  color: minutes > 10 ? Colors.red : Colors.grey,
                  fontSize: 12,
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(
            request.item,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('SL: ${request.quantity}'),
          if (request.status == RequestStatus.pending) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancel,
                    child: const Text('Huỷ'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    child: const Text('Xác nhận'),
                  ),
                ),
              ],
            )
          ]
        ],
      ),
    );
  }
}

class _TableBadge extends StatelessWidget {
  final String table;

  const _TableBadge(this.table);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        table,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

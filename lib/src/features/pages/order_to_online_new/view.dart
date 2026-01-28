import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/data/model/o2o/o2o_config.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/processing.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/settings/widgets/dialog/o2o_auto_process_config.dart';
import 'package:aladdin_franchise/src/features/widgets/app_error_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';
import 'package:aladdin_franchise/src/features/widgets/app_loading_simple.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'provider.dart';
import 'state.dart';
import 'widgets/barrel_widget.dart';

enum RequestStatus { pending, confirmed, cancelled }

class NewOrderToOnlinePage extends ConsumerStatefulWidget {
  const NewOrderToOnlinePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewOrderToOnlinePageState();
}

class _NewOrderToOnlinePageState extends ConsumerState<NewOrderToOnlinePage> {
  _listenEvent(BuildContext context, WidgetRef ref) =>
      (OrderToOnlineEvent? previous, OrderToOnlineEvent? next) {
        final state = ref.read(orderToOnlinePageProvider);
        switch (next) {
          case OrderToOnlineEvent.loading:
            showProcessingDialog(
              context,
              message: state.message,
            );
            break;
          case OrderToOnlineEvent.success:
            Navigator.pop(context);
            break;
          case OrderToOnlineEvent.error:
            Navigator.pop(context);
            showMessageDialog(
              context,
              message: state.message,
            );
            break;
          default:
            break;
        }
      };
  @override
  Widget build(BuildContext context) {
    ref.listen<OrderToOnlineEvent>(
      orderToOnlinePageProvider.select((value) => value.event),
      _listenEvent(context, ref),
    );
    bool smallDevice =
        ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE);
    final orderToOnline = ref.watch(orderToOnlineProvider);
    final orderIdSelect = ref.watch(
        orderToOnlinePageProvider.select((value) => value.orderIdSelect));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yêu cầu tại bàn'),
        backgroundColor: const Color(0xFFC0392B),
        actions: [
          ResponsiveIconButtonWidget(
            iconData: Icons.refresh,
            onPressed: () {
              ref.refresh(orderToOnlineProvider);
              ref.read(orderToOnlinePageProvider.notifier).getChatMessages();
            },
          ),
          ResponsiveIconButtonWidget(
            iconData: Icons.settings,
            onPressed: () async {
              var o2oConfig = ref.read(o2oConfigProvider).when(
                    data: (data) => data,
                    error: (error, stackTrace) => O2oConfigModel(),
                    loading: () => O2oConfigModel(),
                  );
              var config = await showO2oAutoProcessConfigDialog(
                context,
                o2oConfig,
              );
              if (config != null) {
                var result = await ref
                    .read(homeProvider.notifier)
                    .saveO2oAutoProcessConfig(config);
                if (result != null) {
                  showMessageDialog(context, message: result);
                }
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          orderToOnline.when(
            skipError: false,
            data: (data) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                int? orderId = orderIdSelect;
                if (data.isNotEmpty) {
                  var check = orderIdSelect == null
                      ? null
                      : data.keys
                          .toList()
                          .firstWhereOrNull((e) => e == orderIdSelect);
                  orderId = check ?? data.keys.firstOrNull;
                } else {
                  orderId = null;
                }
                ref
                    .read(orderToOnlinePageProvider.notifier)
                    .changeOrderSelect(orderId);
              });
              return data.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            Assets.imagesProductEmpty,
                            width: smallDevice ? 100 : 300,
                            height: smallDevice ? 100 : 300,
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
                              Row(
                                children: [
                                  const Expanded(child: O2oModeSwitcher()),
                                  const Gap(12),
                                  Consumer(
                                    builder: (context, ref, child) {
                                      final sortByNewestTime = ref.watch(
                                          orderToOnlinePageProvider.select(
                                              (value) =>
                                                  value.sortByNewestTime));
                                      String text = S.current.latest;
                                      String icon = Assets.iconsSortDescending;
                                      if (!sortByNewestTime) {
                                        text = S.current.oldest;
                                        icon = Assets.iconsSortAscending;
                                      }
                                      return InkWell(
                                        onTap: ref
                                            .read(orderToOnlinePageProvider
                                                .notifier)
                                            .changeSortByNewestTime,
                                        borderRadius:
                                            AppConfig.borderRadiusMain,
                                        child: Tooltip(
                                          message: text,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                              icon,
                                              color: Colors.black,
                                              width: 24,
                                              height: 24,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const Gap(12),
                              Expanded(child: ListO2oRequest(o2oData: data)),
                              const Gap(12),
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
          Consumer(builder: (context, ref, child) {
            var showChat = ref.watch(
                orderToOnlinePageProvider.select((value) => value.showChat));
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              right: 16,
              bottom: showChat ? (48 + 90) : -420,
              child: const FloatingChatPanel(),
            );
          }),
          Positioned(
            right: 16,
            bottom: 88,
            child: ChatAnchorButton(
              hasUnread: false,
              onTap: () {
                ref
                    .read(orderToOnlinePageProvider.notifier)
                    .onChangeShowChat(null);
              },
            ),
          ),
          if (orderIdSelect != null)
            Positioned(
              right: 16,
              bottom: 16,
              child: Row(
                children: [
                  const BtnO2oNotification(),
                  Gap(12),
                  BtnO2oQrCode(),
                ],
              ),
            ),
        ],
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

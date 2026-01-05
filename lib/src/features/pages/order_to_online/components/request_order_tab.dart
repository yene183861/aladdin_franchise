import 'package:aladdin_franchise/generated/assets.dart';
import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_input.dart';
import 'package:aladdin_franchise/src/features/dialogs/payment_cancel.dart';
// import 'package:aladdin_franchise/src/features/dialogs/detail_product_checkout.dart';
// import 'package:aladdin_franchise/src/features/dialogs/payment_cancel.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/pages/login/view.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/components/barrel_components.dart';
import 'package:aladdin_franchise/src/features/pages/order_to_online/provider.dart';
import 'package:aladdin_franchise/src/features/widgets/empty.dart';
import 'package:aladdin_franchise/src/features/widgets/gap.dart';
import 'package:aladdin_franchise/src/features/widgets/refresh_data.dart';
import 'package:aladdin_franchise/src/models/o2o/chat_message_model.dart';
import 'package:aladdin_franchise/src/models/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/models/o2o/request_order.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/size_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:aladdin_franchise/src/configs/color.dart';
import 'package:aladdin_franchise/src/configs/text_style.dart';
import 'package:aladdin_franchise/src/features/widgets/app_icon_widget.dart';

import 'custom_checkbox.dart';
import 'chat_message_item.dart';
import 'request_order_item.dart';
import 'status_request.dart';

class OrderToOnlineBodyPage extends ConsumerWidget {
  const OrderToOnlineBodyPage({super.key, this.o2oData = const {}});
  final Map<O2OOrderModel, Map<String, dynamic>> o2oData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestWidget = _ListRequestWidget(o2oData: o2oData);
    const chatWidget = _ChatContentWidget();
    var showChatTab = ref.watch(orderToOnlinePageProvider.select((value) => value.showChatTab));
    bool isSmallDebice = AppDeviceSizeUtil.checkSmallDevice(context);
    return isSmallDebice
        ? Column(
            children: [
              Row(
                children: [
                  _buildTab(
                    title: 'Yêu cầu',
                    onTap: () {
                      ref
                          .read(orderToOnlinePageProvider.notifier)
                          .onChangeShowChatTab(value: false);
                    },
                    selected: !showChatTab,
                  ),
                  _buildTab(
                    title: 'Tin nhắn',
                    onTap: () {
                      ref.read(orderToOnlinePageProvider.notifier).onChangeShowChatTab(value: true);
                    },
                    selected: showChatTab,
                  ),
                ],
              ),
              Expanded(
                child: IndexedStack(
                  index: showChatTab ? 1 : 0,
                  children: [
                    requestWidget,
                    chatWidget,
                  ],
                ),
              ),
            ],
          )
        : Row(
            children: [
              Expanded(
                flex: 2,
                child: requestWidget,
              ),
              if (showChatTab) ...[
                VerticalDivider(
                  width: 1,
                  color: Colors.grey.shade400,
                ),
                const Expanded(
                  flex: 1,
                  child: chatWidget,
                ),
              ],
            ],
          );
  }

  Widget _buildTab({
    VoidCallback? onTap,
    required String title,
    bool selected = false,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: selected ? AppColors.secondColor : Colors.grey.shade400,
          child: Center(
            child: Text(
              title,
              style: AppTextStyle.bold(),
            ),
          ),
        ),
      ),
    );
  }
}

class _ListRequestWidget extends ConsumerWidget {
  const _ListRequestWidget({
    this.o2oData = const {},
  });

  final Map<O2OOrderModel, Map<String, dynamic>> o2oData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusFilter = ref.watch(orderToOnlinePageProvider.select((value) => value.statusFilter));
    final sortByNewestTime =
        ref.watch(orderToOnlinePageProvider.select((value) => value.sortByNewestTime));
    final orderSelect = ref.watch(orderToOnlinePageProvider.select((value) => value.orderSelect));
    var count = o2oData[orderSelect]?['count'] ?? 0;
    List<RequestOrderModel> requests = List<RequestOrderModel>.from(
        orderSelect == null ? [] : (o2oData[orderSelect]?['items'] ?? []));
    if (statusFilter != RequestProcessingStatus.all) {
      requests.removeWhere((e) => e.requestProcessingStatus != statusFilter);
    }
    // xoá tất cả lượt gọi mà ko có món nào (đã được xử lý hết)
    requests = requests.where((element) => element.listItem.isNotEmpty).toList();
    if (sortByNewestTime) {
      // mới nhất -> cũ nhất
      requests.sort((a, b) =>
          (a.timeOrder == null || b.timeOrder == null) ? 0 : b.timeOrder!.compareTo(a.timeOrder!));
    } else {
      requests.sort((a, b) =>
          (a.timeOrder == null || b.timeOrder == null) ? 0 : a.timeOrder!.compareTo(b.timeOrder!));
    }

    String emptyMessage = S.current.no_orders_to_confirm;
    if (statusFilter != RequestProcessingStatus.all) {
      switch (statusFilter) {
        case RequestProcessingStatus.accept:
          emptyMessage = S.current.no_previously_confirmed_order_requests;
          break;
        case RequestProcessingStatus.cancel:
          emptyMessage = S.current.no_orders_have_been_cancelled;
          break;
        default:
      }
    }
    if (requests.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Builder(builder: (context) {
            //   bool isSmallDebice = AppDeviceSizeUtil.checkSmallDevice(context);
            //   return Image.asset(
            //     AppImages.imgRequestOrder,
            //     // 150
            //     width: isSmallDebice ? 60 : 100,
            //     height: isSmallDebice ? 60 : 100,
            //   );
            // }),
            const GapH(12),
            Text(
              emptyMessage,
              style: AppTextStyle.regular(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    return Column(
      children: [
        if (count > 0 &&
            [RequestProcessingStatus.all, RequestProcessingStatus.waiting].contains(statusFilter))
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              CustomButtonAction(
                title: S.current.confirm,
                bgColor: RequestProcessingStatus.waiting.color.withOpacity(0.2),
                textColor: RequestProcessingStatus.waiting.color,
                onTap: () async {
                  final orderItems =
                      ref.read(orderToOnlinePageProvider).requestSelect?.listItem ?? [];
                  if (orderItems.isEmpty) return;

                  var orderNote = await showConfirmInputDialog(
                    context,
                    title: S.current.confirm,
                    message: S.current.orderConfirm,
                    textAction: S.current.agree,
                    hintText: S.current.notes,
                    labelInput: S.current.notes,
                    maxLineInput: 3,
                  );
                  if (orderNote != null) {
                    ref
                        .read(orderToOnlinePageProvider.notifier)
                        .acceptRequest(note: orderNote, context: context);
                  }
                },
              ),
              const Gap(8),
              CustomButtonAction(
                title: S.current.cancel,
                bgColor: Colors.red.withOpacity(0.1),
                textColor: Colors.red.shade500,
                onTap: () async {
                  final orderItems =
                      ref.read(orderToOnlinePageProvider).requestSelect?.listItem ?? [];
                  if (orderItems.isEmpty) return;

                  await showPaymentCancelDialog(
                    context,
                    onAction: (content) {
                      ref.read(orderToOnlinePageProvider.notifier).cancelRequest(reason: content);
                    },
                  );
                },
              ),
              const Gap(12),
            ],
          ),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding:
                EdgeInsets.only(bottom: (orderSelect?.qrOrderO2o.isNotEmpty ?? false) ? 70 : 0),
            itemBuilder: (context, index) => RequestOrderWidget(requestOrderModel: requests[index]),
            itemCount: requests.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.blueGrey,
              thickness: 0.5,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}

class _ChatContentWidget extends ConsumerWidget {
  const _ChatContentWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getChatMessageState =
        ref.watch(orderToOnlinePageProvider.select((value) => value.getChatMessageState));
    final chatMessages = ref.watch(orderToOnlinePageProvider.select((value) => value.chatMessages));

    return ListChatWidget(
      state: getChatMessageState,
      chatMessages: chatMessages,
      onReload: ref.read(orderToOnlinePageProvider.notifier).getChatMessages,
      paddingBottom: 70,
    );
  }
}

class RequestOrderWidget extends ConsumerWidget {
  const RequestOrderWidget({
    super.key,
    required this.requestOrderModel,
  });

  final RequestOrderModel requestOrderModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var request = requestOrderModel;

    var requestSelect = ref.watch(orderToOnlinePageProvider.select((value) => value.requestSelect));

    var itemsSelect = requestSelect?.listItem ?? [];

    final length = request.listItem.length;
    var selectedCodeProducts = {...itemsSelect.map((e) => e.codeProduct).toList()};
    var codeProducts = {...request.listItem.map((e) => e.codeProduct).toList()};
    bool selectAll = request.id == requestSelect?.id &&
        const SetEquality().equals(selectedCodeProducts, codeProducts);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(right: 8),
            child: Row(
              children: [
                Text(
                  '${S.current.turn} #${request.orderTimes.toString()}',
                  style: AppTextStyle.bold(),
                ),
                const Gap(6),
                switch (request.requestProcessingStatus) {
                  RequestProcessingStatus.waiting => const SizedBox.shrink(),
                  RequestProcessingStatus.accept => const StatusRequestWidget(acceptedStatus: true),
                  RequestProcessingStatus.cancel => const StatusRequestWidget(),
                  RequestProcessingStatus.all => const SizedBox.shrink(),
                },
                if (request.timeOrder != null && !request.isProcessed) ...[
                  const Gap(4),
                  RequestTimeWidget(
                    dateTime: request.timeOrder!,
                    requestProcessingStatus: request.requestProcessingStatus,
                  ),
                ],
                const Gap(8),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (request.timeOrder != null) ...[
                        ResponsiveIconWidget(
                          iconData: Icons.access_time,
                          color: Colors.grey.shade700,
                        ),
                        const Gap(4),
                        Flexible(
                          child: Text(
                            DateTimeUtils.formatToString(
                              time: request.timeOrder!.toLocal(),
                              newPattern: 'HH:mm dd-MM-yyyy',
                            ),
                            style: AppTextStyle.regular(rawFontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                      const Gap(8),
                      ResponsiveIconWidget(
                        iconData: Icons.person,
                        color: Colors.grey.shade700,
                      ),
                      const Gap(4),
                      Flexible(
                        child: Text(
                          request.userSender,
                          style: AppTextStyle.regular(rawFontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (request.isProcessed)
            Container(
              padding: const EdgeInsets.only(left: 62),
              child: ReasonCancelItemWidget(
                reason: request.notes,
                isCancel: request.isCanceled,
              ),
            ),
          if (length > 1 && !request.isProcessed) ...[
            const Gap(4),
            GestureDetector(
              onTap: () {
                ref.read(orderToOnlinePageProvider.notifier).selectAllRequestItem(
                      request: request,
                      selectAll: !selectAll,
                    );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomCheckbox(
                      onChange: () {
                        ref.read(orderToOnlinePageProvider.notifier).selectAllRequestItem(
                              request: request,
                              selectAll: !selectAll,
                            );
                      },
                      checked: selectAll,
                    ),
                    Text(
                      S.current.select_all,
                      style: AppTextStyle.regular(),
                    ),
                  ],
                ),
              ),
            ),
            const GapH(8),
          ],
          Flexible(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = request.listItem[index];

                bool selected = request.id == requestSelect?.id &&
                    requestSelect?.listItem.firstWhereOrNull((e) => e.id == item.id) != null;
                return RequestItemWidget(
                  request: request,
                  item: item,
                  selected: selected,
                );
              },
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey.shade300,
                height: 0,
                indent: 56,
                thickness: 0.5,
              ),
              itemCount: length,
            ),
          ),
        ],
      ),
    );
  }
}

class ListChatWidget extends StatelessWidget {
  const ListChatWidget({
    super.key,
    required this.state,
    required this.chatMessages,
    this.onReload,
    this.paddingBottom = 0,
  });
  final PageState state;
  final List<ChatMessageModel> chatMessages;
  final VoidCallback? onReload;
  final double paddingBottom;

  @override
  Widget build(BuildContext context) {
    bool isMobile = AppDeviceSizeUtil.checkMobileDevice();
    bool isTablet = AppDeviceSizeUtil.checkTabletDevice();
    bool portraitOrientation = AppDeviceSizeUtil.checkPortraitOrientation(context);

    bool useTab = (isMobile || (isTablet && portraitOrientation));
    switch (state.status) {
      case PageCommonState.loading:
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.bgTitleChatPopup,
          ),
        );
      case PageCommonState.error:
        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  S.current.unable_to_load_chat_content,
                  style: AppTextStyle.regular(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (state.messageError.trim().isNotEmpty)
                  Text(
                    state.messageError,
                    style: AppTextStyle.regular(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                const GapH(4),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: onReload,
                  color: AppColors.bgButtonMain,
                  textColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      S.current.tryAgain,
                      style: AppTextStyle.regular().copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      default:
        if (chatMessages.isEmpty) {
          return EmptyWidget(
            message: S.current.no_messages,
            onRefresh: () {
              onReload?.call();
            },
            emptyImage: SvgPicture.asset(
              Assets.iconsChat,
              height: 36,
              width: 36,
            ),
          );
        }
        Map<DateTime, List<ChatMessageModel>> map =
            chatMessages.groupListsBy((e) => e.createdAt.onlyDate());
        List<DateTime> dates = map.keys.toList();
        dates.sort(
          (a, b) => b.compareTo(a),
        );
        return RefreshDataWidget(
          onRefresh: () {
            onReload?.call();
          },
          child: ListView.builder(
            padding: EdgeInsets.only(top: 4, bottom: paddingBottom),
            shrinkWrap: true,
            reverse: true,
            itemBuilder: (context, index) {
              var date = dates[index];
              return ChatMessageGroupByDateItem(
                datetime: dates[index],
                messages: map[date] ?? [],
                showDate: dates.length > 1,
              );
            },
            itemCount: dates.length,
          ),
        );
    }
  }
}

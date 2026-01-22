import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/data/model/o2o/chat_message_model.dart';
import 'package:aladdin_franchise/src/data/model/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/data/model/o2o/request_order.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum OrderToOnlineTab {
  requestService,
  requestOrder,
}

extension OrderToOnlineTabEx on OrderToOnlineTab {
  String get title {
    switch (this) {
      case OrderToOnlineTab.requestService:
        return 'Phục vụ';
      case OrderToOnlineTab.requestOrder:
        return 'Gọi món';
      default:
        return '';
    }
  }
}

enum OrderToOnlineEvent {
  normal,
  loading,
  error,
  success,
}

@freezed
class OrderToOnlineState with _$OrderToOnlineState {
  const factory OrderToOnlineState({
    @Default('') String message,
    @Default(OrderToOnlineEvent.normal) OrderToOnlineEvent event,
    O2OOrderModel? orderSelect,
    // message
    @Default([]) List<ChatMessageModel> chatMessages,
    @Default(PageState()) PageState getChatMessageState,

    // filter
    @Default(RequestProcessingStatus.waiting) RequestProcessingStatus statusFilter,
    @Default(true) bool sortByNewestTime,
    @Default(true) bool showChatTab,
    // printers
    @Default([]) List<IpOrderModel> printers,
    IpOrderModel? printerSelect,

    /// key:  O2OOrderModel.copyWith(items: [])
    /// value: Map<String, dynamic>
    /// {
    /// "items" : List<RequestOrderModel>,
    /// "count" : int,
    /// }
    @Default({}) Map<O2OOrderModel, Map<String, dynamic>> orders,
    RequestOrderModel? requestSelect,

    /// các đơn bàn đang khoá
    @Default({}) Set<int> lockedOrderIds,
    @Default(true) bool showLoadingGetData,
  }) = _OrderToOnlineState;
}

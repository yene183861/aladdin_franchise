import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/data/model/o2o/chat_message_model.dart';
import 'package:aladdin_franchise/src/data/model/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/data/model/o2o/request_order.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum O2oViewModeEnum { all, kanban }

extension O2oViewModeEnumEx on O2oViewModeEnum {
  String get title {
    switch (this) {
      case O2oViewModeEnum.all:
        return 'Tất cả';
      case O2oViewModeEnum.kanban:
        return 'Kanban';
      default:
        return '';
    }
  }

  String get icon {
    switch (this) {
      case O2oViewModeEnum.all:
        return '📋';
      case O2oViewModeEnum.kanban:
        return '🧩';
      default:
        return '';
    }
  }
}

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
    @Default(O2oViewModeEnum.all) O2oViewModeEnum viewMode,
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

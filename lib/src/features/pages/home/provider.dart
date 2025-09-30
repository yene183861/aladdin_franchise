import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/configs/data_fake.dart';
import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/configs/enums/type_order.dart';
import 'package:aladdin_franchise/src/configs/enums/windows_method.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/category/category_repository.dart';
import 'package:aladdin_franchise/src/core/network/coupon/coupon_repository.dart';
import 'package:aladdin_franchise/src/core/network/customer/customer_repository.dart';
import 'package:aladdin_franchise/src/core/network/order/order_repository.dart';
import 'package:aladdin_franchise/src/core/network/product/product_repository.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/network/responses/data_bill.dart';
import 'package:aladdin_franchise/src/core/network/responses/order.dart';
import 'package:aladdin_franchise/src/core/network/restaurant/restaurant_repository.dart';
import 'package:aladdin_franchise/src/core/network/user/user_repository.dart';
import 'package:aladdin_franchise/src/core/services/local_network.dart';
import 'package:aladdin_franchise/src/core/services/task_queue.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/features/dialogs/confirm_action.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/pages/customer/view.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/models/atm_pos.dart';
import 'package:aladdin_franchise/src/models/category.dart';
import 'package:aladdin_franchise/src/models/combo_item.dart';
import 'package:aladdin_franchise/src/models/customer/cusomter_portrait.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/employee_sale.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/minvoice/minvoice.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/order_history.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';
import 'package:aladdin_franchise/src/models/param_family/bank_param.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/policy_result.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/models/reservation/reservation.dart';
import 'package:aladdin_franchise/src/models/tag_product.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';
import 'package:aladdin_franchise/src/utils/app_helper.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_common.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_html.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_normal.dart';
import 'package:aladdin_franchise/src/utils/app_printer/test_printer.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/ip_config_helper.dart';
import 'package:aladdin_franchise/src/utils/product_helper.dart';
import 'package:collection/collection.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redis/redis.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:aladdin_franchise/src/models/o2o/local_notification_model.dart';
import 'package:aladdin_franchise/src/models/o2o/notification_model.dart';
import 'package:aladdin_franchise/src/models/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/models/o2o/request_order.dart';

import '../../../../generated/l10n.dart';
import '../../../core/storages/provider.dart';

enum HomePaymentError {
  printBill,
  temp,
  complete,
}

final homeProvider =
    StateNotifierProvider.autoDispose<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(
    ref,
    ref.read(orderRepositoryProvider),
    ref.read(userRepositoryProvider),
    ref.read(customerRepositoryProvider),
    ref.read(couponRepositoryProvider),
    ref.read(restaurantRepositoryProvider),
    ref.read(categoryRepositoryProvider),
    ref.read(productRepositoryProvider),
  );
});

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier(
    this.ref,
    this._orderRepository,
    this._userRepository,
    this._customerRepository,
    this._couponRepository,
    this._restaurantRepository,
    this._categoryRepository,
    this._productRepository,
  ) : super(const HomeState()) {
    AppConfig.initHomeProvider = true;
    ctrlSearch = TextEditingController();
    // if (!useDataFake) listenRedisChannel();
  }

  final Ref ref;
  final OrderRepository _orderRepository;
  final UserRepository _userRepository;
  final CustomerRepository _customerRepository;
  final CouponRepository _couponRepository;
  final RestaurantRepository _restaurantRepository;
  final CategoryRepository _categoryRepository;
  final ProductRepository _productRepository;
  Map<dynamic, GlobalKey> categoryKeys = {};

  final ItemScrollController categoryScrollController = ItemScrollController();
  final ItemPositionsListener categoryPositionsListener =
      ItemPositionsListener.create();

  late TextEditingController ctrlSearch;

  Timer? _updateOrderItemTimer;
  bool _ignoreTimerCallback = false;

  /// số lần đã in bill xuống bếp
  int printKitchenBill = 0;

  /// check biến này
  List<ProductCheckoutModel> productCheckouts = [];

  List<PaymentMethod> _listPaymentMethods = [];

  /// bắt buộc update lại thuế với giá trị mặc định
  bool requireUpdateDefaultTax = false;

  final currentOrderItemsScrollCtrl = ItemScrollController();
  final currentOrderItemsPositionsListener = ItemPositionsListener.create();

  final selectedOrderItemsScrollCtrl = ItemScrollController();
  final selectedOrderItemsPositionsListener = ItemPositionsListener.create();

  final selectingOrderItemsScrollCtrl = ItemScrollController();
  final selectingOrderItemsPositionsListener = ItemPositionsListener.create();

  List<IpOrderModel> paymentPrinter = [];
  List<LineItemDataBill> itemPrint = [];
  List<HistoryPolicyResultModel> voucherPrint = [];

  @override
  void dispose() {
    _updateOrderItemTimer?.cancel();
    AppConfig.initHomeProvider = false;
    ctrlSearch.dispose();
    super.dispose();
  }

  void _lockOrder(dynamic ex) {
    if (ex is AppException && ex.errorCode == 423) {
      state = state.copyWith(lockedOrder: true);
    }
  }

  Future<void> _checkOrderSelect() async {
    if (state.orderSelect == null) {
      _resetOrder();
      throw S.current.noOrderSelect;
    }
    return;
  }

  Future<void> _checkLockedOrder() async {
    try {
      await _checkOrderSelect();
      if (state.lockedOrder) throw S.current.msg_locked_order;
      return;
    } catch (ex) {
      rethrow;
    }
  }

  void _startUpdateOrderItemTimer() {
    _updateOrderItemTimer?.cancel();
    if (!state.autoSaveOrder) return;
    _updateOrderItemTimer = Timer.periodic(
      // const Duration(milliseconds: 100),
      const Duration(seconds: 1),
      (timer) async {
        if (_ignoreTimerCallback) return;
        try {
          _ignoreTimerCallback = true;
          state = state.copyWith(
              dataBillState: const PageState(status: PageCommonState.loading));
          await handleOrderItem();
        } catch (ex) {
          //
        }
        _ignoreTimerCallback = false;
      },
    );
  }

  void initialize({
    bool loadProducts = true,
    OrderModel? order,
  }) {
    if (!mounted) return;

    getOrderToOnline();
    ctrlSearch.text = '';
    final dataLogin = LocalStorage.getDataLogin();
    final customerPortraits = dataLogin?.customerPortraits ?? [];
    bool autoSaveOrder = false;
    List<OrderTabEnum> orderTabs = autoSaveOrder
        ? [OrderTabEnum.all]
        : [OrderTabEnum.ordering, OrderTabEnum.ordered];

    OrderTabEnum orderTabSelect =
        orderTabs.firstWhereOrNull((e) => e == state.orderTabSelect) ??
            orderTabs.firstOrNull ??
            OrderTabEnum.all;
    state = state.copyWith(
      orderSelect: order,
      categorySelect: null,
      subCategorySelect: null,
      tagSelect: null,
      customerPortraits: customerPortraits,
      banks: [],
      search: '',
      paymentMethods: [],
      listAtmPos: [],
      autoSaveOrder: autoSaveOrder,
      orderTabSelect: orderTabSelect,
      orderTabs: orderTabs,
    );
    _listPaymentMethods = [];
    productCheckouts = [];
    paymentPrinter = [];
    itemPrint = [];
    voucherPrint = [];
    _resetOrder();
    if (loadProducts) {
      getProducts();
    }
    if (order != null) {
      getOrderProductCheckout();
      getOrderInvoice();
    }
  }

  void updateEvent(HomeEvent? event) {
    state = state.copyWith(event: event ?? HomeEvent.normal);
  }

  void changeOrderSelect(OrderModel? orderModel) async {
    if (state.orderSelect != null) {
      try {
        await LocalStorage.saveApplyAgainOnlyCoupon(
          order: state.orderSelect!,
          coupons: state.needApplyAgainOnlyCoupons,
        );
      } catch (ex) {
        showLogs(ex.toString(), flags: 'lưu lại mã only');
      }
    }
    state = state.copyWith(orderSelect: orderModel);
    paymentPrinter = [];
    itemPrint = [];
    voucherPrint = [];
    _resetOrder();
    if (orderModel != null) {
      if (orderModel.typeOrder != kTypeOrder) {
        await LocalStorage.setTypeOrderWaiter(orderModel.typeOrder);
        ref.refresh(typeOrderWaiterProvider);
        ref.read(homeProvider.notifier).initialize(order: orderModel);
      } else {
        getOrderProductCheckout(changeSelecting: true);
        getOrderInvoice();
      }
    }
  }

  /// lấy danh sách các món đã gọi (đã lưu vào db)
  ///
  /// loadingProductCheckout = true - hiện loading khi lấy dữ liệu (danh sách món đang gọi)
  ///
  /// changeSelecting = true - dữ liệu lấy được có ghi đè các món đang gọi?
  Future<void> getOrderProductCheckout({
    bool loadingProductCheckout = true,
    bool changeSelecting = true,
    bool loadingHome = false,
    bool applyPolicy = true,
    bool ignoreGetDataBill = false,
  }) async {
    try {
      if (loadingProductCheckout) {
        state = state.copyWith(
            productCheckoutState:
                const PageState(status: PageCommonState.loading));
      }
      if (loadingHome) updateEvent(HomeEvent.getProductCheckout);

      int tryAgain = 0;
      while (tryAgain < 3) {
        try {
          if (state.orderSelect == null) {
            tryAgain == 3;
            throw S.current.noOrderSelect;
          }
          final productRepo =
              await _orderRepository.getProductCheckout(state.orderSelect!);
          final pc = List<ProductCheckoutModel>.from(
              productRepo.data?.first.orderItem ?? []);

          /// check here
          productCheckouts = List.from(pc);
          final coupons =
              List<CustomerPolicyModel>.from(productRepo.coupons ?? []);
          final customer = productRepo.customer;
          var orderHistory = productRepo.data?.first.orderHistory ?? [];
          state = state.copyWith(orderHistory: orderHistory);
          var order = state.orderSelect!;
          var noteEachProductItem =
              LocalStorage.getNotePerOrderItem(order: order);
          List<ProductModel> currentOrderItems = [];
          List<ProductModel> productsSelected = [];

          // map: ProductCheckoutModel -> ProductModel
          // với những món đã bị khóa thì có nên bỏ qua hay k?
          // logic code hiện tại:
          // đã khóa thì k hiển thị trên UI nhưng mà thông tin bill sẽ hiện thị k khớp
          // VD: ko có món nào nhưng tổng tiền # 0
          // chưa confirm cách xử lý
          for (var item in pc) {
            var p = state.products.firstWhereOrNull((e) => e.id == item.id);
            if (p != null) {
              var changeProduct = p.copyWith(
                numberSelecting: item.quantity,
                noteForProcessOrder:
                    noteEachProductItem?[p.id.toString()] ?? '',
              );
              productsSelected.add(changeProduct);
              currentOrderItems.add(changeProduct);
            }
          }

          List<CustomerPolicyModel> needApplyAgainOnlyCoupons = [];
          try {
            needApplyAgainOnlyCoupons =
                await LocalStorage.getApplyAgainOnlyCouponForOrder(
                    order: order);
          } catch (ex) {
            //
          }

          for (final c in coupons) {
            if (c.only) {
              if (!needApplyAgainOnlyCoupons.any((e) => e.id == c.id)) {
                needApplyAgainOnlyCoupons.removeWhere((e) => e.id == c.id);
              }
            }

            /// cập nhật số lượng món 0 đồng
            if (c.isPromotion()) {
              final discountUpdate = List<DiscountPolicy>.from(c.discount);

              for (int dc = 0; dc < discountUpdate.length; dc++) {
                final dcIndex = discountUpdate[dc];

                for (final pt in c.promotionItems) {
                  if (pt.menuItemId.toString() == dcIndex.id) {
                    discountUpdate[dc] =
                        dcIndex.copyWith(numberSelect: pt.quantity);
                    // cập nhật số lượng món tặng 0 đồng
                    var p = currentOrderItems
                        .firstWhereOrNull((e) => e.id == pt.menuItemId);
                    if (p != null) {
                      // các món đang chọn
                      var index = currentOrderItems.indexOf(p);
                      if (index != -1) {
                        currentOrderItems[index] = p.copyWith(
                            quantityPromotion:
                                p.quantityPromotion + pt.quantity);
                      }
                      // các món đã lưu trên server
                      var ps = productsSelected
                          .firstWhereOrNull((e) => e.id == pt.menuItemId);
                      if (ps != null) {
                        if (index != -1) {
                          productsSelected[index] = ps.copyWith(
                              quantityPromotion:
                                  ps.quantityPromotion + pt.quantity);
                        }
                      }
                      var pcout =
                          pc.firstWhereOrNull((e) => e.id == pt.menuItemId);
                      if (pcout != null) {
                        if (index != -1) {
                          pc[index] = pcout.copyWith(
                              quantityPromotion:
                                  (ps?.quantityPromotion ?? 0) + pt.quantity);
                        }
                      }
                    }
                  }
                }
              }
              coupons[coupons.indexOf(c)] =
                  c.copyWith(discount: discountUpdate);
            }
          }
          state = state.copyWith(
            needApplyAgainOnlyCoupons: needApplyAgainOnlyCoupons,
            coupons: coupons,
            customer: customer,
            productsSelected: productsSelected,
            currentOrderItems:
                changeSelecting ? currentOrderItems : state.currentOrderItems,
            productCheckout: pc,
            numberOfAdults: max(productRepo.numberOfAdults, 1),
          );

          OrderHistory? history = orderHistory.isEmpty
              ? null
              : orderHistory
                  .reduce((a, b) => b.timesOrder > a.timesOrder ? b : a);
          printKitchenBill = history == null ? 0 : history.timesOrder;
          if (loadingProductCheckout) {
            state = state.copyWith(
                productCheckoutState:
                    const PageState(status: PageCommonState.success));
          }
          if (loadingHome) updateEvent(HomeEvent.normal);
          if (applyPolicy) {
            applyCustomerPolicy(loadingHome: false);
          } else {
            if (!ignoreGetDataBill) getDataBill();
          }
          break;
        } catch (ex) {
          if (ex is AppException && ex.errorCode == 423) {
            tryAgain == 3;
            state = state.copyWith(lockedOrder: true);
          }
          tryAgain++;
          if (tryAgain >= 3) {
            rethrow;
          }
        }
      }
    } catch (ex) {
      getDataBill();
      if (loadingProductCheckout) {
        state = state.copyWith(
          productCheckoutState: PageState(
            status: PageCommonState.error,
            messageError: ex.toString(),
          ),
        );
      }
      if (loadingHome) updateEvent(HomeEvent.normal);
    }
  }

  void changeCategorySelect(CategoryModel? categoryModel) {
    state = state.copyWith(categorySelect: categoryModel);

    if ((categoryModel?.children ?? []).isEmpty) {
      ref.read(homeProvider.notifier).changeSubCategorySelect(null);
    } else {
      var subCategorySelect = state.subCategorySelect;
      var checkSubCategorySelect = categoryModel?.children
          ?.firstWhereOrNull((e) => e == subCategorySelect);
      if (subCategorySelect == null || checkSubCategorySelect == null) {
        ref.read(homeProvider.notifier).changeSubCategorySelect(
            (categoryModel?.children?.isEmpty ?? true)
                ? null
                : categoryModel!.children!.first);
      }
    }
  }

  void changeSubCategorySelect(SubCategoryModel? subCategoryModel) {
    if (state.subCategorySelect == subCategoryModel) return;
    state = state.copyWith(subCategorySelect: subCategoryModel);
  }

  Future<String?> addProductToOrder({required ProductModel product}) async {
    if (state.orderSelect == null) {
      return S.current.noOrderSelect;
    }
    _updateOrderItemTimer?.cancel();
    state = state.copyWith(isOrderSaved: false);
    var currentOrderItems = List<ProductModel>.from(state.currentOrderItems);
    var productsSelecting = List<ProductModel>.from(state.productsSelecting);
    var item = currentOrderItems.firstWhereOrNull((e) => e.id == product.id);
    if (item != null) {
      var index = currentOrderItems.indexOf(item);
      if (index != -1) {
        currentOrderItems[index] =
            product.copyWith(numberSelecting: max(0, item.numberSelecting) + 1);
      }
    } else {
      currentOrderItems.add(product.copyWith(numberSelecting: 1));
    }

    var ind = productsSelecting.indexWhere((e) => e.id == product.id);
    if (ind != -1) {
      var item = productsSelecting[ind];
      productsSelecting[ind] =
          product.copyWith(numberSelecting: max(0, item.numberSelecting) + 1);
    } else {
      productsSelecting.add(product.copyWith(numberSelecting: 1));
    }
    state = state.copyWith(
      currentOrderItems: currentOrderItems,
      productsSelecting: productsSelecting,
      changedProductId: product.id,
    );
    onChangeAutoScrollProducts(true);

    _startUpdateOrderItemTimer();

    return null;
  }

  Future<String?> removeProductInOrder(ProductModel productModel) async {
    try {
      if (state.orderSelect == null) {
        return S.current.noOrderSelect;
      }
      _updateOrderItemTimer?.cancel();
      state = state.copyWith(isOrderSaved: false);
      var currentOrderItems = List<ProductModel>.from(state.currentOrderItems);
      var item =
          currentOrderItems.firstWhereOrNull((e) => e.id == productModel.id);
      if (item != null) {
        var count = item.numberSelecting - 1;
        if (count < 1) {
          currentOrderItems.remove(item);
        } else {
          var index = currentOrderItems.indexOf(item);
          if (index != -1) {
            currentOrderItems[index] =
                productModel.copyWith(numberSelecting: count);
          }
        }
      }

      state = state.copyWith(
        currentOrderItems: currentOrderItems,
        changedProductId: productModel.id,
      );
      onChangeAutoScrollProducts(true);
      _startUpdateOrderItemTimer();
      return null;
    } catch (ex) {
      return S.current.an_error_occurred;
    }
  }

  void changeProductInOrder(ProductModel productModel, int count) {
    try {
      if (state.orderSelect == null) return;
      _updateOrderItemTimer?.cancel();
      state = state.copyWith(isOrderSaved: false);
      var currentOrderItems = List<ProductModel>.from(state.currentOrderItems);
      var productsSelecting = List<ProductModel>.from(state.productsSelecting);
      var item =
          currentOrderItems.firstWhereOrNull((e) => e.id == productModel.id);
      if (item != null) {
        if (count > 0) {
          var index = currentOrderItems.indexOf(item);
          if (index != -1) {
            currentOrderItems[index] =
                productModel.copyWith(numberSelecting: count);
          }
        } else {
          currentOrderItems.remove(item);
        }
      }
      var item1 =
          productsSelecting.firstWhereOrNull((e) => e.id == productModel.id);
      if (item1 != null) {
        if (count > 0) {
          var index = productsSelecting.indexOf(item1);
          if (index != -1) {
            productsSelecting[index] =
                productModel.copyWith(numberSelecting: count);
          }
        } else {
          productsSelecting.remove(item1);
        }
      }
      productsSelecting.remove((e) => e.numberSelecting < 1);
      state = state.copyWith(
        currentOrderItems: currentOrderItems,
        productsSelecting: productsSelecting,
        changedProductId: productModel.id,
      );
      onChangeAutoScrollProducts(true);
      _startUpdateOrderItemTimer();
    } catch (ex) {
      //
    }
  }

  /// Kiểm tra code mỗi lần thao tác yêu cầu
  Future<String?> checkCode(String code) async {
    try {
      var checkCodeRepo = await _userRepository.checkCode(code: code);
      if (checkCodeRepo.data.checkCode == false) {
        return S.current.verificationCodeIsIncorrect;
      }
      return null;
    } catch (ex) {
      return ex.toString();
    }
  }

  /// Tạo đơn hàng mới
  /// [0]: orderId, -1 là lỗi tạo đơn mới
  /// [1]: Message
  Future<List<dynamic>> createNewOrder(
    List<int> tableIds, {
    required int typeOrder,
    ReservationModel? reservation,
    required String tableName,
  }) async {
    try {
      updateEvent(HomeEvent.createNewOrder);
      final createOrderRepo = await _orderRepository.createAndUpdateOrder(
        tableIds,
        const OrderModel(id: 0, name: "name", misc: "misc"),
        typeOrder: typeOrder,
        reservation: reservation,
      );
      updateEvent(null);
      return [createOrderRepo.orderId, null];
    } catch (ex) {
      updateEvent(null);
      return [-1, ex.toString()];
    }
  }

  /// Cập nhật đơn hàng
  ///
  /// Khi yêu cầu huỷ đơn: tableIds = []
  Future<({String? error, int? orderId})> updateOrder(
    List<int> tableIds,
    OrderModel order, {
    bool cancel = false,
    ReservationModel? reservation,
  }) async {
    try {
      updateEvent(cancel ? HomeEvent.cancelOrder : HomeEvent.updateOrder);
      await _checkOrderSelect();
      final updateOrderRepo = await _orderRepository.createAndUpdateOrder(
        tableIds,
        state.orderSelect!,
        reservation: reservation,
        typeOrder: kTypeOrder,
      );
      if (tableIds.isEmpty) {
        try {
          LocalStorage.deleteNotePerOrderItem(order: state.orderSelect!);
        } catch (ex) {
          //
        }

        try {
          LocalStorage.deleteEmployeeSaleForOrder(order: state.orderSelect!);
        } catch (ex) {
          //
        }

        try {
          await LocalStorage.deleteApplyAgainOnlyCouponForOrder(
              order: state.orderSelect!);
        } catch (ex) {
          //
        }
      }
      updateEvent(null);
      return (error: null, orderId: updateOrderRepo.orderId);
    } catch (ex) {
      _lockOrder(ex);
      updateEvent(null);
      return (error: ex.toString(), orderId: -1);
    }
  }

  OrderModel? getOrderSelect() => state.orderSelect;

  Future<void> logout() async {
    try {
      await LocalStorage.logout();
    } catch (ex) {
      //
    }
    ref.invalidate(checkLoginProvider);
  }

  void _resetOrder() {
    state = state.copyWith(
      lockedOrder: false,
      currentOrderItems: [],
      productsSelected: [],
      productsSelecting: [],
      productCheckout: [],
      productCheckoutState: const PageState(),
      isOrderSaved: true,
      customer: null,
      coupons: [],
      vouchers: [],
      createVouchers: null,
      needApplyAgainOnlyCoupons: [],
      applyPolicyState: const PageState(status: PageCommonState.success),
      paymentMethodSelected: null,
      statusPaymentGateway: false,
      totalPaymentGateway: 0.0,
      bankSelect: null,
      cashReceivedAmount: 0.0,
      atmPosSelect: null,
      invoice: null,
      orderInvoiceState: const PageState(),
      dataBill: const DataBillResponseData(),
      dataBillState: const PageState(status: PageCommonState.success),
      productCheckoutUpdateTax: [],
      imageBills: [],
      numberOfAdults: 1,
      numberOfChildren: 0,
      kitchenNote: '',
      customerPortraitSelect: null,
      completeNote: '',
      employeeSaleSelect: null,
      printNumberOfPeople: false,
      autoScrollProducts: true,
      changedProductId: null,
      cancelOrderItem: false,
      displayOrderHistory: false,
    );
    _listPaymentMethods = [];
    printKitchenBill = 0;
    _updateOrderItemTimer?.cancel();
    _ignoreTimerCallback = false;
    requireUpdateDefaultTax = false;
    productCheckouts = [];
    syncInfoForCustomer();
  }

  Future<void> loadingChangeOrderSelect(
    int orderId, {
    int? typeOrder,
    // required TypeOrderEnum typeOrderEnum,
    dynamic reservationCrmId,
  }) async {
    try {
      if (state.orderSelect != null) {
        try {
          await LocalStorage.saveApplyAgainOnlyCoupon(
            order: state.orderSelect!,
            coupons: state.needApplyAgainOnlyCoupons,
          );
        } catch (ex) {
          //
        }
      }
      updateEvent(HomeEvent.loadingChangeOrderCurrent);
      state = state.copyWith(
          orderSelect: OrderModel(
        id: orderId,
        typeOrder: typeOrder ?? kTypeOrder,
        reservationCrmId: reservationCrmId,
      ));
      paymentPrinter = [];
      itemPrint = [];
      voucherPrint = [];
      _resetOrder();
      ref.invalidate(tablesAndOrdersProvider);
      state = state.copyWith(event: HomeEvent.normal);
    } catch (ex) {
      state = state.copyWith(
        event: HomeEvent.errorInfo,
        messageError: "${S.current.error_change_order}\n"
            "---\n"
            "${S.current.ex_problem}: ${ex.toString()}",
        orderSelect: null,
      );
      paymentPrinter = [];
      itemPrint = [];
      voucherPrint = [];
      _resetOrder();
    }
  }

  String getMessageError() {
    return state.messageError;
  }

  /// uncheck
  void listenRedisChannel() async {
    StreamSubscription<dynamic>? streamSubscription;
    try {
      var ip = IPConfigHelper.getIP();
      var port = LocalStorage.getPortRedis();
      final redisConnection = RedisConnection();
      showLog("$ip:$port", flags: "Connecting to");
      var command = await redisConnection.connect(ip, port);
      final pubSub = PubSub(command);
      pubSub.subscribe([
        kRedisUpdateItemChannel,
        kUserCreateOrderChannel,
        kUserUpdateOrderChannel,
        kPaymentRequestChannel,
        kCallStaffChannel,
        kStatusOrderChannel,
        // kUserUpdateItemOrderChannel,
        kLockOrderChannel,
      ]);
      final stream = pubSub.getStream();
      streamSubscription = stream.listen(
        (event) {
          showLog(event, flags: "New event");
          //[message, item-channel, {"event":"App\\Events\\ItemCreated","data":{"data":"created item","socket":null},"socket":null}]
          try {
            if (event[0] == "message") {
              showLog('run', flags: "Test reload");
              if (event[1] == kRedisUpdateItemChannel) {
                ref.read(homeProvider.notifier).updateReloadWhenHiddenApp(true);
                ref.read(homeProvider.notifier).getProducts();
              } else if (event[1] == kLockOrderChannel) {
                ref.read(homeProvider.notifier).setUnlockOrder();
              } else if (event[1] == kLockOrderChannel) {
                ref.read(homeProvider.notifier).setUnlockOrder();
              }
            }
          } catch (ex) {
            showLog(ex, flags: "Error listen redis");
          }
        },
        onError: (_, __) async {
          showLog("onError listing $_ $__");
          await streamSubscription?.cancel();
          _reconnectRedis(redisConnection: redisConnection);
        },
        onDone: () async {
          showLog("end listing");
          await streamSubscription?.cancel();
          _reconnectRedis(redisConnection: redisConnection);
        },
      );
      showLog("$ip:$port", flags: "On start listen");
      state = state.copyWith(
        reconnectRedis: false,
        realtimeStatus: true,
      );
      showLog(state.realtimeStatus, flags: "realtimeStatus");
    } catch (ex) {
      showLog(ex, flags: 'RedisConnection error');
      await streamSubscription?.cancel();
      _reconnectRedis();
    }
  }

  /// uncheck
  Future<void> _reconnectRedis({RedisConnection? redisConnection}) async {
    state = state.copyWith(
      reconnectRedis: true,
      realtimeStatus: false,
    );
    if (redisConnection != null) {
      await redisConnection.close();
    }
    await Future.delayed(
      const Duration(seconds: 5),
      () => listenRedisChannel(),
    );
  }

  /// check here
  void checkReloadMenu() {
    final lastTime = LocalStorage.getLastReloadMenu();
    final now = DateTime.now();
    if ((now.compareToWithoutTime(lastTime) == false) &&
        now.hour >= 9 &&
        now.minute >= 5) {
      ref.read(homeProvider.notifier).getProducts();
    }
  }

  Future<FindCustomerStatus> findCustomer(String phone) async {
    try {
      state = state.copyWith(event: HomeEvent.findingCustomer);
      await _checkLockedOrder();
      var customerRepo = await _customerRepository.findCustomer(
          phoneNumber: phone, order: state.orderSelect!);
      state = state.copyWith(event: HomeEvent.normal);
      if (customerRepo.data.customer is List<dynamic> == false) {
        CustomerModel customer =
            CustomerModel.fromJson(customerRepo.data.customer);
        state = state.copyWith(customer: customer);
        syncInfoForCustomer();
        return FindCustomerStatus.success;
      }
      state = state.copyWith(
          messageError: "${S.current.find_customer_not_found} ($phone)");
      return FindCustomerStatus.notFound;
    } catch (ex) {
      _lockOrder(ex);
      var errorMessage = ex is AppException
          ? ex.toString()
          : AppException.fromStatusCode(-1).toString();
      state = state.copyWith(
        event: HomeEvent.normal,
        messageError: errorMessage,
      );
      return FindCustomerStatus.error;
    }
  }

  Future<String?> createCustomer({
    required String phone,
    required String firstName,
    required String lastName,
    required String birthday,
    required String? gender,
    String? idCardNumber,
    String? address,
    required bool noBOD,
  }) async {
    try {
      if (state.orderSelect == null) return S.current.noOrderSelect;
      state = state.copyWith(event: HomeEvent.createCustomer);
      if (phone.isEmpty ||
          firstName.isEmpty ||
          lastName.isEmpty ||
          (noBOD ? false : birthday.isEmpty)) {
        state = state.copyWith(event: HomeEvent.normal);
        return S.current.miss_information;
      }
      await _checkOrderSelect();
      await _customerRepository.createCustomer(
        phone: phone,
        firstName: firstName,
        lastName: lastName,
        birthday: birthday,
        gender: gender,
        order: state.orderSelect!,
        idCardNumber: idCardNumber,
        address: address,
      );
      state = state.copyWith(event: HomeEvent.normal);
      return null;
    } catch (ex) {
      _lockOrder(ex);
      state = state.copyWith(event: HomeEvent.normal);
      return "${S.current.unable_add_customer}\n${ex.toString()}";
    }
  }

  Future<({String? error, String? titleError})> addCoupon({
    required String code,
    bool loadingHome = true,
    bool applyPolicy = true,
  }) async {
    try {
      if (loadingHome) state = state.copyWith(event: HomeEvent.checkTicket);
      if (state.coupons.any((element) =>
          element.name.trim().toLowerCase() == code.trim().toLowerCase())) {
        if (loadingHome) state = state.copyWith(event: HomeEvent.normal);
        return (
          error: S.current.discount_code_already_exists,
          titleError: null,
        );
      }

      await _checkLockedOrder();

      final couponRepo = await _couponRepository.getCouponByCode(
        code: code,
        order: state.orderSelect!,
        totalOrder: getFinalPaymentPrice.totalPrice * 1.0,
        numberOfAdults: state.numberOfAdults,
      );

      if (loadingHome) state = state.copyWith(event: HomeEvent.normal);
      List<CustomerPolicyModel> coupons =
          List<CustomerPolicyModel>.from(couponRepo.data.data);
      if (coupons.isEmpty) {
        final errorMessage = couponRepo.data.message;
        return (
          titleError: errorMessage.isEmpty
              ? null
              : "${S.current.discount_code_is_not_valid} ($code)",
          error: errorMessage.isEmpty
              ? "${S.current.discount_code_is_not_valid} ($code)"
              : errorMessage,
        );
      }

      var needApplyAgainOnlyCoupons =
          List<CustomerPolicyModel>.from(state.needApplyAgainOnlyCoupons);
      for (var c in coupons) {
        if (!c.only) continue;
        needApplyAgainOnlyCoupons.removeWhere((e) => e.id == c.id);
      }

      try {
        await LocalStorage.saveApplyAgainOnlyCoupon(
            order: state.orderSelect!, coupons: needApplyAgainOnlyCoupons);
      } catch (ex) {
        //
      }

      state =
          state.copyWith(needApplyAgainOnlyCoupons: needApplyAgainOnlyCoupons);

      // lấy customer trong coupon nếu có
      CustomerModel? customerCoupon = coupons.first.customer;
      state = state.copyWith(
        coupons: [...coupons, ...state.coupons],
        customer: state.customer ?? customerCoupon,
      );
      if (applyPolicy) await applyCustomerPolicy();

      return (error: null, titleError: null);
    } catch (ex) {
      _lockOrder(ex);
      if (loadingHome) state = state.copyWith(event: HomeEvent.normal);
      return (
        error: ex.toString(),
        titleError: "${S.current.failed_apply_discount_code} ($code)",
      );
    }
  }

  Future<String?> handleOrderItem({
    // bool ignoreLoading = false,
    bool retry = false,
    bool loadingHome = false,
  }) async {
    String? error;
    try {
      showLogs(null, flags: 'handleOrderItem');
      if (loadingHome) updateEvent(HomeEvent.processOrder);
      var orderSelect = state.orderSelect;
      if (orderSelect == null) {
        _updateOrderItemTimer?.cancel();
        throw S.current.noOrderSelect;
      }

      if (state.lockedOrder) {
        _updateOrderItemTimer?.cancel();
        throw S.current.msg_locked_order;
      }
      int retryCount = retry ? 0 : 2;

      bool mustGetProductCheckout = false;
      while (retryCount < 3) {
        error = null;
        var currentOrderItems =
            List<ProductModel>.from(state.currentOrderItems);
        var productsSelected = List<ProductModel>.from(state.productsSelected);
        var productCheckout =
            List<ProductCheckoutModel>.from(state.productCheckout);

        List<ProductModel> addProducts = [];
        List<ProductModel> cancelProducts = [];
        List<ProductCheckoutModel> cancelProductsCheckout = [];
        Set<int> changeProductId = {};

        for (var item in currentOrderItems) {
          var p = productsSelected.firstWhereOrNull((e) => e.id == item.id);
          if (p == null) {
            changeProductId.add(item.id);
            addProducts.add(item);
          } else {
            var count = item.numberSelecting;
            if (count < p.numberSelecting) {
              changeProductId.add(item.id);
              // số lượng huỷ
              cancelProducts
                  .add(p.copyWith(numberSelecting: count - p.numberSelecting));
            } else if (count > p.numberSelecting) {
              changeProductId.add(item.id);
              addProducts
                  .add(p.copyWith(numberSelecting: count - p.numberSelecting));
            }
          }
        }
        for (var item in productsSelected) {
          var itemCancel =
              currentOrderItems.firstWhereOrNull((e) => e.id == item.id);
          if (itemCancel == null) {
            changeProductId.add(item.id);
            cancelProducts
                .add(item.copyWith(numberSelecting: -item.numberSelecting));
          }
        }

        for (var i in cancelProducts) {
          var item = productCheckout.firstWhereOrNull((e) => e.id == i.id);
          if (item != null) {
            cancelProductsCheckout
                .add(item.copyWith(quantityCancel: i.numberSelecting));
          }
        }

        showLogs(addProducts.length, flags: 'addProducts');
        showLogs(cancelProductsCheckout.length,
            flags: 'cancelProductsCheckout');

        if (addProducts.isEmpty && cancelProductsCheckout.isEmpty) {
          _updateOrderItemTimer?.cancel();
          state = state.copyWith(isOrderSaved: true);
          syncInfoForCustomer();
          if (loadingHome) updateEvent(HomeEvent.normal);
          applyCustomerPolicy(loadingHome: loadingHome);
          return null;
        }

        state = state.copyWith(isOrderSaved: false);
        var onlyCoupons =
            List<CustomerPolicyModel>.from(state.needApplyAgainOnlyCoupons);
        for (var c in state.coupons) {
          if (!c.only) continue;
          if (c.discountCrm
              .any((e) => changeProductId.contains(int.tryParse(e.id) ?? -1))) {
            onlyCoupons.add(CustomerPolicyModel(id: c.id, name: c.name));
          }
        }

        if (addProducts.isNotEmpty) {
          var total = 0.0;

          addProducts.forEach(
            (element) {
              total += element.numberSelecting < 0
                  ? 0
                  : element.numberSelecting *
                      (double.tryParse(element.unitPrice) ?? 0.0);
            },
          );

          try {
            await _orderRepository.processOrder(
              order: state.orderSelect!,
              total: total,
              orderNote: state.kitchenNote,
              products: addProducts,
            );
            mustGetProductCheckout = true;
          } catch (ex) {
            error = ex.toString();
            if (ex is AppException && ex.errorCode == 423) {
              _updateOrderItemTimer?.cancel();
              state = state.copyWith(
                lockedOrder: true,
                currentOrderItems: productsSelected,
                isOrderSaved: true,
              );
              if (loadingHome) updateEvent(HomeEvent.normal);
              return ex.messageError;
            }
          }
        }
        if (cancelProductsCheckout.isNotEmpty) {
          try {
            await _orderRepository.cancelDishInOrder(
              order: state.orderSelect!,
              total: 0,
              contentCancelOrder: 'Khách chọn nhầm',
              products: cancelProductsCheckout,
            );
            mustGetProductCheckout = true;
          } catch (ex) {
            error = ex.toString();
            if (ex is AppException && ex.errorCode == 423) {
              _updateOrderItemTimer?.cancel();
              if (loadingHome) updateEvent(HomeEvent.normal);
              state = state.copyWith(lockedOrder: true);
              if (mustGetProductCheckout) {
                try {
                  await getOrderProductCheckout(
                    loadingProductCheckout: false,
                    changeSelecting: true,
                    loadingHome: loadingHome,
                    applyPolicy: true,
                  );
                } catch (ex) {
                  //
                }
              } else {
                state = state.copyWith(
                  currentOrderItems: productsSelected,
                  isOrderSaved: true,
                );
              }
              return ex.messageError;
            }
          }
        }
        if (loadingHome) updateEvent(HomeEvent.normal);

        if (mustGetProductCheckout) {
          try {
            await LocalStorage.saveApplyAgainOnlyCoupon(
                order: state.orderSelect!, coupons: onlyCoupons);
          } catch (ex) {
            //
          }
          state = state.copyWith(needApplyAgainOnlyCoupons: onlyCoupons);
          await getOrderProductCheckout(
            loadingProductCheckout: false,
            changeSelecting: false,
            loadingHome: loadingHome,
            applyPolicy: false,
            ignoreGetDataBill: true,
          );
        }

        retryCount++;
      }
      return error;
    } catch (ex) {
      if (loadingHome) updateEvent(HomeEvent.normal);
      return ex.toString();
    }
  }

  Future<({String? error, List<IpOrderModel> printers})> cancelProductOrder(
    List<ProductCheckoutModel> cancelProductCheckouts, {
    String contentCancelOrder = 'Khách chọn nhầm',
  }) async {
    try {
      updateEvent(HomeEvent.cancelProductsCheckout);
      int retry = 0;
      List<IpOrderModel> printers = [];
      while (retry < 3) {
        try {
          if (state.orderSelect == null) {
            updateEvent(HomeEvent.normal);
            return (
              error: S.current.noOrderSelect,
              printers: <IpOrderModel>[],
            );
          }
          // nhượng quyền - tự in thì cần lấy danh sách máy in
          //&& printers.isEmpty
          if (AppConfig.useFranchise) {
            List<int> printerCheck = [];
            for (var pc in cancelProductCheckouts) {
              if (pc.printerType != null &&
                  !printerCheck.contains(pc.printerType)) {
                printerCheck.add(pc.printerType!);
              }
            }

            try {
              var resultCheckPrinter = await _orderRepository.getPrinterBill(
                  state.orderSelect!, printerCheck);
              if (resultCheckPrinter.error != null) {
                showLogs(
                  resultCheckPrinter.error,
                  flags: 'resultCheckPrinter.error thông tin máy in',
                );
              }
              printers = resultCheckPrinter.printers;
            } catch (ex) {
              showLogs(
                ex.toString(),
                flags: 'get thông tin máy in',
              );
              //
            }
          }
          await _orderRepository.cancelDishInOrder(
            order: state.orderSelect!,
            total: 0,
            contentCancelOrder: contentCancelOrder,
            // quantityCancel < 0
            products: cancelProductCheckouts,
          );
          var productCheckout =
              List<ProductCheckoutModel>.from(state.productCheckout);
          var productsSelected =
              List<ProductModel>.from(state.productsSelected);
          for (var item in cancelProductCheckouts) {
            var check =
                productCheckout.firstWhereOrNull((e) => e.id == item.id);
            int remain = 0;
            if (check != null) {
              var quantity = check.quantity;
              remain = max(0, quantity + item.quantityCancel);
              var index = productCheckout.indexOf(check);
              if (index != -1) {
                if (remain > 0) {
                  productCheckout[index] =
                      check.copyWith(quantityCancel: 0, quantity: remain);
                } else {
                  productCheckout.removeAt(index);
                }
              }

              var pCheck =
                  productsSelected.firstWhereOrNull((e) => e.id == item.id);
              if (pCheck != null) {
                var ind = productsSelected.indexOf(pCheck);
                if (ind != -1) {
                  if (remain > 0) {
                    productsSelected[ind] =
                        pCheck.copyWith(numberSelecting: remain);
                  } else {
                    productsSelected.removeAt(ind);
                  }
                }
              }
            }
          }

          state = state.copyWith(
            productCheckout: productCheckout,
            productsSelected: productsSelected,
          );

          updateEvent(HomeEvent.normal);
          return (
            error: null,
            printers: printers,
          );
        } catch (ex) {
          retry++;
          if (retry >= 3) {
            updateEvent(HomeEvent.normal);
            return (
              error: ex.toString(),
              printers: <IpOrderModel>[],
            );
          }
        }
      }
      updateEvent(HomeEvent.normal);
      return (
        error: null,
        printers: <IpOrderModel>[],
      );
    } catch (ex) {
      updateEvent(HomeEvent.normal);
      return (
        error: ex.toString(),
        printers: <IpOrderModel>[],
      );
    }
  }

  void loadPaymentMethods() async {
    try {
      state = state.copyWith(
        paymentMethodState: const PageState(status: PageCommonState.loading),
        paymentMethodSelected: null,
      );
      await _checkOrderSelect();
      final paymentMethods = await _restaurantRepository.getPaymentMethod(
        orderId: state.orderSelect!.id,
      );
      _listPaymentMethods = List<PaymentMethod>.from(paymentMethods);

      state = state.copyWith(
        paymentMethodState: const PageState(status: PageCommonState.success),
        paymentMethods: paymentMethods,
      );
    } catch (ex) {
      _lockOrder(ex);
      state = state.copyWith(
          paymentMethodState: PageState(
        status: PageCommonState.error,
        messageError: ex.toString(),
      ));
    }
  }

  PaymentMethod? getPaymentMethodSelected() {
    return state.paymentMethodSelected;
  }

  Future<String?> removeCoupon(
    CustomerPolicyModel coupon, {
    bool applyPolicy = true,
    bool loadingApplyPolicy = true,
  }) async {
    try {
      if (state.orderSelect == null) return S.current.noOrderSelect;
      state = state.copyWith(event: HomeEvent.removeCoupon);
      final result = await _couponRepository.unblockCouponCode(
          idCode: coupon.id, order: state.orderSelect!);
      state = state.copyWith(event: HomeEvent.normal);
      showLogs(result, flags: 'kq xóa mã giảm giá');
      if (result) {
        var coupons = List<CustomerPolicyModel>.from(state.coupons);
        coupons.removeWhere((element) => element.id == coupon.id);
        // check KH có nằm trong mã bị xoá hay không
        CustomerModel? customerChange = state.customer;
        if ((coupon.customer != null) &&
            (customerChange != null) &&
            (coupon.customer?.id == customerChange.id)) {
          customerChange = null;
        }
        state = state.copyWith(
          coupons: coupons,
          customer: customerChange,
        );

        var needApplyAgainOnlyCoupons =
            List<CustomerPolicyModel>.from(state.needApplyAgainOnlyCoupons);
        needApplyAgainOnlyCoupons.removeWhere((e) => e.id == coupon.id);
        state = state.copyWith(
            needApplyAgainOnlyCoupons: needApplyAgainOnlyCoupons);

        try {
          await LocalStorage.saveApplyAgainOnlyCoupon(
              order: state.orderSelect!, coupons: needApplyAgainOnlyCoupons);
        } catch (ex) {
          //
        }

        /// check here
        if (applyPolicy) {
          try {
            await applyCustomerPolicy(loadingHome: loadingApplyPolicy);
          } catch (ex) {
            //
          }
        }
        return null;
      }
      return S.current.discount_code_cannot_be_deleted;
    } catch (ex) {
      _lockOrder(ex);
      state = state.copyWith(event: HomeEvent.normal);
      return ex.toString();
    }
  }

  Future<void> getProducts() async {
    try {
      state = state.copyWith(
          productsState: const PageState(status: PageCommonState.loading));
      final categoriesRepo = await _categoryRepository.getCategory();
      List<CategoryModel> categories = categoriesRepo.data.data;
      List<TagProductModel> tags = categoriesRepo.data.tags ?? [];

      final productsRepo = await _productRepository.getProductByCategory(null);
      List<ProductModel> products = List.from(productsRepo.data.data ?? []);

      if (categories.isNotEmpty) {
        var categorySelect = state.categorySelect;

        var checkCategorySelect =
            categories.firstWhereOrNull((e) => e.id == categorySelect?.id);
        if (categorySelect == null || checkCategorySelect == null) {
          ref
              .read(homeProvider.notifier)
              .changeCategorySelect(categories.first);
          checkCategorySelect = categories.first;
        } else if (categorySelect != checkCategorySelect) {
          ref
              .read(homeProvider.notifier)
              .changeCategorySelect(checkCategorySelect);
        }

        if (!(checkCategorySelect.children ?? [])
            .contains(state.subCategorySelect)) {
          ref.read(homeProvider.notifier).changeSubCategorySelect(
              (checkCategorySelect.children ?? []).isEmpty
                  ? null
                  : (checkCategorySelect.children ?? []).first);
        }
      } else {
        state = state.copyWith(
          categorySelect: null,
          subCategorySelect: null,
        );
      }

      // cập nhật ngôn ngữ local khi load menu
      kAppLanguageLocal = LocalStorage.getLanguageLocal();
      await LocalStorage.setLastReloadMenu();
      for (var element in categories) {
        categoryKeys[element] = categoryKeys[element] ?? GlobalKey();
        for (var sub in (element.children ?? [])) {
          categoryKeys[sub] = categoryKeys[sub] ?? GlobalKey();
        }
      }

      state = state.copyWith(
        categories: categories,
        products: products,
        tags: tags,
        productsState: const PageState(status: PageCommonState.success),
        tagSelect: tags.firstWhereOrNull((e) => e == state.tagSelect),
      );
      syncInfoForCustomer();
      // có cần kiểm tra các món đã gọi còn hay k?
    } catch (ex) {
      if (mounted) {
        state = state.copyWith(
          productsState: PageState(
            status: PageCommonState.error,
            messageError: ex.toString(),
          ),
        );
      }
    }
  }

  void changeSearch(String text) {
    state = state.copyWith(search: text);
    if (ctrlSearch.text != text) {
      ctrlSearch.text = text;
    }
  }

  void changeIgnoreCheckCodeWaiter() {
    state = state.copyWith(ignoreCheckCodeWaiter: !state.ignoreCheckCodeWaiter);
  }

  void changeTagSelect(TagProductModel? tag) {
    if (tag == state.tagSelect) return;
    state = state.copyWith(tagSelect: tag);
  }

  void updateReloadWhenHiddenApp(bool value) {
    state = state.copyWith(checkReloadWhenHiddenApp: value);
  }

  bool getCheckReloadWhenHiddenApp() => state.checkReloadWhenHiddenApp;

  Future<(MInvoiceInfo? mInvoiceInfo, String? error)> searchTaxCodeInfo(
      String taxCode) async {
    try {
      updateEvent(HomeEvent.findingTaxCode);
      final minvoiceInfo =
          await _restaurantRepository.getMInvoiceTaxInfo(taxCode);
      updateEvent(HomeEvent.normal);
      return (minvoiceInfo, null);
    } catch (ex) {
      updateEvent(HomeEvent.normal);
      return (null, ex.toString());
    }
  }

  Future<bool> onUpdateOrderInvoice(
    OrderInvoice invoice, {
    bool isUpdate = false,
  }) async {
    try {
      updateEvent(isUpdate ? HomeEvent.updateInvoice : HomeEvent.insertInvoice);
      await _checkOrderSelect();
      await _orderRepository.updateOrderInvoice(
        orderId: state.orderSelect!.id,
        orderInvoice: invoice,
      );
      state = state.copyWith(
        event: HomeEvent.processed,
        invoice: invoice,
      );
      return true;
    } catch (ex) {
      _lockOrder(ex);
      state = state.copyWith(
        event: HomeEvent.processError,
        messageError: ex.toString(),
      );
      return false;
    }
  }

  Future<void> getOrderInvoice() async {
    try {
      state = state.copyWith(
        orderInvoiceState: const PageState(status: PageCommonState.loading),
      );
      await _checkOrderSelect();
      final orderInvoice =
          await _orderRepository.getOrderInvoice(state.orderSelect!.id);
      state = state.copyWith(
        orderInvoiceState: const PageState(status: PageCommonState.success),
        invoice: orderInvoice.isEmpty() ? null : orderInvoice,
      );
    } catch (ex) {
      _lockOrder(ex);
      state = state.copyWith(
        orderInvoiceState: PageState(
          messageError: ex.toString(),
          status: PageCommonState.error,
        ),
      );
    }
  }

  void changePaymentMethod(PaymentMethod? paymentMethod) {
    state = state.copyWith(
      paymentMethodSelected: paymentMethod,
      statusPaymentGateway: false,
      totalPaymentGateway: 0.0,
      cashReceivedAmount: 0,
      bankSelect: null,
      atmPosSelect: null,
    );
    syncInfoForCustomer();
  }

  Future<bool> unlockOrder() async {
    try {
      updateEvent(HomeEvent.unlockOrder);
      int retry = 0;
      while (retry < 3) {
        try {
          if (state.orderSelect == null) {
            break;
          }
          await _orderRepository.lockOrder(
            orderId: state.orderSelect!.id,
            statusLock: 0,
          );

          state = state.copyWith(lockedOrder: false);
          break;
        } catch (ex) {
          retry++;
          if (retry >= 3) {
            rethrow;
          }
        }
      }

      updateEvent(HomeEvent.processed);
      resetPaymentAndBank();
      return true;
    } catch (ex) {
      state = state.copyWith(
        event: HomeEvent.processError,
        messageError:
            "${S.current.failed_payment_closing}\n${S.current.ex_problem}: ${ex.toString()}",
      );
      return false;
    }
  }

  ({List<CustomerPolicyModel> coupons, String? error}) checkPaymentMethodSelect(
      PaymentMethod method) {
    try {
      updateEvent(HomeEvent.checkPaymentMethod);
      if (state.coupons.isEmpty) {
        updateEvent(HomeEvent.normal);
        return (coupons: [], error: null);
      }
      List<CustomerPolicyModel> couponInvalidResult = [];
      // kiểm tra với danh sách giảm giá đang có
      for (final c in state.coupons) {
        if (c.paymentNotAllowed.any((element) => element.key == method.key)) {
          couponInvalidResult.add(c);
        }
      }
      updateEvent(HomeEvent.normal);
      if (couponInvalidResult.isNotEmpty) {
        return (
          coupons: couponInvalidResult,
          error: S.current.msg_coupons_invalid_with_payment_method(
              couponInvalidResult.length.toString(),
              couponInvalidResult.join(','),
              method.name.toUpperCase()),
          // "Có ${couponInvalidResult.length} mã giảm giá ${couponInvalidResult.join(',')}"
          // " không được phép dùng với PTTT (${method.name.toUpperCase()}).\n"
          // " Vui lòng xoá bỏ mã hoặc chọn phương thức thanh toán khác!"
        );
      }
      return (coupons: [], error: null);
    } catch (ex) {
      updateEvent(HomeEvent.normal);
      return (
        coupons: [],
        error: "${S.current.can_not_check_payment_method}\n${ex.toString()}"
      );
    }
  }

  void changeBankSelect(UserBankModel? bank) {
    state = state.copyWith(
      bankSelect: state.bankSelect == bank ? null : bank,
    );
    syncInfoForCustomer();
  }

  Future<void> loadBanksInfo() async {
    try {
      state = state.copyWith(
        banksState: const PageState(status: PageCommonState.loading),
        banks: [],
        bankSelect: null,
      );
      await _checkOrderSelect();
      final apiBankParam = ApiBankParam(
          state.dataBill.order, getFinalPaymentPrice.totalPriceFinal);
      final paymentMethodSelect = state.paymentMethodSelected;
      final banks = await _restaurantRepository.getBanks(apiBankParam);

      var bankView = List<UserBankModel>.from(banks);
      // Loại bỏ những bank không hỗ trợ PTTT
      bankView.removeWhere((element) =>
          element.listPaymentId.contains(paymentMethodSelect?.key) == false);

      if (bankView.length == 1) {
        state = state.copyWith(bankSelect: bankView.first);
        syncInfoForCustomer();
      }
      state = state.copyWith(
        banksState: const PageState(status: PageCommonState.success),
        banks: bankView,
      );
    } catch (ex) {
      state = state.copyWith(
        banksState: PageState(
          status: PageCommonState.error,
          messageError: ex.toString(),
        ),
      );
    }
  }

  void resetPaymentAndBank() {
    state = state.copyWith(
      imageBills: [],
      paymentMethodSelected: null,
      bankSelect: null,
      statusPaymentGateway: false,
      totalPaymentGateway: 0.0,
      cashReceivedAmount: 0,
      atmPosSelect: null,
    );
    syncInfoForCustomer();
  }

  // update trùng sẽ xoá
  void updateImageBill(File image) {
    if (state.orderSelect == null) return;
    var images = List<File>.from(state.imageBills);
    if (images.contains(image)) {
      images.remove(image);
      clearImageBill(files: [image]);
    } else {
      images.add(image);
    }
    state = state.copyWith(imageBills: images);
  }

  void clearImageBill({List<File>? files}) {
    try {
      if (Platform.isWindows) return;
      final fileCheck = files ?? state.imageBills;
      for (final file in fileCheck) {
        File(file.path).deleteSync();
      }
      // xoá toàn bộ
      if (files == null) {
        state = state.copyWith(imageBills: []);
      }
      showLog("done", flags: 'clearImageBill');
    } catch (ex) {
      showLog("error $ex", flags: 'clearImageBill');
    }
  }

  void changeNumberOfPeople({
    int? numberOfAdults,
    int? numberOfChildren,
  }) {
    state = state.copyWith(
      numberOfAdults: numberOfAdults ?? state.numberOfAdults,
      numberOfChildren: numberOfChildren ?? state.numberOfChildren,
    );
  }

  List<CustomerPortrait> getCustomerPortrait() => state.customerPortraits;
  CustomerPortrait? getCustomerPortraitSelect() => state.customerPortraitSelect;

  // void changeNote(String value) {
  //   state = state.copyWith(kitchenNote: value);
  //   syncInfoForCustomer(
  //     method: WindowsMethod.changeOrderProduct,
  //     arguments: {
  //       'auto_scroll_order_product': true,
  //       'changed_product_id': state.changedProductId,
  //     },
  //   );
  //   syncInfoForCustomer();
  // }

  void onChangeCustomerPortraitSelect(CustomerPortrait customerPortrait) {
    state = state.copyWith(customerPortraitSelect: customerPortrait);
  }

  Future<String?> resetCustomer() async {
    try {
      if (state.orderSelect == null) return S.current.noOrderSelect;
      state = state.copyWith(event: HomeEvent.removeCustomer);
      await _orderRepository.removeCustomerForOrder(
          orderId: state.orderSelect!.id);
      state = state.copyWith(event: HomeEvent.normal, customer: null);
      return null;
    } catch (ex) {
      _lockOrder(ex);
      state = state.copyWith(event: HomeEvent.normal);
      return "${S.current.error_remove_customer_order}\n${ex.toString()}";
    }
  }

  /// uncheck
  /// áp dụng ưu đãi
  ///
  /// [hotReload] Tự động load lại danh sách món đã gọi (được sử dụng trong xác nhận tạo phiếu thanh toán)
  ///
  /// [loadingHome] = true - show loading giữa trang
  Future<String?> applyCustomerPolicy({
    bool hotReload = false,
    bool retry = true,
    bool loadingHome = true,
  }) async {
    try {
      if (state.coupons.isEmpty &&
          state.dataBill.price.totalPriceVoucher == 0 &&
          state.dataBillState.status == PageCommonState.success) {
        getDataBill();
        showLogs(null, flags: 'bỏ qua áp dụng lại mã giảm giá nếu trống');
        return null;
      }
      state = state.copyWith(
        applyPolicyState:
            const PageState(status: PageCommonState.loading, messageError: ''),
      );
      if (loadingHome) state = state.copyWith(event: HomeEvent.applyPolicy);
      if (state.lockedOrder) throw S.current.msg_locked_order;
      int retryTimes = 0;
      while (retryTimes < (retry ? 3 : 1)) {
        try {
          List<CustomerPolicyModel> couponsApply =
              List<CustomerPolicyModel>.from(state.coupons);

          var productCheckout =
              List<ProductCheckoutModel>.from(state.productCheckout);
          // productCheckout = productCheckout
          //     .map((e) => e.copyWith(quantityPromotion: 0))
          //     .toList();
          var totalOrder = 0.0;
          // for (var product in productCheckout) {
          //   totalOrder += product.totalOrdered;
          // }
          totalOrder = getFinalPaymentPrice.totalPrice * 1.0;

          for (final c in couponsApply) {
            // chỉ áp dụng cho Tặng món 0 đ (is_type == 5)
            // bỏ những discount có number_select == 0
            if (c.isPromotion()) {
              List<DiscountPolicy> discount = [];
              for (var dc in c.discount) {
                if (dc.numberSelect > 0) {
                  discount.add(dc);
                  var p = productCheckout.firstWhereOrNull(
                      (e) => e.id == int.tryParse(dc.id ?? '0'));
                  if (p != null) {
                    var index = productCheckout.indexOf(p);

                    if (index != -1) {
                      productCheckout[index] = p.copyWith(
                        quantityPromotion:
                            p.quantityPromotion + dc.numberSelect,
                      );
                    }
                  }
                }
              }

              couponsApply[couponsApply.indexOf(c)] =
                  c.copyWith(discount: discount);
            }
          }

          await _checkOrderSelect();

          var result = await _customerRepository.applyPolicy(
            coupons: couponsApply,
            // chính sách khách hàng?
            customerPolicy: [],
            // trừ đi số lượng món đã tặng để apply cho các mã khác
            products: productCheckout.map(
              (e) {
                return e.copyWith(
                  quantity: e.getQuantityFinal(),
                  quantityCancel: 0,
                );
              },
            ).toList(),
            order: state.orderSelect!,
            customer: state.customer,
            totalOrder: totalOrder,
            pointUseToMoney: 0,
            numberOfAdults: state.numberOfAdults,
          );
          state = state.copyWith(
            vouchers: result.data.data,
            createVouchers: result.data.dataCreateVouchers,
            productCheckout: productCheckout,
          );
          List<ProductModel> currentOrderItems =
              List.from(state.currentOrderItems);

          for (var pc in productCheckout) {
            var p = currentOrderItems.firstWhereOrNull((e) => e.id == pc.id);
            if (p != null) {
              var index = currentOrderItems.indexOf(p);
              if (index != -1) {
                currentOrderItems[index] =
                    p.copyWith(quantityPromotion: pc.quantityPromotion);
              }
            }
          }

          state = state.copyWith(currentOrderItems: currentOrderItems);

          if (loadingHome) state = state.copyWith(event: HomeEvent.normal);
          await getDataBill(loadingHome: loadingHome);
          syncInfoForCustomer();
          state = state.copyWith(
            applyPolicyState: const PageState(
                status: PageCommonState.success, messageError: ''),
          );
          return null;
        } catch (ex) {
          if (ex is AppException && ex.errorCode == 423) {
            state = state.copyWith(lockedOrder: true);
            retryTimes = (retry ? 3 : 1);
            rethrow;
          }
          retryTimes++;
          if (retryTimes >= (retry ? 3 : 1)) {
            rethrow;
          }
        }
      }
      state = state.copyWith(
        applyPolicyState:
            const PageState(status: PageCommonState.success, messageError: ''),
      );
      return null;
    } catch (ex) {
      showLogs(ex.toString(), flags: 'áp lại mã giảm giá lỗi');
      _lockOrder(ex);
      if (loadingHome) state = state.copyWith(event: HomeEvent.normal);
      state = state.copyWith(
        applyPolicyState: PageState(
            status: PageCommonState.error,
            messageError:
                ex.toString().replaceAll(kIgnoreRetryApplyPolicy, "")),
      );
      await getDataBill(loadingHome: loadingHome);
      return ex.toString().replaceAll(kIgnoreRetryApplyPolicy, "");
    }
  }

  /// thanh toán k dùng payoo ??
  Future<({HomePaymentError? errorType, String msg})> onPayment(
      BuildContext context) async {
    try {
      state = state.copyWith(event: HomeEvent.paymentProcess);
      syncInfoForCustomer(
        method: WindowsMethod.payment,
        arguments: {
          'is_gateway': false,
          'gateway_url': '',
          'status': PaymentStatus.loading.type,
          'qr_code': '',
        },
      );

      int retryTempPayment = 0;
      int timesTempPayment = 3;
      // in tạm tính
      while (retryTempPayment < timesTempPayment) {
        try {
          if (state.orderSelect == null) {
            return (
              errorType: HomePaymentError.temp,
              msg: S.current.noOrderSelect
            );
          }
          final resultPrinter =
              await _orderRepository.getIpPrinterOrder(state.orderSelect!, [1]);
          if (resultPrinter.error != null) {
            throw resultPrinter.error.toString();
          }

          try {
            await LocalStorage.saveListPrinters(resultPrinter.printers);
          } catch (ex) {
            //
          }
          // Kiểm tra tình trạng máy in
          for (var ipPrinter in resultPrinter.printers) {
            var checkPrinterAvailable = await LocalNetworkService.checkPrinter(
                ipPrinter.ip, ipPrinter.port);
            if (checkPrinterAvailable == false) {
              throw ipPrinter.messageConnectFail();
            }
          }

          var price = getFinalPaymentPrice;
          if (state.orderSelect == null) {
            return (
              errorType: HomePaymentError.temp,
              msg: S.current.noOrderSelect
            );
          }

          var productPrint = state.productCheckout.map((e) {
            if (requireUpdateTax) {
              var item = state.productCheckoutUpdateTax
                  .firstWhereOrNull((element) => element.menuItemId == e.id);
              if (item == null) return e;
              return e.copyWith(
                unitPrice: item.priceNew.toString(),
                totalOrdered: item.total,
                tax: item.tax / 100,
              );
            }
            return e;
          }).toList();
          await _orderRepository.payment(
            order: state.orderSelect!,
            infoPrint: resultPrinter.printers,
            products: productPrint,
            vouchers: state.vouchers,
            createVouchers: state.createVouchers,
            comment: null,
            numberOfAdults: state.numberOfAdults,
            numberOfChildren: state.numberOfChildren,
            note: state.completeNote,
            // check here
            flagInvoice: state.invoice != null,
            customerRatings: [],
            imageBills: state.imageBills,
            paymentMethod: state.paymentMethodSelected?.key,
            customerPortrait: state.customerPortraitSelect,
            statusPaymentCompleted: state.statusPaymentGateway,
            // check here
            totalPaymentCompleted: state.statusPaymentGateway
                ? state.totalPaymentGateway
                : price.totalPriceFinal,
          );

          if (AppConfig.useFranchise) {
            try {
              String? errorPrint;
              var orderLineItems = productPrint
                  .map((e) => LineItemDataBill(
                        id: e.id,
                        codeProduct: e.codeProduct,
                        count: e.quantity,
                        name: e.name,
                        tax: e.tax,
                        nameEn: e.nameEn,
                        unit: e.unit,
                        price: e.unitPrice,
                      ))
                  .toList();
              paymentPrinter = List<IpOrderModel>.from(resultPrinter.printers);
              // paymentPrinter = [
              //   IpOrderModel(ip: '192.168.10.89', port: 9100, type: 1),
              // ];
              itemPrint = List<LineItemDataBill>.from(
                  state.dataBill.print?.orderLineItems ?? []);
              // check here: voucher
              voucherPrint = List<HistoryPolicyResultModel>.from(
                  state.dataBill.print?.vouchers ?? []);
              // for (var printer in resultPrinter.printers) {
              //   if (printer.type != 1) continue;

              //   try {
              //     // var check = await AppPrinterCommon.checkPrinter(printer);
              //     // if (check != null) {
              //     //   throw check;
              //     // }

              //     // TaskQueue.instance.add(() async {
              //     //   String? resPrint;
              //     //   try {
              //     //     resPrint =
              //     //         await AppPrinterHtmlUtils.instance.printReceipt(
              //     //       order: state.orderSelect!,
              //     //       price: price,
              //     //       printers: [
              //     //         IpOrderModel(
              //     //             ip: printer.ip, port: printer.port, type: 1),
              //     //       ],
              //     //       receiptType: ReceiptTypeEnum.temporaryReceipt,
              //     //       paymentMethod: state.paymentMethodSelected,
              //     //       paymentAmount: state.statusPaymentGateway
              //     //           ? state.totalPaymentGateway
              //     //           : price.totalPriceFinal * 1.0,
              //     //       numberPrintCompleted: 0,
              //     //       numberPrintTemporary: 1,
              //     //       orderLineItems: orderLineItems,
              //     //       vouchers: voucherPrint,
              //     //       note: state.completeNote,
              //     //       printNumberOfPeople: false,
              //     //       customerPhone: state.customer?.phoneNumber ?? '',
              //     //       numberOfPeople: state.numberOfAdults,
              //     //       cashierCompleted: '',
              //     //       cashierPrint: '',
              //     //       timeCompleted: null,
              //     //       timeCreatedAt: null,
              //     //     );
              //     //   } catch (ex) {
              //     //     resPrint = ex.toString();
              //     //   }
              //     //   showLogs(resPrint, flags: 'KQ in bill tạm tính');
              //     // });
              //     // bỏ qua in tạm tính (bao giờ cần in bill tạm tính)
              //     // await Future.delayed(const Duration(seconds: 2));
              //     // var resPrint = await AppPrinterHtmlUtils.instance.printReceipt(
              //     //   order: state.orderSelect!,
              //     //   price: price,
              //     //   printers: [
              //     //     IpOrderModel(ip: printer.ip, port: printer.port, type: 1),
              //     //   ],
              //     //   receiptType: ReceiptTypeEnum.temporaryReceipt,
              //     //   paymentMethod: state.paymentMethodSelected,
              //     //   paymentAmount: state.statusPaymentGateway
              //     //       ? state.totalPaymentGateway
              //     //       : price.totalPriceFinal * 1.0,
              //     //   numberPrintCompleted: 0,
              //     //   numberPrintTemporary: 1,
              //     //   orderLineItems: orderLineItems,
              //     //   vouchers: voucherPrint,
              //     //   note: state.completeNote,
              //     //   printNumberOfPeople: false,
              //     //   customerPhone: state.customer?.phoneNumber ?? '',
              //     //   numberOfPeople: state.numberOfAdults,
              //     //   cashierCompleted: '',
              //     //   cashierPrint: '',
              //     //   timeCompleted: null,
              //     //   timeCreatedAt: null,
              //     //   timeoutSecond: 7,
              //     // );

              //     // showLogs(resPrint, flags: 'in tạm tính');
              //     // if (resPrint != null) {
              //     //   throw resPrint;
              //     // }
              //   } catch (ex) {
              //     showLogs(ex.toString(), flags: 'in tạm tính lỗi');
              //     await showMessageDialog(context,
              //         message: 'Không thể in phiếu tạm tính\n${ex.toString()}');
              //   }
              // }
            } catch (ex) {
              showLogs(ex.toString(), flags: 'in tạm tính');
            }
          }

          try {
            if (state.orderSelect != null) {
              LocalStorage.deleteNotePerOrderItem(
                order: state.orderSelect!,
              );
              if (state.employeeSaleSelect != null) {
                LocalStorage.saveEmployeeSaleForOrder(
                  order: state.orderSelect!,
                  sale: state.employeeSaleSelect!,
                );
              }
              LocalStorage.deleteApplyAgainOnlyCouponForOrder(
                order: state.orderSelect!,
              );
            }
          } catch (ex) {
            //
          }

          break;
        } catch (ex) {
          retryTempPayment++;
          if (retryTempPayment >= timesTempPayment) {
            state = state.copyWith(event: HomeEvent.normal);
            return (errorType: HomePaymentError.temp, msg: ex.toString());
          }
        }
      }

      // hoàn thành đơn
      var completeStatus = await completeBill(
        loadingHome: false,
        context: context,
      );
      syncInfoForCustomer(
        method: WindowsMethod.payment,
        arguments: {
          'is_gateway': false,
          'gateway_url': '',
          'status': PaymentStatus.success.type,
          'qr_code': '',
        },
      );

      if (completeStatus != null) {
        state = state.copyWith(event: HomeEvent.normal);
        return (errorType: HomePaymentError.complete, msg: completeStatus);
      }
      clearImageBill();

      state = state.copyWith(event: HomeEvent.normal);
      return (errorType: null, msg: '');
    } catch (ex) {
      state = state.copyWith(event: HomeEvent.normal);
      return (errorType: HomePaymentError.temp, msg: ex.toString());
    }
  }

  void onChangeKitchenNote(String note) {
    state = state.copyWith(kitchenNote: note);
    syncInfoForCustomer();
  }

  void onChangeCompleteNote(String note) {
    state = state.copyWith(completeNote: note);
    syncInfoForCustomer();
  }

  void updatePaymentGatewayInfo({
    bool? status,
    dynamic amount,
    bool usePriceDataBillForAmount = false,
  }) {
    state = state.copyWith(
      statusPaymentGateway: status ?? state.statusPaymentGateway,
      totalPaymentGateway: usePriceDataBillForAmount
          ? (getFinalPaymentPrice.totalPriceFinal * 1.0)
          : amount ?? state.totalPaymentGateway,
    );
  }

  Future<void> syncInfoForCustomer({
    WindowsMethod method = WindowsMethod.data,
    dynamic arguments,
  }) async {
    if (!Platform.isWindows) return;
    if (state.pinnedOrder) return;
    List<ProductCheckoutModel> sortProductCheckout = [];
    state.currentOrderItems.forEach((element) {
      var p = state.productCheckout.firstWhereOrNull((e) => e.id == element.id);
      if (p != null) {
        var exist =
            sortProductCheckout.firstWhereOrNull((e) => e.id == element.id);
        if (exist == null) {
          sortProductCheckout
              .add(p.copyWith(quantityPromotion: element.quantityPromotion));
        }
      }
    });

    var args = arguments ??
        {
          'all_products': state.products,
          'order': state.orderSelect,
          'products': sortProductCheckout,
          'customer': state.customer,
          'data_bill': getFinalPaymentPrice.copyWith(
              receivedAmount: (state.paymentMethodSelected?.isCash ?? false)
                  ? state.cashReceivedAmount
                  : 0),
          'note': state.kitchenNote,
          'payment_method': state.paymentMethodSelected,
          'detail_payment': {
            'bank_select': state.bankSelect,
            'gateway_qr': '',
          },
        };

    final subWindows = await DesktopMultiWindow.getAllSubWindowIds();
    for (final id in subWindows) {
      DesktopMultiWindow.invokeMethod(id, method.value, jsonEncode(args));
    }
  }

  Future<String?> printBillWithoutKDS(BuildContext context,
      {bool loadingHome = true}) async {
    try {
      if (loadingHome) state = state.copyWith(event: HomeEvent.printProduct);
      var order = state.orderSelect;
      if (order == null) {
        throw S.current.noOrderSelect;
      }
      // lấy danh sách máy in cần ping
      List<int> printerCheck = [];
      for (var p in state.productsSelected) {
        if (printerCheck.contains(p.printerType) == false) {
          printerCheck.add(p.printerType ?? 0);
        }
      }
      var resultCheckPrinter =
          await _orderRepository.getPrinterBill(order, printerCheck);
      if (resultCheckPrinter.error != null) {
        if (loadingHome) updateEvent(HomeEvent.normal);
        return resultCheckPrinter.error.toString();
      }
      List<IpOrderModel> ipResult = resultCheckPrinter.printers;
      var printBillResult = false;
      int retryInBill = 1;

      var i = LocalStorage.getNotePerOrderItem(order: order);
      // check here: bill bếp có giá hay k?
      List<ProductModel> productPrint = (state.productsSelected).map((e) {
        return e.copyWith(noteForProcessOrder: i?[e.id.toString()] ?? '');
      }).toList();

      while (printBillResult == false) {
        var order = state.orderSelect;
        if (order == null) {
          throw S.current.noOrderSelect;
        }
        final resultBill = await _orderRepository.processOrderPrintBill(
          order: order,
          infoPrint: ipResult,
          products: productPrint,
          timesOrder: printKitchenBill + 1,
          status: 2,
          orderNote: state.kitchenNote,
        );
        printBillResult = resultBill.result;
        String error = resultBill.error.toString();
        if (printBillResult == false && retryInBill <= 3) {
          // ignore: use_build_context_synchronously
          // check here: bắt buộc in bill bếp 3 lần?
          var resultRetry = await showConfirmAction(
            context,
            title: S.current.attention,
            message: "${S.current.unable_send_bill_kitchen}\n"
                "${S.current.ex_problem}: $error",
            actionTitle: S.current.try_printing_again,
            notCancel: true,
          );
          if (resultRetry == false) {
            break;
          } else {
            showLog(retryInBill, flags: 'retryInBill att');
            retryInBill++;
          }
        } else {
          break;
        }
      }

      if (loadingHome) state = state.copyWith(event: HomeEvent.normal);
      if (printBillResult == false) {
        return S.current.unable_send_bill_kitchen;
        return S.current.attention_processed_print;
      }
      printKitchenBill++;
      return null;
    } catch (ex) {
      if (loadingHome) state = state.copyWith(event: HomeEvent.normal);
      return ex.toString();
    }
  }

  Future<String?> completeBill(
      {bool loadingHome = true, required BuildContext context}) async {
    try {
      if (loadingHome) updateEvent(HomeEvent.completeBillAgain);

      int retry = 0;
      while (retry < 3) {
        try {
          PriceDataBill price = getFinalPaymentPrice;
          if (state.orderSelect == null) {
            return S.current.noOrderSelect;
          }
          await _orderRepository.completeBill(
            order: state.orderSelect!,
            portrait: state.customerPortraitSelect?.key ?? '',
            amountAdult: state.numberOfAdults,
            amountChildren: state.numberOfChildren,
            description: state.completeNote,
            arrMethod: [
              '${state.paymentMethodSelected?.key}--${price.totalPriceFinal}'
            ],
            totalPrice: price.totalPrice,
            totalPriceFinal: price.totalPriceFinal,
            totalPriceTax: price.totalPriceTax,
            totalPriceVoucher: price.totalPriceVoucher,
            eSaleCode: state.employeeSaleSelect?.employeeCode ?? '',
            eSaleName: state.employeeSaleSelect?.fullName ?? '',
            isPrintPeople: state.printNumberOfPeople ? 1 : 0,
          );
          try {
            LocalStorage.deleteEmployeeSaleForOrder(order: state.orderSelect!);
          } catch (ex) {
            //
          }

          if (AppConfig.useFranchise) {
            String? errorPrint;
            showLogs(paymentPrinter, flags: 'paymentPrinter 1');
            showLogs(price, flags: ' price paymentPrinter 1');
            showLogs(itemPrint, flags: ' itemPrint paymentPrinter 1');
            showLogs(voucherPrint, flags: 'voucherPrint voucherPrint 1');

            for (var printer in paymentPrinter) {
              if (printer.type != 1) continue;
              try {
                var check = await AppPrinterCommon.checkPrinter(
                    IpOrderModel(ip: printer.ip, port: printer.port, type: 1));
                if (check != null) {
                  throw check;
                }

                PrinterTaskQueue.instance.addTask(
                    ip: printer.ip,
                    port: printer.port,
                    buildReceipt: (generator) async {
                      var bytes = await AppPrinterHtmlUtils.instance
                          .getReceptBillContent(
                        order: state.orderSelect!,
                        price: price,
                        printers: [
                          IpOrderModel(
                              ip: printer.ip, port: printer.port, type: 1),
                        ],
                        receiptType: ReceiptTypeEnum.paymentReceipt,
                        paymentMethod: state.paymentMethodSelected,
                        paymentAmount: state.statusPaymentGateway
                            ? state.totalPaymentGateway
                            : price.totalPriceFinal * 1.0,
                        numberPrintCompleted: 1,
                        numberPrintTemporary: 0,
                        orderLineItems: itemPrint,
                        vouchers: voucherPrint,
                        note: state.completeNote,
                        printNumberOfPeople: false,
                        customerPhone: state.customer?.phoneNumber ?? '',
                        numberOfPeople: state.numberOfAdults,
                        cashierCompleted: '',
                        cashierPrint: '',
                        timeCompleted: null,
                        timeCreatedAt: null,
                      );
                      return bytes;
                    });
                // var resPrint = await AppPrinterHtmlUtils.instance.printReceipt(
                //   order: state.orderSelect!,
                //   price: price,
                //   printers: [
                //     IpOrderModel(ip: printer.ip, port: printer.port, type: 1),
                //   ],
                //   receiptType: ReceiptTypeEnum.paymentReceipt,
                //   paymentMethod: state.paymentMethodSelected,
                //   paymentAmount: state.statusPaymentGateway
                //       ? state.totalPaymentGateway
                //       : price.totalPriceFinal * 1.0,
                //   numberPrintCompleted: 1,
                //   numberPrintTemporary: 0,
                //   orderLineItems: itemPrint,
                //   vouchers: voucherPrint,
                //   note: state.completeNote,
                //   printNumberOfPeople: false,
                //   customerPhone: state.customer?.phoneNumber ?? '',
                //   numberOfPeople: state.numberOfAdults,
                //   cashierCompleted: '',
                //   cashierPrint: '',
                //   timeCompleted: null,
                //   timeCreatedAt: null,
                //   // timeoutSecond: 7,
                // );

                // if (resPrint != null) {
                //   throw resPrint;
                // }
              } catch (ex) {
                if (loadingHome) updateEvent(HomeEvent.normal);
                //
                await showMessageDialog(context,
                    message: 'Không thể in phiếu thanh toán\n${ex.toString()}');
                return null;
              }
            }
          }
          break;
        } catch (ex) {
          if (state.employeeSaleSelect != null) {
            await LocalStorage.saveEmployeeSaleForOrder(
              order: state.orderSelect!,
              sale: state.employeeSaleSelect!,
            );
          }
          retry++;
          if (retry >= 3) {
            rethrow;
          }
        }
      }
      if (loadingHome) updateEvent(HomeEvent.normal);
      return null;
    } catch (ex) {
      if (loadingHome) updateEvent(HomeEvent.normal);
      return ex.toString();
    }
  }

  Future<String?> sendTicket({
    required String title,
    required String desc,
    List<File> files = const [],
  }) async {
    return 'Chưa triển khai';
  }

  Future<
      ({
        String? url,
        String? qr,
        int? expiryMin,
        String? error,
        int? statusCode
      })> getPaymentGateway() async {
    String? url, qr, error;
    int? statusCode;
    int? expiryMin;
    try {
      updateEvent(HomeEvent.getPaymentGateway);
      final apiBankParam = ApiBankParam(
          state.dataBill.order, getFinalPaymentPrice.totalPriceFinal);

      final paymentMethodSelect = state.paymentMethodSelected;
      if (paymentMethodSelect == null) {
        throw S.current.payment_method_not_select;
      }
      final result = await _restaurantRepository.getPaymentGateway(
        apiBankParam: apiBankParam,
        keyPaymentMethod: paymentMethodSelect.key,
      );
      url = result.url;
      qr = result.qr;
      expiryMin = result.expiryMin;
      error = result.message;
      statusCode = result.status;
    } catch (ex) {
      error = ex.toString();
    }
    updateEvent(HomeEvent.processed);
    return (
      url: url,
      qr: qr,
      expiryMin: expiryMin,
      error: error,
      statusCode: statusCode,
    );
  }

  void getListAtmPos() async {
    try {
      state = state.copyWith(
        atmPosSelect: null,
        listAtmPosState: const PageState(status: PageCommonState.loading),
      );
      await _checkOrderSelect();
      final res = await _restaurantRepository.getListAtmPos(
        orderId: state.orderSelect!.id,
        totalBill: getFinalPaymentPrice.totalPriceFinal,
      );
      state = state.copyWith(
        listAtmPosState: const PageState(status: PageCommonState.success),
        listAtmPos: res,
      );
    } catch (ex) {
      state = state.copyWith(
        listAtmPosState: PageState(
            status: PageCommonState.error, messageError: ex.toString()),
      );
    }
  }

  void onChangeAtmPosSelect(AtmPosModel? pos) {
    state = state.copyWith(atmPosSelect: pos);
  }

  /// cà thẻ động
  Future<String?> dynamicAtmPosCallback() async {
    try {
      updateEvent(HomeEvent.dynamicPosCallback);
      if (state.atmPosSelect == null) {
        throw S.current.no_select_pos_machine;
      }
      await _restaurantRepository.atmPosCallback(
        orderId: getFinalPaymentPrice.totalPriceFinal,
        urlPos: state.atmPosSelect!.url,
      );
      updateEvent(HomeEvent.normal);
      return null;
    } catch (ex) {
      updateEvent(HomeEvent.normal);
      return ex.toString();
    }
  }

  void onChangeCashReceivedAmount(double amount) {
    state = state.copyWith(cashReceivedAmount: max(0.0, amount));
    syncInfoForCustomer();
  }

  Future<String?> closingShift() async {
    try {
      updateEvent(HomeEvent.closingShift);
      await _orderRepository.closingShift();
      updateEvent(HomeEvent.normal);
      return null;
    } catch (ex) {
      updateEvent(HomeEvent.normal);
      return ex.toString();
    }
  }

  void onChangeAutoScrollProducts(bool value) {
    state = state.copyWith(autoScrollProducts: value);
    syncInfoForCustomer(
      method: WindowsMethod.changeOrderProduct,
      arguments: {
        'auto_scroll_order_product': state.autoScrollProducts,
        'changed_product_id': state.changedProductId,
      },
    );
  }

  void onChangeChangedProductId(int? id) {
    state = state.copyWith(changedProductId: id);
    syncInfoForCustomer(
      method: WindowsMethod.changeOrderProduct,
      arguments: {
        'auto_scroll_order_product': true,
        'changed_product_id': state.changedProductId,
      },
    );
  }

  Future<String?> onUpdateTax(List<ProductCheckoutModel> pc,
      {PaymentMethod? paymentMethod}) async {
    try {
      var pm = paymentMethod ?? state.paymentMethodSelected;

      showLogs('paymentMethod: $paymentMethod', flags: 'onUpdateTax');
      if (pm == null) return null;
      updateEvent(HomeEvent.updateTax);
      await _checkOrderSelect();
      if (pm.requireEditTax && pc.any((e) => e.tax == 0)) {
        throw S.current.error_edit_tax;
      }
      var result = await _orderRepository.updateTax(
        order: state.orderSelect!,
        pc: pc,
        paymentMethod: pm,
      );
      // check here
      state = state.copyWith(productCheckoutUpdateTax: result);
      requireUpdateDefaultTax = pm.requireEditTax;
      updateEvent(HomeEvent.normal);
      return null;
    } catch (ex) {
      updateEvent(HomeEvent.normal);
      return ex.toString();
    }
  }

  Future<String?> getDataBill({bool loadingHome = false}) async {
    try {
      if (loadingHome) state = state.copyWith(event: HomeEvent.getDataBill);
      state = state.copyWith(
          dataBillState: const PageState(status: PageCommonState.loading));
      await _checkOrderSelect();
      final result = await ref
          .read(orderRepositoryProvider)
          .getDataBill(orderId: state.orderSelect!.id);

      var orderLineItems = result.data.orderLineItems;

      /// check here: xem giá trị thuế
      /// state.productCheckout (thuế sau khi phân bổ - nếu có)
      showLogs(null, flags: 'cần check thuế trước và sau phân bổ');

      var productCheckout =
          List<ProductCheckoutModel>.from(state.productCheckout);

      var length = productCheckout.length;
      // cập nhật giá trị thuế
      for (var i = 0; i < length; i++) {
        var newTax = orderLineItems
            .firstWhereOrNull((e) => e.id == productCheckout[i].id);
        if (newTax != null) {
          productCheckout[i] = productCheckout[i].copyWith(
            tax: double.tryParse(newTax.tax) ?? 0.0,
            codeProduct: newTax.codeProduct,
          );
        }
      }

      state = state.copyWith(
        dataBill: result.data,
        dataBillState: const PageState(status: PageCommonState.success),
        productCheckout: productCheckout,
      );
      if (loadingHome) state = state.copyWith(event: HomeEvent.normal);
      syncInfoForCustomer();
      return null;
    } catch (ex) {
      state = state.copyWith(
        dataBillState: PageState(
          status: PageCommonState.error,
          messageError: ex.toString(),
        ),
      );
      if (loadingHome) state = state.copyWith(event: HomeEvent.normal);
      return ex.toString();
    }
  }

  void onChangePinnedOrder(bool value) {
    state = state.copyWith(pinnedOrder: value);
  }

  void onChangeNotePerItem(ProductModel item, String? note) {
    try {
      var order = state.orderSelect;
      if (order == null) return;

      var items = LocalStorage.getNotePerOrderItem(order: order);
      Map<String, String> notes = items ?? <String, String>{};
      notes[item.id.toString()] = note ?? '';
      notes.removeWhere((key, value) => value.trim().isEmpty);
      LocalStorage.saveNotePerOrderItem(order: order, notes: notes);
    } catch (ex) {
      //
      showLogs(ex.toString(), flags: 'onChangeNotePerItem ex');
    }
  }

  void setUnlockOrder() {
    state = state.copyWith(lockedOrder: false);
  }

  /// uncheck
  // promotion
  void changeSelectDiscountPromotion(
    CustomerPolicyModel coupon,
    DiscountPolicy discount,
    int amount,
  ) {
    DiscountPolicy discountUpdate = discount.copyWith(numberSelect: amount);
    CustomerPolicyModel couponUpdate = coupon.copyWith();

    List<DiscountPolicy> listDiscountUpdate =
        List<DiscountPolicy>.from(couponUpdate.discount);
    listDiscountUpdate[listDiscountUpdate.indexWhere(
        (element) => element.id == discountUpdate.id)] = discountUpdate;

    couponUpdate = couponUpdate.copyWith(discount: listDiscountUpdate);
    List<CustomerPolicyModel> couponState = List.from(state.coupons);
    couponState[couponState
        .indexWhere((element) => element.id == couponUpdate.id)] = couponUpdate;

    state = state.copyWith(coupons: couponState);
    applyCustomerPolicy();
  }

  void onChangeCustomerLanguage() {
    syncInfoForCustomer(
      method: WindowsMethod.language,
      arguments: LocalStorage.getCustomerLanguageLocal(),
    );
  }

  void onChangeEmployeeSaleSelect(EmployeeSaleModel? value) {
    state = state.copyWith(employeeSaleSelect: value);
  }

  void getEmployeeSales() async {
    try {
      state = state.copyWith(
        employeeSaleState: const PageState(status: PageCommonState.loading),
        employeeSaleSelect: null,
      );
      final result =
          await ref.read(restaurantRepositoryProvider).getEmployeeSales();
      state = state.copyWith(
        employeeSales: result,
        employeeSaleState: const PageState(status: PageCommonState.success),
      );
    } catch (ex) {
      state = state.copyWith(
          employeeSaleState: PageState(
        status: PageCommonState.error,
        messageError: ex.toString(),
      ));
    }
  }

  Future<String?> checkPrinter(List<IpOrderModel> printers) async {
    try {
      List<IpOrderModel> failed = [];
      updateEvent(HomeEvent.checkPrinter);
      for (var ipPrinter in printers) {
        var resultCheck = await LocalNetworkService.checkPrinter(
            ipPrinter.ip, ipPrinter.port);
        if (resultCheck == false) {
          failed.add(ipPrinter);
        }
      }
      updateEvent(HomeEvent.normal);

      if (failed.isEmpty) return null;

      var error = failed
          .map((e) => '- ${e.name} (${e.ip}:${e.port})\n')
          .toList()
          .join('');

      return "Không kết nối được máy in\n"
          '$error'
          "${"Vui lòng kiểm tra & đảm bảo".toUpperCase()}\n"
          "- Tablet và máy tính đã kết nối mạng Order\n"
          "- Máy in đã bật và không bị kẹt giấy\n"
          "- Dây mạng kết nối với máy in đã sáng";
    } catch (ex) {
      updateEvent(HomeEvent.normal);
      return ex.toString();
    }
  }

  void onChangePrintNumberOfPeople() {
    state = state.copyWith(printNumberOfPeople: !state.printNumberOfPeople);
  }

  /// check here: productCheckouts
  /// phân bổ lại thuế mặc định nếu đã phân bổ thuế cho đơn Grab, Shopee trước đó
  Future<String?> onUpdateDefaultTax() async {
    if (!requireUpdateDefaultTax) return null;
    if (state.orderSelect == null) return null;
    int count = 0;
    String? error;
    while (count < 3) {
      try {
        // lấy phương thức tiền mặt để phân bổ lại thuế
        var paymentCheck =
            _listPaymentMethods.firstWhereOrNull((e) => e.isCash);
        error = await onUpdateTax(productCheckouts,
            paymentMethod: paymentCheck ??
                const PaymentMethod(
                  key: 25,
                  name: 'Tiền mặt',
                  isCash: true,
                  requireEditTax: false,
                ));
        if (error != null) throw error;
        state = state.copyWith(productCheckoutUpdateTax: []);
        requireUpdateDefaultTax = false;
        try {
          await getDataBill(loadingHome: true);
        } catch (ex) {
          //
        }
        break;
      } catch (ex) {
        count++;
      }
    }
    if (error != null) {
      state = state.copyWith(
        dataBillState: const PageState(
          status: PageCommonState.error,
          messageError: 'Thông tin hóa đơn sai do chưa được phân bổ lại thuế',
        ),
      );
    }
    return error;
  }

  bool get requireUpdateTax {
    return kTypeOrder == AppConfig.orderOnlineValue &&
        (state.paymentMethodSelected?.requireEditTax ?? false);
  }

  PriceDataBill get getFinalPaymentPrice => state.dataBill.price;

  /// apply lại các mã only
  /// mã only bắt buộc phải xóa đi, add lại
  Future<String?> applyAgainOnlyCounpon() async {
    try {
      updateEvent(HomeEvent.applyPolicy);
      List<CustomerPolicyModel> failedDelete = [];
      List<CustomerPolicyModel> failedAdd = [];

      bool mustGetDataBill = false;

      var needApplyAgainOnlyCoupons =
          List<CustomerPolicyModel>.from(state.needApplyAgainOnlyCoupons);
      needApplyAgainOnlyCoupons = needApplyAgainOnlyCoupons.toSet().toList();

      var coupons = List<CustomerPolicyModel>.from(state.coupons);

      for (var c in needApplyAgainOnlyCoupons) {
        try {
          if (state.orderSelect == null) {
            return S.current.noOrderSelect;
          }
          final result = await _couponRepository.unblockCouponCode(
              idCode: c.id, order: state.orderSelect!);
          if (result) {
            mustGetDataBill = true;
            coupons.removeWhere((element) => element.id == c.id);
            needApplyAgainOnlyCoupons
                .removeWhere((element) => element.id == c.id);
            try {
              await LocalStorage.saveApplyAgainOnlyCoupon(
                  order: state.orderSelect!,
                  coupons: needApplyAgainOnlyCoupons);
            } catch (ex) {
              //
            }

            state = state.copyWith(
              coupons: coupons,
              needApplyAgainOnlyCoupons: needApplyAgainOnlyCoupons,
            );
            try {
              if (state.orderSelect == null) {
                failedAdd.add(c);
                return S.current.noOrderSelect;
              }
              var couponRepo = await _couponRepository.getCouponByCode(
                  code: c.name,
                  order: state.orderSelect!,
                  totalOrder: getFinalPaymentPrice.totalPrice * 1.0,
                  numberOfAdults: state.numberOfAdults);
              List<CustomerPolicyModel> data =
                  List<CustomerPolicyModel>.from(couponRepo.data.data);
              if (data.isEmpty) {
                final errorMessage = couponRepo.data.message;
                throw errorMessage.isEmpty
                    ? "${S.current.discount_code_is_not_valid} ($c)"
                    : errorMessage;
              }
              state = state.copyWith(
                coupons: [...data, ...state.coupons],
                customer: state.customer ?? data.first.customer,
              );
            } catch (ex) {
              //
              failedAdd.add(c);
            }
            break;
          } else {
            failedDelete.add(c);
          }
        } catch (ex) {
          failedDelete.add(c);
          break;
        }
      }

      updateEvent(HomeEvent.normal);
      if (failedDelete.isNotEmpty || failedAdd.isNotEmpty) {
        if (mustGetDataBill) getDataBill();
        return 'Các mã giảm giá chưa được áp dụng thành công\nVui lòng:\n'
            '${failedDelete.isNotEmpty ? '- Xóa mã và nhập lại mã: ${failedDelete.map((e) => e.name).join(', ')}\n' : ''}'
            '${failedAdd.isNotEmpty ? '- Nhập lại mã: ${failedAdd.map((e) => e.name).join(', ')}' : ''}';
      }
      try {
        if (state.coupons.any((e) => !e.only)) {
          await applyCustomerPolicy(loadingHome: true);
        } else {
          await getDataBill(loadingHome: true);
        }
      } catch (ex) {
        //
      }
      return null;
    } catch (ex) {
      return ex.toString();
    }
  }

  void onChangeOrderTabSelect(OrderTabEnum value) {
    state = state.copyWith(orderTabSelect: value);
  }

  void onChangeDisplayOrderHistory(bool? value) {
    state = state.copyWith(
        displayOrderHistory: value ?? !state.displayOrderHistory);
  }

  void onChangeCancelOrderItem({bool? value}) {
    state = state.copyWith(cancelOrderItem: value ?? !state.cancelOrderItem);
  }

  Future<String?> addItemsToOrder(BuildContext context) async {
    var total = 0.0;

    state.productsSelecting.forEach(
      (element) {
        total += element.numberSelecting < 0
            ? 0
            : element.numberSelecting *
                (double.tryParse(element.unitPrice) ?? 0.0);
      },
    );

    showLogs(state.orderSelect, flags: 'state.orderSelect');
    var i = LocalStorage.getNotePerOrderItem(
        order: state.orderSelect ?? const OrderModel());

    Set<int> printerCheck = {};
    List<ProductModel> productPrintBill = (state.productsSelecting).map((e) {
      if (e.printerType != null) {
        printerCheck.add(e.printerType!);
      }
      return e.copyWith(noteForProcessOrder: i?[e.id.toString()] ?? '');
    }).toList();
    try {
      updateEvent(HomeEvent.processOrder);

      var listPrinters = await _orderRepository.getIpPrinterOrder(
          state.orderSelect!, printerCheck.toList());
      if (listPrinters.error != null) {
        throw listPrinters.error!;
      }

      var kitchenNote = state.kitchenNote;
      await _orderRepository.processOrder(
        order: state.orderSelect!,
        total: total,
        orderNote: kitchenNote,
        products: productPrintBill,
      );
      state = state.copyWith(productsSelecting: []);

      getOrderProductCheckout(
        changeSelecting: true,
        applyPolicy: true,
      );
      if (AppConfig.useFranchise) {
        state = state.copyWith(kitchenNote: '');

        try {
          var appSeting = LocalStorage.getAppSettings();
          AppPrinterSettingTypeEnum appPrinterType = appSeting.appPrinterType;
          String? errorPrint;

          // if (appPrinterType == AppPrinterSettingTypeEnum.normal) {
          //   errorPrint = await AppPrinterNormalUtils.printKitchenBill(
          //     order: state.orderSelect!,
          //     products: productPrintBill,
          //     cancel: false,
          //     totalNote: kitchenNote,
          //     timeOrder: 1,
          //     allowPrintSingleBill: true,
          //     printers: listPrinters.printers,
          //   );
          // } else {
          for (var printer in listPrinters.printers) {
            showLogs(printer, flags: 'printer');
            List<ProductModel> productPrinter = [];
            for (var p in productPrintBill) {
              var comboItem = ProductHelper().getComboDescription(p);
              // combo
              List<ComboItemModel> comboItemPrint = [];
              if (comboItem != null) {
                comboItemPrint = comboItem
                    .where((e) => e.printerType == printer.type)
                    .toList();
                if (comboItemPrint.isNotEmpty) {
                  String? description = p.description;
                  try {
                    description = jsonEncode(comboItemPrint);
                  } catch (ex) {
                    showLogs(ex.toString(), flags: 'encode món trong combo');
                    //
                  }
                  productPrinter.add(p.copyWith(description: description));
                } else if (printer.type == p.printerType) {
                  productPrinter.add(p.copyWith(description: ''));
                }
              } else {
                if (printer.type == p.printerType) {
                  productPrinter.add(p);
                }
              }
            }
            // var productPrinter =
            //     product.where((e) => e.printerType == item.type).toList();

            if (productPrinter.isEmpty) {
              continue;
            }
            productPrinter.forEach(
              (element) {
                showLogs(element, flags: 'productPrinter');
              },
            );
            var htmlData = AppPrinterHtmlUtils.instance.kitchenBillContent(
              order: state.orderSelect!,
              product: productPrinter,
              note: kitchenNote,
              timeOrders: 1,
              cancel: false,
            );
            // var bytes =
            //     await AppPrinterHtmlUtils.instance.generateImageBill(htmlData);
            // errorPrint = await AppPrinterHtmlUtils.instance.printKitchenBill(
            //   order: state.orderSelect!,
            //   printers: listPrinters.printers,
            //   product: productPrintBill,
            //   note: kitchenNote,
            //   printEachItem: true,
            // );
            var bytes = appPrinterType == AppPrinterSettingTypeEnum.normal
                ? await AppPrinterNormalUtils.instance.generateBill(
                    order: state.orderSelect!,
                    billSingle: false,
                    cancel: false,
                    timeOrder: 1,
                    totalNote: kitchenNote,
                    products: productPrinter,
                    title: '',
                  )
                : await AppPrinterHtmlUtils.instance
                    .generateImageBill(htmlData);
            PrinterTaskQueue.instance.addTask(
              ip: printer.ip,
              port: printer.port,
              buildReceipt: (generator) async {
                return bytes;
              },
              onComplete: (success, error) async {
                if (success) {
                  showLogs("✅ In thành công", flags: 'in món thành công');
                  // chỉ in bill lẻ với bếp
                  if (printer.type == 2 &&
                      appSeting.billReturnSetting.useOddBill) {
                    for (var p in productPrinter) {
                      List<int> byteDatas;
                      var oddHtmlBill =
                          AppPrinterHtmlUtils.instance.kitchenBillContent(
                        product: [p],
                        totalBill: false,
                        order: state.orderSelect!,
                        note: kitchenNote,
                        timeOrders: 1,
                      );
                      byteDatas = appPrinterType ==
                              AppPrinterSettingTypeEnum.normal
                          ? await AppPrinterNormalUtils.instance.generateBill(
                              order: state.orderSelect!,
                              billSingle: true,
                              cancel: false,
                              timeOrder: 1,
                              totalNote: kitchenNote,
                              products: [p],
                              title: '',
                            )
                          : await AppPrinterHtmlUtils.instance
                              .generateImageBill(oddHtmlBill);
                      PrinterTaskQueue.instance.addTask(
                        ip: printer.ip,
                        port: printer.port,
                        buildReceipt: (generator) async {
                          // var byteDatas = await AppPrinterHtmlUtils.instance
                          //     .generateImageBill(oddHtmlBill);
                          return byteDatas;
                        },
                        onComplete: (success, error) {
                          if (success) {
                            showLogs("✅ In thành công",
                                flags: 'in món lẻ thành công');
                          } else {
                            showLogs("❌ In thất bại: $error",
                                flags: 'in món lẻ thất bại');
                          }
                        },
                      );
                    }
                  }
                } else {
                  showLogs("❌ In thất bại: $error", flags: 'in món thất bại');
                  if (error != null) {
                    showMessageDialog(context, message: error);
                  }
                }
              },
            );
          }

          // var res = await AppPrinterNormalUtils.printKitchenBill(
          //   order: state.orderSelect!,
          //   products: productPrintBill,
          //   cancel: false,
          //   totalNote: state.kitchenNote,
          //   timeOrder: 1,
          //   allowPrintSingleBill: true,
          //   printers: listPrinters.printers,
          // );
          if (errorPrint != null) {
            updateEvent(HomeEvent.normal);
            if (context.mounted) {
              showMessageDialog(
                context,
                message:
                    'Món đã được thêm vào hóa đơn nhưng không thể in bill xuống bếp\n'
                    'Lỗi:\n$errorPrint',
              );
            }
            return null;
          }
        } catch (ex) {
          updateEvent(HomeEvent.normal);
          if (context.mounted) {
            showMessageDialog(
              context,
              message:
                  'Món đã được thêm vào hóa đơn nhưng không thể in bill xuống bếp\n'
                  'Lỗi:\n${ex.toString()}',
            );
          }
          return null;
        }
      }

      updateEvent(HomeEvent.normal);
      return null;
    } catch (ex) {
      updateEvent(HomeEvent.normal);
      if (ex is AppException && ex.errorCode == 423) {
        state = state.copyWith(lockedOrder: true);
      }
      return ex.toString();
    }
  }

  void cancelProductCheckout(ProductModel p, int count) {
    try {
      var productCheckout =
          List<ProductCheckoutModel>.from(state.productCheckout);

      var productCheck = productCheckout.firstWhereOrNull((e) => e.id == p.id);
      if (productCheck != null) {
        var index = productCheckout.indexOf(productCheck);
        if (index != -1) {
          // ignore: unused_result
          productCheck = productCheck.copyWith(
              quantityCancel: productCheck.quantityCancel + count);
          productCheckout[index] = productCheck;
        }
      }
      state = state.copyWith(productCheckout: productCheckout);
    } catch (ex) {
      showLogs(ex.toString(), flags: 'check');
    }
  }

  Future<void> getOrderToOnline() async {
    bool useO2O = LocalStorage.getDataLogin()?.restaurant?.o2oStatus ?? false;
    ;
    if (!useO2O || kTypeOrder == AppConfig.orderOnlineValue) return;
    try {
      int retry = 0;
      List<O2OOrderModel> datas = [];
      var loginUserId = LocalStorage.getDataLogin()?.user?.id;

      showLogs(loginUserId, flags: 'loginUserId check');
      state = state.copyWith(
        getO2ODataState: const PageState(status: PageCommonState.loading),
      );
      while (retry < 3) {
        try {
          datas = [];
          final result = await _orderRepository.getOrderToOnline();
          for (var order in result) {
            if (loginUserId != null && order.userId == loginUserId) {
              datas.add(order);
              // List<RequestOrderModel> requests = List<RequestOrderModel>.from(order.items);
              // for (var request in requests) {
              //   if (request.requestProcessingStatus == RequestProcessingStatus.waiting &&
              //       request.listItem.isNotEmpty) {
              //     count++;
              //   }
              // }
            }
          }
          state = state.copyWith(
            getO2ODataState: const PageState(status: PageCommonState.success),
            o2oData: datas,
          );
          break;
        } catch (ex) {
          retry++;
          if (retry == 3) {
            state = state.copyWith(
              getO2ODataState: PageState(
                status: PageCommonState.error,
                messageError: ex.toString(),
              ),
            );
          }
        }
      }
    } catch (ex) {
      //
    }
  }

  void getO2OChatMessages() async {
    try {
      state = state.copyWith(
          getChatMessageState:
              const PageState(status: PageCommonState.loading));
      final loginData = LocalStorage.getDataLogin();
      int? restaurantId = loginData?.restaurant?.id;
      final selectedOrder = state.orderSelect;
      if (restaurantId == null || selectedOrder == null) {
        state = state.copyWith(
          getChatMessageState: PageState(
              status: PageCommonState.error, messageError: S.current.no_data),
        );
        return;
      }
      final messages = await _orderRepository.getChatMessages(
        restaurantId: restaurantId,
        orderId: selectedOrder.id,
      );
      state = state.copyWith(
        getChatMessageState: const PageState(status: PageCommonState.success),
        chatMessages: messages,
      );
    } catch (ex) {
      state = state.copyWith(
        getChatMessageState: PageState(
          status: PageCommonState.error,
          messageError: ex.toString(),
        ),
      );
    }
  }

  void getReservations() async {
    var useReservation =
        LocalStorage.getDataLogin()?.restaurant?.reservationStatus ?? false;
    if (!useReservation) {
      state = state.copyWith(
        getReservationsState: const PageState(status: PageCommonState.success),
        reservations: [],
      );
      return;
    }
    try {
      state = state.copyWith(
          getReservationsState:
              const PageState(status: PageCommonState.loading));
      var reservations =
          await ref.read(reservationRepositoryProvider).getReservations();
      state = state.copyWith(
        getReservationsState: const PageState(status: PageCommonState.success),
        reservations: reservations,
      );
    } catch (ex) {
      state = state.copyWith(
        getReservationsState: PageState(
          status: PageCommonState.error,
          messageError: ex.toString(),
        ),
      );
    }
  }

  void addCustomerToOrder({
    required int orderId,
    required String phoneNumber,
    required dynamic reservationId,
  }) async {
    int retry = 0;
    if (phoneNumber.trim().isEmpty) return;

    while (retry < 3) {
      try {
        var loginData = LocalStorage.getDataLogin();
        await _customerRepository.findCustomer(
            phoneNumber: phoneNumber,
            order: OrderModel(
              id: orderId,
              name: '',
              misc: '',
              waiterId: loginData?.waiterId,
              reservationCrmId: reservationId,
            ));

        break;
      } catch (ex) {
        //
        retry++;
      }
    }
  }

  void updateReservationModel(ReservationModel? reservation) async {
    if (reservation == null) return;

    int retry = 0;
    while (retry < 3) {
      try {
        await ref
            .read(reservationRepositoryProvider)
            .updateReservation(reservation.id, reservation);
        break;
      } catch (ex) {
        retry++;
      }
    }
  }

  /// Chuyển giao đơn hàng
  /// Hàm này không được dùng, đang dùng cho app manager
  Future<String?> transferOrder(
    List<int> tableIds,
    OrderModel order,
    WaiterModel waiterTransfer, {
    ReservationModel? reservation,
  }) async {
    try {
      updateEvent(HomeEvent.transferOrder);

      await _orderRepository.createAndUpdateOrder(
        tableIds,
        order,
        reservation: reservation,
        waiterTransfer: waiterTransfer,
      );
      updateEvent(null);
      return null;
    } catch (ex) {
      updateEvent(null);
      return ex.toString();
    }
  }
}

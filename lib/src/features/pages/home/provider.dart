import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/configs/enums/bill_setting.dart';
import 'package:aladdin_franchise/src/configs/enums/windows_method.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/category/category_repository.dart';
import 'package:aladdin_franchise/src/core/network/coupon/coupon_repository.dart';
import 'package:aladdin_franchise/src/core/network/customer/customer_repository.dart';
import 'package:aladdin_franchise/src/core/network/invoice/invoice_repository.dart';
import 'package:aladdin_franchise/src/core/network/o2o/o2o_repository.dart';
import 'package:aladdin_franchise/src/core/network/order/order_repository.dart';
import 'package:aladdin_franchise/src/core/network/product/product_repository.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/network/responses/data_bill.dart';
import 'package:aladdin_franchise/src/core/network/restaurant/restaurant_repository.dart';
import 'package:aladdin_franchise/src/core/network/user/user_repository.dart';
import 'package:aladdin_franchise/src/core/services/print_queue.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/data/enum/discount_type.dart';
import 'package:aladdin_franchise/src/data/enum/receipt_type.dart';
import 'package:aladdin_franchise/src/data/enum/windows_method.dart';
import 'package:aladdin_franchise/src/data/response/add_voucher.dart';
import 'package:aladdin_franchise/src/features/dialogs/message.dart';
import 'package:aladdin_franchise/src/features/dialogs/order/order_option_dialog.dart';
import 'package:aladdin_franchise/src/features/pages/customer/view.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/features/pages/home/view.dart';
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
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';
import 'package:aladdin_franchise/src/models/param_family/bank_param.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
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
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:aladdin_franchise/src/utils/ip_config_helper.dart';
import 'package:aladdin_franchise/src/utils/product_helper.dart';
import 'package:collection/collection.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redis/redis.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
    ref.read(o2oRepositoryProvider),
    ref.read(invoiceRepositoryProvider),
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
    this._o2oRepository,
    this._invoiceRepository,
  ) : super(const HomeState()) {
    AppConfig.initHomeProvider = true;
    ctrlSearch = TextEditingController();
    // confirm dùng redis hay không?
    // listenRedisChannel();
  }

  final Ref ref;
  final OrderRepository _orderRepository;
  final UserRepository _userRepository;
  final CustomerRepository _customerRepository;
  final CouponRepository _couponRepository;
  final RestaurantRepository _restaurantRepository;
  final CategoryRepository _categoryRepository;
  final ProductRepository _productRepository;

  final OrderToOnlineRepository _o2oRepository;
  final InvoiceRepository _invoiceRepository;

  Map<dynamic, GlobalKey> categoryKeys = {};

  final ItemScrollController categoryScrollController = ItemScrollController();
  final ItemPositionsListener categoryPositionsListener =
      ItemPositionsListener.create();

  late TextEditingController ctrlSearch;

  List<PaymentMethod> _listPaymentMethods = [];

  /// bắt buộc update lại thuế với giá trị mặc định
  bool requireUpdateDefaultTax = false;

  final selectedItemsScrollCtrl = ItemScrollController();
  final selectedItemsPositionsListener = ItemPositionsListener.create();

  final selectingItemsScrollCtrl = ItemScrollController();
  final selectingItemsPositionsListener = ItemPositionsListener.create();

  @override
  void dispose() {
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
  }

  void initialize({
    bool loadProducts = true,
    OrderModel? order,
  }) async {
    if (!mounted) return;
    ctrlSearch.text = '';
    final dataLogin = LocalStorage.getDataLogin();
    final customerPortraits = dataLogin?.customerPortraits ?? [];

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
    );
    syncInfoCustomerPage(method: WindowsMethodEnum.order);
    _resetOrder();
    if (loadProducts) {
      await getProducts();
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
    showLogs(orderModel, flags: 'changeOrderSelect');
    if (state.orderSelect != null) {
      try {
        Map<String, int> data = {};
        for (var e in state.productsSelecting) {
          data[e.id.toString()] = e.numberSelecting;
        }

        await LocalStorage.setOrderItemSelectingForOrder(
          orderId: state.orderSelect!.id,
          data: data,
        );
      } catch (ex) {
        //
      }
    }
    state = state.copyWith(orderSelect: orderModel);
    _resetOrder();
    if (orderModel != null) {
      if (orderModel.typeOrder != kTypeOrder) {
        await LocalStorage.setTypeOrderWaiter(orderModel.typeOrder);
        ref.refresh(typeOrderWaiterProvider);
        ref.read(homeProvider.notifier).initialize(order: orderModel);
      } else {
        getOrderProductCheckout();
        getOrderInvoice();
      }
    }
  }

  ///
  /// [loadingHome] = false - hiện circle loading
  ///
  /// [applyPolicy] = true - áp dụng lại mã giảm giá
  ///
  /// [ignoreGetDataBill] = false - bỏ qua lấy data bill
  Future<void> getOrderProductCheckout({
    bool loadingHome = false,
    bool applyPolicy = true,
    bool ignoreGetDataBill = false,
  }) async {
    try {
      state = state.copyWith(
        productCheckoutState: const PageState(status: PageCommonState.loading),
      );
      if (loadingHome) updateEvent(HomeEvent.getProductCheckout);

      int tryAgain = 0;
      while (tryAgain < 3) {
        var orderSelect = state.orderSelect;
        try {
          if (orderSelect == null) {
            if (loadingHome) updateEvent(HomeEvent.normal);
            state = state.copyWith(
                productCheckoutState:
                    const PageState(status: PageCommonState.success));
            _resetOrder();
            return;
          }
          final productRepo =
              await _orderRepository.getProductCheckout(orderSelect);
          final pc = List<ProductCheckoutModel>.from(
              productRepo.data?.first.orderItem ?? []);

          final coupons =
              List<CustomerPolicyModel>.from(productRepo.coupons ?? []);
          final customer = productRepo.customer;
          var orderHistory = productRepo.data?.first.orderHistory ?? [];
          state = state.copyWith(orderHistory: orderHistory);
          var notes = LocalStorage.getNotePerOrderItem(order: orderSelect);
          List<ProductModel> productsSelected = [];

          // map: ProductCheckoutModel -> ProductModel
          for (var item in pc) {
            // showLogs(item, flags: 'item');
            var p = state.products.firstWhereOrNull((e) => e.id == item.id);
            if (p != null) {
              var changeProduct = p.copyWith(
                numberSelecting: item.quantity,
                noteForProcessOrder: notes?[p.id.toString()] ?? '',
              );
              productsSelected.add(changeProduct);
            } else {
              // case món k có trong menu (k hiện nhưng tiền # 0)
              productsSelected.add(
                ProductModel(
                  id: item.id,
                  numberSelecting: item.quantity,
                  unitPrice: item.unitPrice,
                  name: item.name,
                  nameEn: item.nameEn,
                  language: item.language,
                  unit: item.unit,
                  tax: item.tax,
                  printerType: item.printerType,
                  noteForProcessOrder: notes?[item.id.toString()] ?? '',
                ),
              );
            }
          }

          for (final c in coupons) {
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
                    var ps = productsSelected
                        .firstWhereOrNull((e) => e.id == pt.menuItemId);

                    if (ps != null) {
                      try {
                        productsSelected[productsSelected.indexOf(ps)] =
                            ps.copyWith(
                                quantityPromotion:
                                    ps.quantityPromotion + pt.quantity);
                      } catch (ex) {
                        //
                      }
                    }
                    var pcout =
                        pc.firstWhereOrNull((e) => e.id == pt.menuItemId);
                    if (pcout != null) {
                      try {
                        pc[pc.indexOf(pcout)] = pcout.copyWith(
                            quantityPromotion:
                                (ps?.quantityPromotion ?? 0) + pt.quantity);
                      } catch (ex) {
                        //
                      }
                    }
                  }
                }
              }
              coupons[coupons.indexOf(c)] =
                  c.copyWith(discount: discountUpdate);
            }
          }

          var productSelectingMap =
              LocalStorage.getOrderItemSelectingForOrder(orderSelect.id);

          List<ProductModel> selecting = [];
          productSelectingMap.forEach((key, value) {
            var p =
                state.products.firstWhereOrNull((e) => e.id.toString() == key);
            if (p != null) {
              selecting.add(p.copyWith(numberSelecting: value));
            }
          });

          state = state.copyWith(
            coupons: coupons,
            customer: customer,
            productsSelected: productsSelected,
            productsSelecting: selecting,
            productCheckout: pc,
            numberOfAdults: max(productRepo.numberOfAdults, 1),
            orderHistory: orderHistory,
          );
          for (var e in [
            WindowsMethodEnum.customer,
            WindowsMethodEnum.productCheckout,
          ]) {
            syncInfoCustomerPage(method: e);
          }

          state = state.copyWith(
              productCheckoutState:
                  const PageState(status: PageCommonState.success));
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
      state = state.copyWith(
        productCheckoutState: PageState(
          status: PageCommonState.error,
          messageError: ex.toString(),
        ),
      );
      if (loadingHome) updateEvent(HomeEvent.normal);
    }
  }

  void changeCategorySelect(CategoryModel? categoryModel) {
    state = state.copyWith(categorySelect: categoryModel);

    if ((categoryModel?.children ?? []).isEmpty) {
      changeSubCategorySelect(null);
    } else {
      var subCategorySelect = state.subCategorySelect;
      var checkSubCategorySelect = categoryModel?.children
          ?.firstWhereOrNull((e) => e == subCategorySelect);
      if (subCategorySelect == null || checkSubCategorySelect == null) {
        changeSubCategorySelect((categoryModel?.children?.isEmpty ?? true)
            ? null
            : categoryModel!.children!.first);
      }
    }
  }

  void changeSubCategorySelect(SubCategoryModel? subCategoryModel) {
    state = state.copyWith(subCategorySelect: subCategoryModel);
  }

  /// thêm sp vào giỏ hàng (số lượng 1)
  void addProductToCart({required ProductModel product}) async {
    var orderSelect = state.orderSelect;
    if (orderSelect == null) return;
    var productsSelecting = List<ProductModel>.from(state.productsSelecting);

    var index = productsSelecting.indexWhere((e) => e.id == product.id);
    if (index != -1) {
      var item = productsSelecting[index];
      productsSelecting[index] =
          product.copyWith(numberSelecting: max(0, item.numberSelecting) + 1);
    } else {
      productsSelecting.add(product.copyWith(numberSelecting: 1));
    }
    state = state.copyWith(
      productsSelecting: productsSelecting,
      changedProductId: product.id,
    );

    onChangeAutoScrollProducts(true);
    state = state.copyWith(orderTabSelect: OrderTabEnum.ordering);

    Map<String, int> data = {};
    for (var e in productsSelecting) {
      data[e.id.toString()] = e.numberSelecting;
    }
    try {
      await LocalStorage.setOrderItemSelectingForOrder(
          orderId: orderSelect.id, data: data);
    } catch (ex) {
      showLogs(ex, flags: 'addProductToCart - K lưu được món đang chọn');
    }
    return null;
  }

  /// thay đổi số lượng sp trong cart
  void changeProductInCart(ProductModel productModel, int count) async {
    var orderSelect = state.orderSelect;
    if (orderSelect == null) return;
    var productsSelecting = List<ProductModel>.from(state.productsSelecting);
    var item =
        productsSelecting.firstWhereOrNull((e) => e.id == productModel.id);
    if (item != null) {
      if (count > 0) {
        var index = productsSelecting.indexOf(item);
        if (index != -1) {
          productsSelecting[index] =
              productModel.copyWith(numberSelecting: count);
        }
      } else {
        productsSelecting.remove(item);
      }
    }
    productsSelecting.removeWhere((e) => e.numberSelecting < 1);
    state = state.copyWith(
      productsSelecting: productsSelecting,
      changedProductId: productModel.id,
    );
    onChangeAutoScrollProducts(true);
    Map<String, int> data = {};
    for (var e in productsSelecting) {
      data[e.id.toString()] = e.numberSelecting;
    }
    try {
      await LocalStorage.setOrderItemSelectingForOrder(
          orderId: orderSelect.id, data: data);
    } catch (ex) {
      showLogs(ex, flags: 'changeProductInCart - K lưu được món đang chọn');
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
      productsSelected: [],
      productsSelecting: [],
      productCheckout: [],
      productCheckoutState: const PageState(status: PageCommonState.success),
      customer: null,
      coupons: [],
      vouchers: [],
      createVouchers: null,
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
      imageBills: [],
      numberOfAdults: 1,
      numberOfChildren: 0,
      kitchenNote: '',
      customerPortraitSelect: null,
      completeNote: '',
      printNumberOfPeople: false,
      autoScrollProducts: true,
      changedProductId: null,
      displayOrderHistory: false,
    );
    _listPaymentMethods = [];
    requireUpdateDefaultTax = false;
    for (var e in [
      WindowsMethodEnum.order,
      WindowsMethodEnum.paymentMethod,
      WindowsMethodEnum.customer,
      WindowsMethodEnum.price,
      WindowsMethodEnum.productCheckout,
      WindowsMethodEnum.changeOrderProduct,
    ]) {
      syncInfoCustomerPage(method: e);
    }
    // syncInfoForCustomer();
  }

  Future<void> loadingChangeOrderSelect(
    int orderId, {
    int? typeOrder,
    dynamic reservationCrmId,
  }) async {
    try {
      updateEvent(HomeEvent.loadingChangeOrderCurrent);
      state = state.copyWith(
          orderSelect: OrderModel(
        id: orderId,
        typeOrder: typeOrder ?? kTypeOrder,
        reservationCrmId: reservationCrmId,
      ));
      _resetOrder();
      ref.invalidate(tablesAndOrdersProvider);
      updateEvent(null);
    } catch (ex) {
      state = state.copyWith(
        event: HomeEvent.errorInfo,
        messageError: "${S.current.error_change_order}\n"
            "---\n"
            "${S.current.ex_problem}: ${ex.toString()}",
        orderSelect: null,
      );
      _resetOrder();
    }
  }

  String getMessageError() => state.messageError;

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

  void checkReloadMenu() {
    final lastTime = LocalStorage.getLastReloadMenu();
    final now = DateTime.now();
    if ((now.compareToWithoutTime(lastTime) == false) &&
        now.hour >= 9 &&
        now.minute >= 5) {
      getProducts();
    }
  }

  Future<FindCustomerStatus> findCustomer(
    String phone, {
    bool loadingHome = true,
  }) async {
    try {
      if (loadingHome) updateEvent(HomeEvent.findingCustomer);
      await _checkOrderSelect();
      var customerRepo = await _customerRepository.findCustomer(
          phoneNumber: phone, order: state.orderSelect!);
      if (loadingHome) updateEvent(null);
      if (customerRepo.data.customer is List<dynamic> == false) {
        CustomerModel customer =
            CustomerModel.fromJson(customerRepo.data.customer);
        state = state.copyWith(customer: customer);
        syncInfoCustomerPage(method: WindowsMethodEnum.customer);
        // syncInfoForCustomer();
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
      if (loadingHome) {
        state = state.copyWith(
          event: HomeEvent.normal,
          messageError: errorMessage,
        );
      }
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
      updateEvent(HomeEvent.createCustomer);
      if (phone.isEmpty ||
          firstName.isEmpty ||
          lastName.isEmpty ||
          (noBOD ? false : birthday.isEmpty)) {
        updateEvent(null);
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
      updateEvent(null);
      return null;
    } catch (ex) {
      _lockOrder(ex);
      updateEvent(null);
      return "${S.current.unable_add_customer}\n${ex.toString()}";
    }
  }

  /// nhập mã giảm
  Future<({String? error, String? titleError})> addCoupon({
    required String code,
    bool loadingHome = true,
    bool applyPolicy = true,
  }) async {
    try {
      if (state.coupons.any((element) =>
          element.name.trim().toLowerCase() == code.trim().toLowerCase())) {
        return (
          error: S.current.discount_code_already_exists,
          titleError: null,
        );
      }
      if (loadingHome) updateEvent(HomeEvent.checkTicket);
      await _checkOrderSelect();

      final couponRepo = await _couponRepository.addCoupon(
        code: code,
        order: state.orderSelect!,
        totalOrder:
            AppUtils.convertToDouble(getFinalPaymentPrice.totalPrice) ?? 0.0,
        numberOfAdults: state.numberOfAdults,
      );

      if (loadingHome) updateEvent(null);
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
      if (loadingHome) updateEvent(null);
      return (
        error: ex.toString(),
        titleError: "${S.current.failed_apply_discount_code} ($code)",
      );
    }
  }

  /// nhập tiền giảm hoặc % giảm
  Future<({String? error, String? titleError})> addVoucher({
    double value = 0,
    bool loadingHome = true,
    bool applyPolicy = true,
  }) async {
    try {
      if (loadingHome) updateEvent(HomeEvent.addCoupon);

      final couponRepo = await _couponRepository.addVoucher(
        order: state.orderSelect!,
        totalBill: getFinalPaymentPrice.totalPrice * 1.0,
        amount: value,
        type: state.discountTypeSelect,
      );

      if (loadingHome) updateEvent(null);
      if (couponRepo.data == null) {
        return (
          error: 'Không có dữ liệu',
          titleError: null,
        );
      }

      state = state.copyWith(
        coupons: [
          CustomerPolicyModel(
            id: couponRepo.data?.id,
            name: couponRepo.data?.name ?? '',
            type: null,
            isType: 3,
            discount: [
              DiscountPolicy(
                id: null,
                name: null,
                // do response trả về lại là số tiền giảm nên type sẽ là DiscountTypeEnum.vnd
                // getOrderProductCheckout sẽ ghi đè lại thông in mã giảm
                type: DiscountTypeEnum.vnd.key,
                amount: couponRepo.data?.amount ?? 0.0,
              ),
            ],
          ),
          ...state.coupons
        ],
      );
      getOrderProductCheckout();
      return (error: null, titleError: null);
    } catch (ex) {
      _lockOrder(ex);
      if (loadingHome) updateEvent(null);
      bool isPercent = state.discountTypeSelect == DiscountTypeEnum.percent;
      return (
        error: ex.toString(),
        titleError: '${S.current.failed_apply_discount_code} '
            '(${isPercent ? AppUtils.getPercentValue(value) : AppUtils.formatCurrency(symbol: '', value: value)} ${isPercent ? '%' : 'đ'})',
      );
    }
  }

  /// xoá mã nhập tiền giảm hoặc % giảm
  Future<String?> removeVoucher({
    required CustomerPolicyModel coupon,
    bool loadingHome = true,
    bool applyPolicy = true,
  }) async {
    try {
      if (loadingHome) updateEvent(HomeEvent.removeCoupon);

      await _couponRepository.deleteVoucher(coupon.id);

      if (loadingHome) updateEvent(null);
      var coupons = List<CustomerPolicyModel>.from(state.coupons);
      coupons.removeWhere((e) => e.id == coupon.id);
      state = state.copyWith(coupons: coupons);
      if (applyPolicy) await applyCustomerPolicy(loadingHome: loadingHome);
      return null;
    } catch (ex) {
      _lockOrder(ex);
      if (loadingHome) updateEvent(null);
      return ex.toString();
    }
  }

  ///
  Future<({String? error, List<IpOrderModel> printers, bool errorGetPrinter})>
      cancelProductOrder(
    List<ProductCheckoutModel> cancelProductCheckouts, {
    String contentCancelOrder = 'Khách chọn nhầm',
    bool ignoreGetPrinter = false,
    List<int> printerCheck = const [],
  }) async {
    showLogs(cancelProductCheckouts, flags: 'cancelProductCheckouts');
    showLogs(ignoreGetPrinter, flags: 'ignoreGetPrinter');
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
              errorGetPrinter: false,
            );
          }

          showLogs(printerCheck,
              flags: 'cancelProductOrder - lấy ds máy in theo kiểu món');
          // nếu ds sp có chứa đồ uống hoặc k sử dụng KDS thì mới cần lấy ds máy in
          if (printers.isEmpty &&
              !ignoreGetPrinter &&
              printerCheck.isNotEmpty &&
              (printerCheck.contains(4) || !AppConfig.useKds)) {
            try {
              var resultCheckPrinter = await _orderRepository.getPrinterBill(
                  state.orderSelect!, printerCheck.toList());
              if (resultCheckPrinter.error != null) {
                throw resultCheckPrinter.error!;
              }
              printers = List<IpOrderModel>.from(resultCheckPrinter.printers);
            } catch (ex) {
              if (retry >= 2) {
                updateEvent(null);
                return (
                  error: ex.toString(),
                  printers: <IpOrderModel>[],
                  errorGetPrinter: true,
                );
              }
              rethrow;
            }
          }
          await _orderRepository.cancelDishInOrder(
            order: state.orderSelect!,
            total: 0,
            contentCancelOrder: contentCancelOrder,
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
              remain = max(0, check.quantity + item.quantityCancel);
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
          syncInfoCustomerPage(method: WindowsMethodEnum.productCheckout);
          getOrderProductCheckout(applyPolicy: true);

          updateEvent(null);
          return (
            error: null,
            printers: printers,
            errorGetPrinter: false,
          );
        } catch (ex) {
          showLogs(ex, flags: 'ex');
          retry++;
          if (retry >= 3) {
            rethrow;
          }
        }
      }
      updateEvent(null);
      return (
        error: null,
        printers: <IpOrderModel>[],
        errorGetPrinter: false,
      );
    } catch (ex) {
      updateEvent(null);
      return (
        error: ex.toString(),
        printers: <IpOrderModel>[],
        errorGetPrinter: false,
      );
    }
  }

  void loadPaymentMethods() async {
    try {
      state = state.copyWith(
        paymentMethodState: const PageState(status: PageCommonState.loading),
        paymentMethodSelected: null,
      );
      syncInfoCustomerPage(method: WindowsMethodEnum.paymentMethod);
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

  PaymentMethod? getPaymentMethodSelected() => state.paymentMethodSelected;

  Future<String?> removeCoupon(
    CustomerPolicyModel coupon, {
    bool applyPolicy = true,
    bool loadingApplyPolicy = true,
  }) async {
    try {
      if (state.orderSelect == null) return S.current.noOrderSelect;
      updateEvent(HomeEvent.removeCoupon);
      final result = await _couponRepository.deleteCoupon(
          idCode: coupon.id, order: state.orderSelect!);
      updateEvent(null);
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
      updateEvent(null);
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

      final productsRepo = await _productRepository.getProduct(null);
      await LocalStorage.setLastReloadMenu();
      List<ProductModel> products = List.from(productsRepo.data.data ?? []);
      List<dynamic> menuCategoryItem = [];

      if (categories.isNotEmpty) {
        var categorySelect = state.categorySelect;

        var checkCategorySelect =
            categories.firstWhereOrNull((e) => e.id == categorySelect?.id);
        if (categorySelect == null || checkCategorySelect == null) {
          changeCategorySelect(categories.first);
          checkCategorySelect = categories.first;
        } else {
          changeCategorySelect(checkCategorySelect);
        }
      } else {
        state = state.copyWith(
          categorySelect: null,
          subCategorySelect: null,
        );
      }

      // cập nhật ngôn ngữ local khi load menu
      kAppLanguageLocal = LocalStorage.getLanguageLocal();
      for (var element in categories) {
        menuCategoryItem.add(element);
        categoryKeys[element] = categoryKeys[element] ?? GlobalKey();
        if ((element.children ?? []).isNotEmpty) {
          menuCategoryItem.add(-1);
        }
        for (var sub in (element.children ?? [])) {
          menuCategoryItem.add(sub);
          categoryKeys[sub] = categoryKeys[sub] ?? GlobalKey();
        }
      }

      state = state.copyWith(
        categories: categories,
        products: products,
        tags: tags,
        menuCategoryItem: menuCategoryItem,
        productsState: const PageState(status: PageCommonState.success),
        tagSelect: tags.firstWhereOrNull((e) => e == state.tagSelect),
      );
      // syncInfoCustomerPage(

      // );
      // syncInfoForCustomer();
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
      final minvoiceInfo = await _invoiceRepository.getMInvoiceTaxInfo(taxCode);
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
      await _invoiceRepository.updateOrderInvoice(
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
      var orderSelect = state.orderSelect;
      if (orderSelect == null) {
        state = state.copyWith(
          orderInvoiceState: const PageState(status: PageCommonState.success),
          invoice: null,
        );
        return;
      }
      final orderInvoice =
          await _invoiceRepository.getOrderInvoice(orderSelect.id);
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

    for (var e in [
      WindowsMethodEnum.paymentMethod,
      WindowsMethodEnum.bank,
      WindowsMethodEnum.price,
    ]) {
      syncInfoCustomerPage(method: e);
    }
    // syncInfoForCustomer();
  }

  Future<bool> unlockOrder({bool loadingHome = true}) async {
    try {
      state = state.copyWith(lockedOrder: true);
      if (loadingHome) updateEvent(HomeEvent.unlockOrder);
      int retry = 0;
      while (retry < 3) {
        try {
          if (state.orderSelect == null) {
            state = state.copyWith(lockedOrder: false);
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

      if (loadingHome) updateEvent(HomeEvent.processed);
      resetPaymentAndBank();
      return true;
    } catch (ex) {
      if (loadingHome) updateEvent(HomeEvent.processError);
      state = state.copyWith(
        messageError:
            "${S.current.failed_payment_closing}\n${S.current.ex_problem}: ${ex.toString()}",
      );
      return false;
    }
  }

  Future<bool> lockOrder({bool loadingHome = true}) async {
    try {
      if (loadingHome) updateEvent(HomeEvent.lockOrder);
      int retry = 0;
      while (retry < 3) {
        try {
          if (state.orderSelect == null) {
            break;
          }
          await _orderRepository.lockOrder(
            orderId: state.orderSelect!.id,
            statusLock: 1,
          );

          break;
        } catch (ex) {
          retry++;
          if (retry >= 3) {
            showLogs(ex, flags: 'ex lockOrder test');
            rethrow;
          }
        }
      }

      if (loadingHome) updateEvent(null);
      return true;
    } catch (ex) {
      if (loadingHome) updateEvent(null);
      state = state.copyWith(
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
    state = state.copyWith(bankSelect: bank);
    // syncInfoForCustomer();
    syncInfoCustomerPage(method: WindowsMethodEnum.bank);
  }

  Future<void> loadBanksInfo() async {
    try {
      state = state.copyWith(
        banksState: const PageState(status: PageCommonState.loading),
        banks: [],
        bankSelect: null,
      );
      syncInfoCustomerPage(method: WindowsMethodEnum.bank);
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
        syncInfoCustomerPage(method: WindowsMethodEnum.bank);
        // syncInfoForCustomer();
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
    for (var e in [
      WindowsMethodEnum.paymentMethod,
      WindowsMethodEnum.bank,
      WindowsMethodEnum.price,
    ]) {
      syncInfoCustomerPage(method: e);
    }
    // syncInfoForCustomer();
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

  void onChangeCustomerPortraitSelect(CustomerPortrait? customerPortrait) {
    state = state.copyWith(customerPortraitSelect: customerPortrait);
  }

  Future<String?> resetCustomer() async {
    try {
      if (state.orderSelect == null) return S.current.noOrderSelect;
      state = state.copyWith(event: HomeEvent.removeCustomer);
      await _customerRepository.resetCustomer(orderId: state.orderSelect!.id);
      state = state.copyWith(event: HomeEvent.normal, customer: null);
      syncInfoCustomerPage(method: WindowsMethodEnum.customer);
      return null;
    } catch (ex) {
      _lockOrder(ex);
      state = state.copyWith(event: HomeEvent.normal);
      return "${S.current.error_remove_customer_order}\n${ex.toString()}";
    }
  }

  /// áp dụng ưu đãi
  ///
  /// [loadingHome] = true - show loading giữa trang
  ///
  /// [requireApply] = false - bắt buộc áp dụng lại
  Future<String?> applyCustomerPolicy({
    bool retry = true,
    bool loadingHome = true,
    bool ignoreGetDataBill = false,
    bool requireApply = false,
  }) async {
    // hiện chưa dùng cái này
    if (!ignoreGetDataBill) getDataBill(loadingHome: loadingHome);
    return null;
    try {
      // có thể data bill chưa được làm mới nên tạm bỏ qua
      // if (state.coupons.isEmpty &&
      //     getFinalPaymentPrice.totalPriceVoucher == 0 &&
      //     state.dataBillState.status == PageCommonState.success) {
      //   showLogs(null, flags: 'k có mã giảm nào');
      //   if (loadingHome) updateEvent(null);
      //   getDataBill();
      //   return null;
      // }
      // showLogs(null, flags: 'apply lại mã có mã giảm nào');
      state = state.copyWith(
        applyPolicyState:
            const PageState(status: PageCommonState.loading, messageError: ''),
      );
      if (loadingHome) state = state.copyWith(event: HomeEvent.applyPolicy);
      if (!requireApply) {
        if (state.coupons.isEmpty) {
          showLogs(null, flags: 'bỏ qua nếu danh sách mã giảm giá trống');
          if (loadingHome) updateEvent(null);
          state = state.copyWith(
            applyPolicyState: const PageState(
                status: PageCommonState.success, messageError: ''),
          );
          if (!ignoreGetDataBill) await getDataBill(loadingHome: loadingHome);
          return null;
        }
      }
      int retryTimes = 0;
      while (retryTimes < (retry ? 3 : 1)) {
        try {
          List<CustomerPolicyModel> couponsApply =
              List<CustomerPolicyModel>.from(state.coupons);

          var productCheckout =
              List<ProductCheckoutModel>.from(state.productCheckout);

          var totalOrder = getFinalPaymentPrice.totalPrice * 1.0;

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

          var result = await _couponRepository.applyPolicy(
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

          // requireApplyPolicy = false;

          state = state.copyWith(
            applyPolicyState: const PageState(
                status: PageCommonState.success, messageError: ''),
          );
          if (loadingHome) updateEvent(null);
          if (!ignoreGetDataBill) await getDataBill(loadingHome: loadingHome);
          // syncInfoForCustomer();
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
      // requireApplyPolicy = true;
      showLogs(ex.toString(), flags: 'áp lại mã giảm giá lỗi');
      _lockOrder(ex);
      if (loadingHome) updateEvent(null);
      state = state.copyWith(
        applyPolicyState: PageState(
            status: PageCommonState.error,
            messageError:
                ex.toString().replaceAll(kIgnoreRetryApplyPolicy, "")),
      );
      if (!ignoreGetDataBill) await getDataBill(loadingHome: loadingHome);
      return ex.toString().replaceAll(kIgnoreRetryApplyPolicy, "");
    }
  }

  /// tạm tính
  Future<
      ({
        HomePaymentError? errorType,
        String msg,
        List<IpOrderModel> tmpPrinters
      })> onPayment(BuildContext context) async {
    List<IpOrderModel> printers = [];
    try {
      updateEvent(HomeEvent.paymentProcess);
      syncInfoCustomerPage(
        method: WindowsMethodEnum.payment,
        arguments: PaymentStatus.loading.type,
      );
      // syncInfoForCustomer(
      //   method: WindowsMethod.payment,
      //   arguments: {
      //     'is_gateway': false,
      //     'gateway_url': '',
      //     'status': PaymentStatus.loading.type,
      //     'qr_code': '',
      //   },
      // );

      int retryTempPayment = 0;
      int timesTempPayment = 3;
      // in tạm tính
      while (retryTempPayment < timesTempPayment) {
        try {
          if (state.orderSelect == null) {
            updateEvent(null);
            return (
              errorType: HomePaymentError.temp,
              msg: S.current.noOrderSelect,
              tmpPrinters: <IpOrderModel>[],
            );
          }
          if (printers.isEmpty) {
            final resultPrinter = await _orderRepository
                .getIpPrinterOrder(state.orderSelect!, [1]);
            if (resultPrinter.error != null) {
              throw resultPrinter.error.toString();
            }
            printers = List.from(resultPrinter.printers);
            try {
              await LocalStorage.saveListPrinters(printers);
            } catch (ex) {
              //
            }
          }

          // Kiểm tra tình trạng máy in
          for (var ipPrinter in printers) {
            var checkPrinterAvailable =
                await AppPrinterCommon.checkPrinter(ipPrinter);
            if (checkPrinterAvailable != null) {
              throw checkPrinterAvailable;
            }
          }

          var price = getFinalPaymentPrice;

          await _orderRepository.payment(
            order: state.orderSelect!,
            infoPrint: printers,
            products: state.productCheckout,
            vouchers: state.coupons,
            // vouchers: state.vouchers,
            createVouchers: state.createVouchers,
            comment: null,
            numberOfAdults: state.numberOfAdults,
            numberOfChildren: state.numberOfChildren,
            note: state.completeNote,
            flagInvoice: !(state.invoice?.isEmpty() ?? true),
            customerRatings: [],
            imageBills: state.imageBills,
            paymentMethod: state.paymentMethodSelected?.key,
            customerPortrait: state.customerPortraitSelect,
            statusPaymentCompleted: state.statusPaymentGateway,
            totalPaymentCompleted: state.statusPaymentGateway
                ? state.totalPaymentGateway
                : price.totalPriceFinal,
          );

          try {
            LocalStorage.deleteNotePerOrderItem(
              order: state.orderSelect!,
            );
          } catch (ex) {
            //
          }

          break;
        } catch (ex) {
          retryTempPayment++;
          if (retryTempPayment >= timesTempPayment) {
            state = state.copyWith(event: HomeEvent.normal);
            return (
              errorType: HomePaymentError.temp,
              msg: ex.toString(),
              tmpPrinters: <IpOrderModel>[],
            );
          }
        }
      }

      // hoàn thành đơn
      var completeStatus = await completeBill(
        loadingHome: false,
        context: context,
        printers: printers,
      );
      syncInfoCustomerPage(
        method: WindowsMethodEnum.payment,
        arguments: PaymentStatus.success.type,
      );
      // syncInfoForCustomer(
      //   method: WindowsMethod.payment,
      //   arguments: {
      //     'is_gateway': false,
      //     'gateway_url': '',
      //     'status': PaymentStatus.success.type,
      //     'qr_code': '',
      //   },
      // );

      if (completeStatus != null) {
        updateEvent(null);
        return (
          errorType: HomePaymentError.complete,
          msg: completeStatus,
          tmpPrinters: printers,
        );
      }
      clearImageBill();

      updateEvent(null);
      return (
        errorType: null,
        msg: '',
        tmpPrinters: printers,
      );
    } catch (ex) {
      updateEvent(null);
      return (
        errorType: HomePaymentError.temp,
        msg: ex.toString(),
        tmpPrinters: <IpOrderModel>[],
      );
    }
  }

  void onChangeKitchenNote(String note) {
    state = state.copyWith(kitchenNote: note);
    // syncInfoForCustomer();
  }

  void onChangeCompleteNote(String note) {
    state = state.copyWith(completeNote: note);
    // syncInfoForCustomer();
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

  // Future<void> syncInfoForCustomer({
  //   WindowsMethod method = WindowsMethod.data,
  //   dynamic arguments,
  // }) async {
  //   if (!Platform.isWindows) return;
  //   if (state.pinnedOrder) return;
  //   return;
  //   var args = arguments ??
  //       {
  //         'all_products': state.products,
  //         'order': state.orderSelect,
  //         'products': state.productCheckout,
  //         'customer': state.customer,
  //         'data_bill': getFinalPaymentPrice.copyWith(
  //             receivedAmount: (state.paymentMethodSelected?.isCash ?? false)
  //                 ? state.cashReceivedAmount
  //                 : 0),
  //         'note': state.kitchenNote,
  //         'payment_method': state.paymentMethodSelected,
  //         'detail_payment': {
  //           'bank_select': state.bankSelect,
  //           'gateway_qr': '',
  //         },
  //       };

  //   final subWindows = await DesktopMultiWindow.getAllSubWindowIds();
  //   for (final id in subWindows) {
  //     DesktopMultiWindow.invokeMethod(id, method.value, jsonEncode(args));
  //   }
  // }

  Future<String?> completeBill({
    required BuildContext context,
    bool loadingHome = true,
    List<IpOrderModel> printers = const [],
    bool printKitchenBill = false,
  }) async {
    try {
      if (loadingHome) updateEvent(HomeEvent.completeBillAgain);

      int retry = 0;
      while (retry < 3) {
        try {
          PriceDataBill price = getFinalPaymentPrice;
          if (state.orderSelect == null) {
            if (loadingHome) updateEvent(null);
            return S.current.noOrderSelect;
          }
          var paymentMethodSelected = state.paymentMethodSelected;
          if (paymentMethodSelected == null) {
            throw 'Chưa chọn phương thức thanh toán';
          }
          await _orderRepository.completeBill(
            order: state.orderSelect!,
            portrait: state.customerPortraitSelect?.key ?? '',
            amountAdult: state.numberOfAdults,
            amountChildren: state.numberOfChildren,
            description: state.completeNote,
            arrMethod: [
              '${paymentMethodSelected.key}--${price.totalPriceFinal}'
            ],
            totalPrice: price.totalPrice,
            totalPriceFinal: price.totalPriceFinal,
            totalPriceTax: price.totalPriceTax,
            totalPriceVoucher: price.totalPriceVoucher,
            eSaleCode: '',
            eSaleName: '',
            isPrintPeople: state.printNumberOfPeople ? 1 : 0,
            // providerCode: state.bankSelect?.code,
          );
          List<LineItemDataBill> productPrint = [];
          for (var e in (state.dataBill.print?.orderLineItems ??
              <LineItemDataBill>[])) {
            productPrint.add(LineItemDataBill(
              name: e.name,
              price: e.price,
              tax: e.tax,
              unit: e.unit,
              count: e.count,
            ));
            if (e.listItem.isNotEmpty) {
              for (var item in e.listItem) {
                productPrint.add(LineItemDataBill(
                  name: ' - ${item.name}',
                  price: '0',
                  tax: '0',
                  unit: '',
                  count: 0,
                ));
              }
            }
          }

          var bytes = await AppPrinterHtmlUtils.instance.getReceptBillContent(
            order: state.orderSelect!,
            price: price,
            receiptType: ReceiptTypeEnum.paymentReceipt,
            paymentMethod: state.paymentMethodSelected,
            paymentAmount: state.statusPaymentGateway
                ? (double.tryParse(
                        (state.totalPaymentGateway ?? 0.0).toString()) ??
                    0.0)
                : price.totalPriceFinal * 1.0,
            numberPrintCompleted: 1,
            numberPrintTemporary: 0,
            orderLineItems: productPrint,
            vouchers: state.dataBill.print?.vouchers ?? [],
            note: state.completeNote,
            printNumberOfPeople: state.printNumberOfPeople,
            customerPhone: state.customer?.phoneNumber ?? '',
            numberOfPeople: state.numberOfAdults,
            cashierCompleted: '',
            cashierPrint: '',
            timeCompleted: null,
            timeCreatedAt: null,
            invoiceQr: AppConfig.useInvoiceQr ? 'https://google.com' : '',
          );

          var check = await AppPrinterCommon.checkPrinters(printers);
          if (check != null) {
            if (loadingHome) updateEvent(null);
            if (context.mounted) {
              await showMessageDialog(context,
                  message: 'Không thể in phiếu thanh toán\n$check');
            }
            return null;
          }

          for (var printer in printers) {
            // try {
            // var check = await AppPrinterCommon.checkPrinter(
            //     IpOrderModel(ip: printer.ip, port: printer.port, type: 1));
            // if (check != null) {
            //   throw check;
            // }

            // for (var e in (state.dataBill.print?.orderLineItems ?? <LineItemDataBill>[])) {
            //   productPrint.add(LineItemDataBill(
            //     name: e.name,
            //     price: e.price,
            //     tax: e.tax,
            //     unit: e.unit,
            //     count: e.count,
            //   ));
            //   if (e.listItem.isNotEmpty) {
            //     for (var item in e.listItem) {
            //       productPrint.add(LineItemDataBill(
            //         name: ' - ${item.name}',
            //         price: '0',
            //         tax: '0',
            //         unit: '',
            //         count: 0,
            //       ));
            //     }
            //   }
            // }

            PrintQueue.instance.addTask(
              ip: printer.ip,
              port: printer.port,
              buildReceipt: (generator) async {
                // var bytes = await AppPrinterHtmlUtils.instance.getReceptBillContent(
                //   order: state.orderSelect!,
                //   price: price,
                //   printers: [
                //     IpOrderModel(ip: printer.ip, port: printer.port, type: 1),
                //   ],
                //   receiptType: ReceiptTypeEnum.paymentReceipt,
                //   paymentMethod: state.paymentMethodSelected,
                //   paymentAmount: state.statusPaymentGateway
                //       ? (double.tryParse((state.totalPaymentGateway ?? 0.0).toString()) ?? 0.0)
                //       : price.totalPriceFinal * 1.0,
                //   numberPrintCompleted: 1,
                //   numberPrintTemporary: 0,
                //   orderLineItems: productPrint,
                //   vouchers: state.dataBill.print?.vouchers ?? [],
                //   note: state.completeNote,
                //   printNumberOfPeople: state.printNumberOfPeople,
                //   customerPhone: state.customer?.phoneNumber ?? '',
                //   numberOfPeople: state.numberOfAdults,
                //   cashierCompleted: '',
                //   cashierPrint: '',
                //   timeCompleted: null,
                //   timeCreatedAt: null,
                //   invoiceQr: AppConfig.useInvoiceQr ? 'https://google.com' : '',
                // );
                return bytes;
              },
              onComplete: (success, error) {
                if (success) {
                  showLogs('in thành công', flags: 'BILL THANH TOÁN');
                } else {
                  showLogs('in thất bại $error', flags: 'BILL THANH TOÁN');
                  var homeState = homeKey.currentState;
                  var homeContext = homeKey.currentContext;

                  if (error != null &&
                      homeContext != null &&
                      homeState != null &&
                      homeState.mounted) {
                    showMessageDialog(
                      homeContext,
                      message: 'Không thể in phiếu thanh toán\nSự cố: $error',
                    );
                  }
                }
              },
            );
            // } catch (ex) {
            //   if (loadingHome) updateEvent(null);
            //   //
            //   if (context.mounted) {
            //     await showMessageDialog(context,
            //         message: 'Không thể in phiếu thanh toán\n${ex.toString()}');
            //   }
            //   return null;
            // }
          }
          break;
        } catch (ex) {
          retry++;
          if (retry >= 3) {
            rethrow;
          }
        }
      }
      if (loadingHome) updateEvent(null);
      return null;
    } catch (ex) {
      if (loadingHome) updateEvent(null);
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
      updateEvent(null);
      return null;
    } catch (ex) {
      updateEvent(null);
      return ex.toString();
    }
  }

  void onChangeCashReceivedAmount(double amount) {
    state = state.copyWith(cashReceivedAmount: max(0.0, amount));
    // syncInfoForCustomer();
    syncInfoCustomerPage(method: WindowsMethodEnum.price);
  }

  Future<String?> closeShift(BuildContext context) async {
    try {
      updateEvent(HomeEvent.closingShift);
      var data = await _userRepository.closeShift();
      var printer = data.infoPrint;
      if (printer == null) throw 'Không có thông tin máy in';
      var checkPrinter = await AppPrinterCommon.checkPrinter(printer);
      if (checkPrinter != null) throw checkPrinter;
      updateEvent(HomeEvent.normal);
      var setting = LocalStorage.getPrintSetting();
      bool printNormal =
          setting.appPrinterType == AppPrinterSettingTypeEnum.normal;
      var bytes = printNormal
          ? await AppPrinterNormalUtils.instance.getCloseShift(data)
          : await AppPrinterHtmlUtils.instance.getCloseShiftContent(data);
      PrintQueue.instance.addTask(
        ip: printer.ip,
        port: printer.port,
        buildReceipt: (generator) async {
          return bytes;
        },
        onComplete: (success, error) {
          if (success) {
            showLogs("✅ In thành công");
          } else {
            showLogs("❌ In thất bại");

            if (error != null) {
              showMessageDialog(context, message: error);
            }
          }
        },
      );

      return null;
    } catch (ex) {
      updateEvent(HomeEvent.normal);
      return ex.toString();
    }
  }

  void onChangeAutoScrollProducts(bool value) {
    state = state.copyWith(autoScrollProducts: value);
    syncInfoCustomerPage(method: WindowsMethodEnum.changeOrderProduct);
    // syncInfoForCustomer(
    //   method: WindowsMethod.changeOrderProduct,
    //   arguments: {
    //     'auto_scroll_order_product': state.autoScrollProducts,
    //     'changed_product_id': state.changedProductId,
    //   },
    // );
  }

  void onChangeChangedProductId(int? id) {
    state = state.copyWith(changedProductId: id);
    syncInfoCustomerPage(method: WindowsMethodEnum.changeOrderProduct);
    // syncInfoForCustomer(
    //   method: WindowsMethod.changeOrderProduct,
    //   arguments: {
    //     'auto_scroll_order_product': true,
    //     'changed_product_id': state.changedProductId,
    //   },
    // );
  }

  Future<String?> onUpdateTax(
    List<ProductCheckoutModel> pc, {
    PaymentMethod? paymentMethod,
    bool loadingHome = true,
  }) async {
    try {
      var pm = paymentMethod ?? state.paymentMethodSelected;

      if (pm == null) return null;
      if (loadingHome) updateEvent(HomeEvent.updateTax);
      await _checkOrderSelect();
      if (pm.requireEditTax && pc.any((e) => e.tax == 0)) {
        throw S.current.error_edit_tax;
      }
      await _orderRepository.updateTax(
        order: state.orderSelect!,
        pc: pc,
        paymentMethod: pm,
      );
      requireUpdateDefaultTax = true;
      if (loadingHome) updateEvent(null);
      return null;
    } catch (ex) {
      if (loadingHome) updateEvent(null);
      return ex.toString();
    }
  }

  Future<String?> getDataBill({bool loadingHome = false}) async {
    try {
      if (loadingHome) updateEvent(HomeEvent.getDataBill);
      state = state.copyWith(
          dataBillState: const PageState(status: PageCommonState.loading));
      await _checkOrderSelect();
      final result = await ref
          .read(orderRepositoryProvider)
          .getDataBill(orderId: state.orderSelect!.id);

      var orderLineItems = result.data.orderLineItems;

      var productCheckout =
          List<ProductCheckoutModel>.from(state.productCheckout);

      var length = productCheckout.length;
      for (var i = 0; i < length; i++) {
        var p = orderLineItems
            .firstWhereOrNull((e) => e.id == productCheckout[i].id);
        if (p != null) {
          productCheckout[i] = productCheckout[i].copyWith(
            tax: double.tryParse(p.tax) ?? 0.0,
            codeProduct: p.codeProduct,
          );
        }
      }

      state = state.copyWith(
        dataBill: result.data,
        dataBillState: const PageState(status: PageCommonState.success),
        productCheckout: productCheckout,
      );
      if (loadingHome) updateEvent(null);
      // syncInfoForCustomer();
      syncInfoCustomerPage(method: WindowsMethodEnum.price);
      return null;
    } catch (ex) {
      state = state.copyWith(
        dataBillState: PageState(
          status: PageCommonState.error,
          messageError: ex.toString(),
        ),
      );
      if (loadingHome) updateEvent(null);
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
    }
  }

  void setUnlockOrder() {
    state = state.copyWith(lockedOrder: false);
  }

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
    syncInfoCustomerPage(method: WindowsMethodEnum.language);
    // syncInfoForCustomer(
    //   method: WindowsMethod.language,
    //   arguments: LocalStorage.getCustomerLanguageLocal(),
    // );
  }

  Future<String?> checkPrinter(List<IpOrderModel> printers) async {
    try {
      updateEvent(HomeEvent.checkPrinter);
      var resultCheck = await AppPrinterCommon.checkPrinters(printers);
      updateEvent(null);
      return resultCheck;
    } catch (ex) {
      updateEvent(null);
      return ex.toString();
    }
  }

  void onChangePrintNumberOfPeople() {
    state = state.copyWith(printNumberOfPeople: !state.printNumberOfPeople);
  }

  /// phân bổ lại thuế mặc định nếu đã phân bổ thuế cho đơn Grab, Shopee trước đó
  Future<String?> onUpdateDefaultTax() async {
    if (!requireUpdateDefaultTax) return null;
    if (state.orderSelect == null) return null;
    int retry = 0;
    String? error;

    List<ProductCheckoutModel> pc = [];

    for (var p in state.productCheckout) {
      var pCheck = state.products.firstWhereOrNull((e) => e.id == p.id);
      if (pCheck != null) {
        // check here: check xem tax < 1
        pc.add(p.copyWith(tax: pCheck.tax));
      } else {
        pc.add(p);
      }
    }

    while (retry < 3) {
      try {
        // lấy phương thức tiền mặt để phân bổ lại thuế
        var paymentCheck =
            _listPaymentMethods.firstWhereOrNull((e) => e.isCash);
        error = await onUpdateTax(pc,
            paymentMethod: paymentCheck ??
                const PaymentMethod(
                  key: 25,
                  name: 'Tiền mặt',
                  isCash: true,
                  requireEditTax: false,
                ));
        if (error != null) throw error;
        requireUpdateDefaultTax = false;
        try {
          await getDataBill(loadingHome: true);
        } catch (ex) {
          //
        }
        break;
      } catch (ex) {
        retry++;
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

  void onChangeOrderTabSelect(OrderTabEnum value) {
    state = state.copyWith(orderTabSelect: value);
  }

  void onChangeDisplayOrderHistory(bool? value) {
    state = state.copyWith(
        displayOrderHistory: value ?? !state.displayOrderHistory);
  }

  /// gọi món
  Future<String?> addItemsToOrder(BuildContext context) async {
    var note = LocalStorage.getNotePerOrderItem(
        order: state.orderSelect ?? const OrderModel());

    Set<int> printerCheck = {};

    Map<int, List<ProductModel>> printerMapProducts = {};
    double total = 0.0;
    List<ProductModel> productPrintBill = (state.productsSelecting).map((e) {
      total +=
          (double.tryParse(e.unitPrice) ?? 0.0) * max(0, e.numberSelecting);

      var product =
          e.copyWith(noteForProcessOrder: note?[e.id.toString()] ?? '');
      var comboItems = ProductHelper().getComboDescription(product);
      if (comboItems == null || comboItems.isEmpty) {
        if (product.printerType != null) {
          var items = List<ProductModel>.from(
              printerMapProducts[product.printerType] ?? []);
          // coi combo k có thành phần như là món thường để in
          items.add(product.copyWith(description: null));
          printerMapProducts[product.printerType!] = items;
        }
      } else {
        Map<int, List<ComboItemModel>> printComboItem = {};
        for (var ci in comboItems) {
          var printerType = ci.printerType;
          if (printerType != null) {
            var items =
                List<ComboItemModel>.from(printComboItem[printerType] ?? []);
            items.add(ci);
            printComboItem[printerType] = items;
          }
        }

        printComboItem.forEach(
          (key, value) {
            var items = List<ProductModel>.from(printerMapProducts[key] ?? []);
            items.add(product.copyWith(description: jsonEncode(value)));
            printerMapProducts[key] = items;
          },
        );
      }

      if (product.printerType != null) {
        printerCheck.add(product.printerType!);
      }
      return product;
    }).toList();

    try {
      updateEvent(HomeEvent.processOrder);
      showLogs(printerCheck, flags: 'ds printerType gọi món');
      var listPrinters = await _orderRepository.getIpPrinterOrder(
        state.orderSelect!,
        printerCheck.toList(),
      );
      if (listPrinters.error != null) {
        throw listPrinters.error!;
      }
      showLogs(listPrinters.printers, flags: 'danh sách máy in - gọi món');
      var resultCheck =
          await AppPrinterCommon.checkPrinters(listPrinters.printers);
      showLogs(resultCheck, flags: 'resultCheck');
      if (resultCheck != null) {
        throw resultCheck;
      }
      var kitchenNote = state.kitchenNote;
      await _checkOrderSelect();
      await _orderRepository.processOrder(
        order: state.orderSelect!,
        total: total,
        orderNote: kitchenNote,
        products: productPrintBill,
      );
      try {
        await LocalStorage.deleteNotePerOrderItem(order: state.orderSelect!);
      } catch (ex) {
        //
      }
      state = state.copyWith(
        productsSelecting: [],
        orderTabSelect: OrderTabEnum.ordered,
      );

      try {
        await LocalStorage.setOrderItemSelectingForOrder(
            orderId: state.orderSelect!.id, data: {});
      } catch (ex) {
        //
      }
      // requireApplyPolicy = true;
      // requireGetDataBill = true;
      getOrderProductCheckout(applyPolicy: true);

      state = state.copyWith(kitchenNote: '');
      // sử dụng kds thì k cần in
      if (AppConfig.useKds) {
        updateEvent(HomeEvent.normal);
        return null;
      }

      try {
        var setting = LocalStorage.getPrintSetting();
        bool printNormal =
            setting.appPrinterType == AppPrinterSettingTypeEnum.normal;

        for (var printer in listPrinters.printers) {
          List<ProductModel> productPrinter =
              List<ProductModel>.from(printerMapProducts[printer.type] ?? []);

          if (productPrinter.isEmpty) {
            continue;
          }
          if (kitchenNote.trim().isEmpty && productPrinter.length == 1) {
            kitchenNote = productPrinter.firstOrNull?.noteForProcessOrder ?? '';
          }
          showLogs(productPrinter.length, flags: 'check só lượng món in');
          var bytes = printNormal
              ? await AppPrinterNormalUtils.instance.generateBill(
                  order: state.orderSelect!,
                  billSingle: false,
                  cancel: false,
                  timeOrder: 1,
                  totalNote: kitchenNote,
                  products: productPrinter,
                  title: '',
                )
              : await AppPrinterHtmlUtils.instance.generateImageBill(
                  AppPrinterHtmlUtils.instance.kitchenBillContent(
                  order: state.orderSelect!,
                  product: productPrinter,
                  note: kitchenNote,
                  timeOrders: 1,
                  cancel: false,
                  totalBill: true,
                ));
          List<ProductModel> errors = [];
          PrintQueue.instance.addTask(
            ip: printer.ip,
            port: printer.port,
            buildReceipt: (generator) async {
              return bytes;
            },
            onComplete: (success, error) async {
              if (success) {
                showLogs("✅ In thành công", flags: 'BILL TỔNG');
                // chỉ in bill lẻ với bếp
                String? errorPrintOdd;
                if (printer.type == 2 && setting.billReturnSetting.useOddBill) {
                  for (var item in productPrinter) {
                    List<int> byteDatas;

                    var listComboItemPrint =
                        ProductHelper().getComboDescription(item);

                    if (listComboItemPrint == null ||
                        listComboItemPrint.isEmpty) {
                      // món thường
                      byteDatas = printNormal
                          ? await AppPrinterNormalUtils.instance.generateBill(
                              order: state.orderSelect!,
                              billSingle: true,
                              cancel: false,
                              timeOrder: 1,
                              totalNote: kitchenNote,
                              products: [item],
                              title: '',
                            )
                          : await AppPrinterHtmlUtils.instance
                              .generateImageBill(AppPrinterHtmlUtils.instance
                                  .kitchenBillContent(
                              product: [item],
                              totalBill: false,
                              order: state.orderSelect!,
                              note: kitchenNote,
                              timeOrders: 1,
                            ));
                      PrintQueue.instance.addTask(
                        ip: printer.ip,
                        port: printer.port,
                        buildReceipt: (generator) async {
                          return byteDatas;
                        },
                        onComplete: (success, error) {
                          if (success) {
                            showLogs("✅ In thành công\n$item",
                                flags: 'BILL LẺ');
                          } else {
                            errorPrintOdd = error;
                            errors.add(item);
                            showLogs("❌ In thất bại\n$item", flags: 'BILL LẺ');
                          }
                        },
                      );
                    } else {
                      // in từng món trong combo
                      for (var ci in listComboItemPrint) {
                        byteDatas = printNormal
                            ? await AppPrinterNormalUtils.instance.generateBill(
                                order: state.orderSelect!,
                                billSingle: true,
                                cancel: false,
                                timeOrder: 1,
                                totalNote: kitchenNote,
                                products: [
                                  item.copyWith(description: jsonEncode([ci]))
                                ],
                                title: '',
                              )
                            : await AppPrinterHtmlUtils.instance
                                .generateImageBill(
                                AppPrinterHtmlUtils.instance.kitchenBillContent(
                                  product: [
                                    item.copyWith(description: jsonEncode([ci]))
                                  ],
                                  totalBill: false,
                                  order: state.orderSelect!,
                                  note: kitchenNote,
                                  timeOrders: 1,
                                ),
                              );
                        PrintQueue.instance.addTask(
                          ip: printer.ip,
                          port: printer.port,
                          buildReceipt: (generator) async {
                            return byteDatas;
                          },
                          onComplete: (success, error) {
                            if (success) {
                              showLogs(
                                  "✅ In thành công\n${item.copyWith(description: jsonEncode(ci))}",
                                  flags: 'BILL LẺ');
                            } else {
                              errorPrintOdd = error;
                              errors.add(
                                item.copyWith(
                                  description: jsonEncode([ci]),
                                ),
                              );
                              showLogs(
                                  "❌ In thất bại\n${item.copyWith(description: jsonEncode(ci))}",
                                  flags: 'BILL LẺ');
                            }
                          },
                        );
                      }
                    }
                  }
                  if (errors.isNotEmpty && context.mounted) {
                    showMessageDialog(
                      context,
                      message: "Không thể in bill lẻ xuống bếp\n"
                          '$errorPrintOdd\n'
                          'Danh sách các món không thể ra bill lẻ:\n${errors.map((e) => e.name).join(', ')}',
                    );
                  }
                }
              } else {
                showLogs("❌ In thất bại", flags: 'BILL TỔNG');
                if (error != null && context.mounted) {
                  showMessageDialog(
                    context,
                    message:
                        "Món đã được thêm vào hóa đơn nhưng không thể in bill xuống bếp\n"
                        'Lỗi:\n$error',
                  );
                }
              }
            },
          );
        }

        updateEvent(HomeEvent.normal);
        return null;
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
    } catch (ex) {
      updateEvent(HomeEvent.normal);
      _lockOrder(ex);
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

  void getO2OChatMessages() async {
    try {
      var useO2o = LocalStorage.getDataLogin()?.restaurant?.o2oStatus ?? false;
      if (!useO2o) {
        state = state.copyWith(
          getChatMessageState: const PageState(status: PageCommonState.success),
          chatMessages: [],
        );
        return;
      }
      state = state.copyWith(
        getChatMessageState: const PageState(status: PageCommonState.loading),
      );
      final loginData = LocalStorage.getDataLogin();
      int? restaurantId = loginData?.restaurant?.id;
      final orderSelect = state.orderSelect;
      if (restaurantId == null || orderSelect == null) {
        state = state.copyWith(
          getChatMessageState: PageState(
              status: PageCommonState.error, messageError: S.current.no_data),
        );
        return;
      }

      final messages = await _o2oRepository.getChatMessages(
        restaurantId: restaurantId,
        orderId: orderSelect.id,
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

  // void addCustomerToOrder({
  //   required int orderId,
  //   required String phoneNumber,
  // }) async {
  //   int retry = 0;
  //   if (phoneNumber.trim().isEmpty) return;
  //   while (retry < 3) {
  //     try {
  //       if (state.orderSelect == null) return;
  //       if (state.lockedOrder) return;
  //       await _customerRepository.findCustomer(
  //         phoneNumber: phoneNumber.trim(),
  //         order: state.orderSelect!,
  //       );
  //       break;
  //     } catch (ex) {
  //       _lockOrder(ex);
  //       retry++;
  //     }
  //   }
  // }

  void updateReservation(
    ReservationModel? reservation, {
    bool showLoading = false,
  }) async {
    if (reservation == null) return;
    if (showLoading) updateEvent(HomeEvent.updateReservation);
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
    if (showLoading) updateEvent(null);
  }

  /// Chuyển giao đơn bàn
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

  /// Cập nhật lịch đặt bàn cho đơn bàn
  Future<String?> updateOrderReservation({
    required List<int> tableIds,
    ReservationModel? newReservation,
  }) async {
    try {
      var orderSelect = state.orderSelect;
      if (orderSelect == null) return null;
      updateEvent(HomeEvent.updateOrderReservation);
      await _orderRepository.createAndUpdateOrder(
        tableIds,
        orderSelect,
        reservation: newReservation,
      );
      state = state.copyWith(
        orderSelect: orderSelect.copyWith(reservationCrmId: newReservation?.id),
      );

      updateEvent(null);
      return null;
    } catch (ex) {
      updateEvent(null);
      return ex.toString();
    }
  }

  void onChangeDiscountTypeSelect(DiscountTypeEnum value) {
    state = state.copyWith(discountTypeSelect: value);
  }

  Future<void> syncInfoCustomerPage({
    WindowsMethodEnum method = WindowsMethodEnum.data,
    dynamic arguments,
  }) async {
    if (!Platform.isWindows || state.pinnedOrder) return;

    var args = arguments ?? _tranferDataToCustomerPage(method: method);
    if (args == null) return;
    final subWindows = await DesktopMultiWindow.getAllSubWindowIds();
    for (final id in subWindows) {
      DesktopMultiWindow.invokeMethod(id, method.name, jsonEncode(args));
    }
  }

  Map<String, dynamic> getAllDataToCustomerPage() {
    return {
      'order': state.orderSelect,
      'customer': state.customer,
      'payment_method': state.paymentMethodSelected,
      'price': state.dataBill.price.copyWith(
        receivedAmount: (state.paymentMethodSelected?.isCash ?? false)
            ? state.cashReceivedAmount
            : 0,
      ),
      'bank': state.bankSelect,
      'product': state.productsSelected,
      'auto_scroll': state.autoScrollProducts,
      'change_product_id': state.changedProductId,
    };
  }

  dynamic _tranferDataToCustomerPage(
      {WindowsMethodEnum method = WindowsMethodEnum.data}) {
    switch (method) {
      case WindowsMethodEnum.data:
        return getAllDataToCustomerPage();
      case WindowsMethodEnum.order:
        return state.orderSelect;
      case WindowsMethodEnum.customer:
        return state.customer;
      case WindowsMethodEnum.price:
        return state.dataBill.price.copyWith(
          receivedAmount: (state.paymentMethodSelected?.isCash ?? false)
              ? state.cashReceivedAmount
              : 0,
        );
      case WindowsMethodEnum.paymentMethod:
        return state.paymentMethodSelected;
      case WindowsMethodEnum.productCheckout:
        return state.productsSelected;
      case WindowsMethodEnum.completeNote:
        return state.completeNote;
      case WindowsMethodEnum.kitchenNote:
        return state.kitchenNote;
      case WindowsMethodEnum.bank:
        return state.bankSelect;
      case WindowsMethodEnum.changeOrderProduct:
        return {
          'auto_scroll': state.autoScrollProducts,
          'change_product_id': state.changedProductId,
        };
      default:
        return null;
    }
  }
}

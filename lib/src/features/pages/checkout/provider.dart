import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/const.dart';
import 'package:aladdin_franchise/src/configs/dev_config.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/network/repository/coupon/coupon_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/customer/customer_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/invoice/invoice_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/order/order_repository.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/customer.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/data_bill.dart';
import 'package:aladdin_franchise/src/core/network/repository/restaurant/restaurant_repository.dart';
import 'package:aladdin_franchise/src/data/enum/discount_type.dart';
import 'package:aladdin_franchise/src/data/enum/print_type.dart';
import 'package:aladdin_franchise/src/data/enum/printer_type.dart';
import 'package:aladdin_franchise/src/data/enum/receipt_type.dart';
import 'package:aladdin_franchise/src/data/enum/windows_method.dart';
import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/data/request/payment_receipt_print.dart';
import 'package:aladdin_franchise/src/features/pages/home/components/menu/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/provider.dart';
import 'package:aladdin_franchise/src/features/pages/home/state.dart';
import 'package:aladdin_franchise/src/models/atm_pos.dart';
import 'package:aladdin_franchise/src/models/customer/cusomter_portrait.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';
import 'package:aladdin_franchise/src/models/param_family/bank_param.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/app_printer/app_printer_common.dart';
import 'package:aladdin_franchise/src/utils/app_util.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

final checkoutProvider = StateNotifierProvider.autoDispose<CheckoutNotifier, CheckoutState>((ref) {
  return CheckoutNotifier(
    ref,
    ref.read(orderRepositoryProvider),
    ref.read(invoiceRepositoryProvider),
    ref.read(customerRepositoryProvider),
    ref.read(couponRepositoryProvider),
    ref.read(restaurantRepositoryProvider),
  );
});

class CheckoutNotifier extends StateNotifier<CheckoutState> {
  CheckoutNotifier(
    this.ref,
    this._orderRepository,
    this._invoiceRepository,
    this._customerRepository,
    this._couponRepository,
    this._restaurantRepository,
  ) : super(const CheckoutState()) {
    homeNotifier = ref.read(homeProvider.notifier);
    getProductCheckout();
    getInvoice();
    getDataBill();
  }
  final Ref ref;
  final OrderRepository _orderRepository;
  final InvoiceRepository _invoiceRepository;
  final CustomerRepository _customerRepository;
  final CouponRepository _couponRepository;
  final RestaurantRepository _restaurantRepository;

  late HomeNotifier homeNotifier;
  OrderModel? getOrderSelect() {
    return ref.read(homeProvider).orderSelect;
  }

  double getFinalPrice() {
    return AppUtils.convertToDouble(state.dataBill.price.totalPrice) ?? 0.0;
  }

  void updateEvent([CheckoutEvent? value]) {
    state = state.copyWith(event: value ?? CheckoutEvent.normal);
  }

  void resetInfo() {
    state = state.copyWith(
      productCheckout: [],
      productCheckoutState: const PageState(status: PageCommonState.success),
      customer: null,
      orderHistory: [],
      // invoice
      invoiceState: const PageState(status: PageCommonState.success),
      invoice: null,
      // data bill
      dataBillState: const PageState(status: PageCommonState.success),
      dataBill: const DataBillResponseData(),
      // coupons + voucher
      coupons: [],
      vouchers: [],
      createVouchers: null,
      discountTypeSelect: DiscountTypeEnum.vnd,
      applyPolicyState: const PageState(status: PageCommonState.success),
      //
      numberOfAdults: 1,
      numberOfChildren: 0,

      /// payment
      // payment method
      paymentMethods: [],
      paymentMethodState: const PageState(status: PageCommonState.success),
      paymentMethodSelect: null,
      // banks
      banks: [],
      banksState: const PageState(status: PageCommonState.success),
      bankSelect: null,
      // atm
      listAtmPosState: const PageState(status: PageCommonState.success),
      listAtmPos: [],
      atmPosSelect: null,
      // gateway
      statusPaymentGateway: false,
      totalPaymentGateway: 0.0,
      // cash payment
      cashReceivedAmount: 0,
      // other payment info
      imageBills: [],
      customerPortraitSelect: null,
      completeNote: '',
      printNumberOfPeople: false,
    );
    for (var e in [
      WindowsMethodEnum.data,
      // WindowsMethodEnum.order,
      // WindowsMethodEnum.paymentMethod,
      // WindowsMethodEnum.customer,
      // WindowsMethodEnum.price,
      // WindowsMethodEnum.productCheckout,
      // WindowsMethodEnum.changeOrderProduct,
    ]) {
      homeNotifier.syncInfoCustomerPage(method: e);
    }
  }

  Future<void> getProductCheckout({
    bool showLoading = false,
    bool applyPolicy = false,
    bool retry = false,
  }) async {
    var order = getOrderSelect();

    try {
      if (order == null) {
        resetInfo();
        return;
      }

      if (showLoading) updateEvent(CheckoutEvent.getProductCheckout);
      state =
          state.copyWith(productCheckoutState: const PageState(status: PageCommonState.loading));

      int countRetry = retry ? 3 : 1;

      int count = 0;
      while (count < countRetry) {
        try {
          final response = await _orderRepository.getProductCheckout(order);
          // final pc = List<ProductCheckoutModel>.from(response.data?.firstOrNull?.orderItem ?? []);

          final coupons = List<CustomerPolicyModel>.from(response.coupons ?? []);
          state = state.copyWith(
            productCheckout: response.data?.firstOrNull?.orderItem ?? [],
            productCheckoutState: const PageState(status: PageCommonState.success),
            customer: response.customer,
            numberOfAdults: max(1, response.numberOfAdults),
            orderHistory: response.data?.firstOrNull?.orderHistory ?? [],
            coupons: coupons,
          );
          for (var e in [
            WindowsMethodEnum.customer,
            WindowsMethodEnum.productCheckout,
          ]) {
            homeNotifier.syncInfoCustomerPage(method: e);
          }

          // Future<void> getOrderProductCheckout({
          //   bool loadingHome = false,
          //   bool applyPolicy = true,
          //   bool ignoreGetDataBill = false,
          // }) async {
          //   try {
          //     state = state.copyWith(
          //       productCheckoutState: const PageState(status: PageCommonState.loading),
          //     );
          //     if (loadingHome) updateEvent(HomeEvent.getProductCheckout);

          //     int tryAgain = 0;
          //     while (tryAgain < 3) {
          //       var orderSelect = state.orderSelect;
          //       try {
          //         if (orderSelect == null) {
          //           if (loadingHome) updateEvent(null);
          //           state = state.copyWith(
          //             productCheckoutState: const PageState(status: PageCommonState.success),
          //           );
          //           _resetOrder();
          //           return;
          //         }
          //         final data = await _orderRepository.getProductCheckout(orderSelect);

          //         final pc = List<ProductCheckoutModel>.from(data.data?.first.orderItem ?? []);

          //         final coupons = List<CustomerPolicyModel>.from(data.coupons ?? []);
          //         final customer = data.customer;
          //         var orderHistory = data.data?.first.orderHistory ?? [];
          //         state = state.copyWith(orderHistory: orderHistory);
          //         var notes = LocalStorage.getNotePerOrderItem(order: orderSelect);
          //         List<ProductModel> productsSelected = [];
          //         var products = ref.read(menuProvider).products;
          //         // map: ProductCheckoutModel -> ProductModel
          //         for (var item in pc) {
          //           var p = products.firstWhereOrNull((e) => e.id == item.id);
          //           if (p != null) {
          //             var changeProduct = p.copyWith(
          //               numberSelecting: item.quantity,
          //               note: notes?[p.id.toString()] ?? '',
          //             );
          //             productsSelected.add(changeProduct);
          //           } else {
          //             // case món k có trong menu (k hiện nhưng tiền # 0)
          //             productsSelected.add(
          //               ProductModel(
          //                 id: item.id,
          //                 numberSelecting: item.quantity,
          //                 unitPrice: item.unitPrice,
          //                 name: item.name,
          //                 language: item.language,
          //                 unit: item.unit,
          //                 tax: item.tax,
          //                 printerType: item.printerType,
          //                 note: notes?[item.id.toString()] ?? '',
          //               ),
          //             );
          //           }
          //         }

          //         for (final c in coupons) {
          //           /// cập nhật số lượng món 0 đồng
          //           if (c.isPromotion()) {
          //             final discountUpdate = List<DiscountPolicy>.from(c.discount);

          //             for (int dc = 0; dc < discountUpdate.length; dc++) {
          //               final dcIndex = discountUpdate[dc];

          //               for (final pt in c.promotionItems) {
          //                 if (pt.menuItemId.toString() == dcIndex.id) {
          //                   discountUpdate[dc] = dcIndex.copyWith(numberSelect: pt.quantity);
          //                   // cập nhật số lượng món tặng 0 đồng
          //                   var ps = productsSelected.firstWhereOrNull((e) => e.id == pt.menuItemId);

          //                   if (ps != null) {
          //                     try {
          //                       productsSelected[productsSelected.indexOf(ps)] =
          //                           ps.copyWith(quantityPromotion: ps.quantityPromotion + pt.quantity);
          //                     } catch (ex) {
          //                       //
          //                     }
          //                   }
          //                   var pcout = pc.firstWhereOrNull((e) => e.id == pt.menuItemId);
          //                   if (pcout != null) {
          //                     try {
          //                       pc[pc.indexOf(pcout)] = pcout.copyWith(
          //                           quantityPromotion: (ps?.quantityPromotion ?? 0) + pt.quantity);
          //                     } catch (ex) {
          //                       //
          //                     }
          //                   }
          //                 }
          //               }
          //             }
          //             coupons[coupons.indexOf(c)] = c.copyWith(discount: discountUpdate);
          //           }
          //         }

          //         var productSelectingMap = LocalStorage.getOrderItemSelectingForOrder(orderSelect.id);

          //         List<ProductModel> selecting = [];
          //         var _products = ref.read(menuProvider).products;
          //         productSelectingMap.forEach((key, value) {
          //           var p = _products.firstWhereOrNull((e) => e.id.toString() == key);
          //           if (p != null) {
          //             selecting.add(p.copyWith(numberSelecting: value));
          //           }
          //         });

          //         state = state.copyWith(
          //           coupons: coupons,
          //           customer: customer,
          //           numberOfAdults: max(data.numberOfAdults, 1),
          //           orderHistory: orderHistory,
          //         );
          //         ref.read(checkoutPageProvider.notifier).init(pc);
          //         for (var e in [
          //           WindowsMethodEnum.customer,
          //           WindowsMethodEnum.productCheckout,
          //         ]) {
          //           syncInfoCustomerPage(method: e);
          //         }

          //         state = state.copyWith(
          //             productCheckoutState: const PageState(status: PageCommonState.success));
          //         if (loadingHome) updateEvent(HomeEvent.normal);
          //         if (applyPolicy) {
          //           applyCustomerPolicy(loadingHome: false);
          //         } else {
          //           if (!ignoreGetDataBill) getDataBill();
          //         }
          //         break;
          //       } catch (ex) {
          //         if (ex is AppException && ex.errorCode == 423) {
          //           tryAgain == 3;
          //           state = state.copyWith(lockedOrder: true);
          //         }
          //         tryAgain++;
          //         if (tryAgain >= 3) {
          //           rethrow;
          //         }
          //       }
          //     }
          //   } catch (ex) {
          //     getDataBill();
          //     state = state.copyWith(
          //       productCheckoutState: PageState(
          //         status: PageCommonState.error,
          //         messageError: ex.toString(),
          //       ),
          //     );
          //     if (loadingHome) updateEvent(HomeEvent.normal);
          //   }
          // }
          break;
        } catch (ex) {
          count++;
          if (count >= countRetry) rethrow;
        }
      }
      if (showLoading) updateEvent();
      state =
          state.copyWith(productCheckoutState: const PageState(status: PageCommonState.success));
    } catch (ex) {
      if (showLoading) updateEvent();
      state = state.copyWith(
        productCheckoutState: PageState(
          status: PageCommonState.error,
          messageError: ex.toString(),
        ),
      );
    }
  }

  void getInvoice({bool showLoading = false}) async {
    var order = getOrderSelect();

    try {
      if (order == null) {
        resetInfo();
        return;
      }
      if (showLoading) updateEvent(CheckoutEvent.getInvoice);
      state = state.copyWith(invoiceState: const PageState(status: PageCommonState.loading));

      final result = await _invoiceRepository.getOrderInvoice(order.id);
      if (showLoading) updateEvent();
      state = state.copyWith(
        invoiceState: const PageState(status: PageCommonState.success),
        invoice: result.isEmpty() ? null : result,
      );
    } catch (ex) {
      if (showLoading) updateEvent();
      state = state.copyWith(
        invoiceState: PageState(
          messageError: ex.toString(),
          status: PageCommonState.error,
        ),
      );
    }
  }

  Future<void> getDataBill({
    bool showLoading = false,
    bool retry = false,
  }) async {
    var order = getOrderSelect();

    try {
      if (order == null) {
        resetInfo();
        return;
      }
      if (showLoading) updateEvent(CheckoutEvent.getDataBill);
      state = state.copyWith(dataBillState: const PageState(status: PageCommonState.loading));

      int countRetry = retry ? 3 : 1;

      int count = 0;
      while (count < countRetry) {
        try {
          final result = await _orderRepository.getDataBill(orderId: order.id);

          state = state.copyWith(
            dataBillState: const PageState(status: PageCommonState.success),
            dataBill: result,
          );
          break;
        } catch (ex) {
          count++;
          if (count >= countRetry) rethrow;
        }
      }
      homeNotifier.syncInfoCustomerPage(method: WindowsMethodEnum.price);
      if (showLoading) updateEvent();
    } catch (ex) {
      if (showLoading) updateEvent();
      state = state.copyWith(
        dataBillState: PageState(
          messageError: ex.toString(),
          status: PageCommonState.error,
        ),
      );
    }
  }

  /// lock/ unlock order
  void checkLockOrder(dynamic ex) {
    if (ex is AppException && ex.errorCode == 423) {}
  }

  /// section customer
  Future<FindCustomerStatus> findCustomer(
    String phone, {
    bool showLoading = true,
    bool retry = false,
  }) async {
    try {
      var order = getOrderSelect();
      if (showLoading) updateEvent(CheckoutEvent.findingCustomer);
      if (order == null) {
        throw S.current.noOrderSelect;
      }

      int countRetry = retry ? 3 : 1;
      int count = 0;
      while (count < countRetry) {
        try {
          CustomerResponseData result =
              await _customerRepository.findCustomer(phoneNumber: phone, order: order);
          if (result.customer is List<dynamic> == false) {
            if (showLoading) updateEvent();
            CustomerModel customer = CustomerModel.fromJson(result.customer);
            state = state.copyWith(customer: customer);
            homeNotifier.syncInfoCustomerPage(method: WindowsMethodEnum.customer);
            return FindCustomerStatus.success;
          }
          break;
        } catch (ex) {
          count++;
          if (count >= countRetry) rethrow;
        }
      }
      if (showLoading) updateEvent();
      state = state.copyWith(message: "${S.current.find_customer_not_found} ($phone)");
      return FindCustomerStatus.notFound;
    } catch (ex) {
      checkLockOrder(ex);
      if (showLoading) {
        state = state.copyWith(
          event: CheckoutEvent.normal,
          message: ex.toString(),
        );
      }
      return FindCustomerStatus.error;
    }
  }

  Future<String?> removeCustomer() async {
    try {
      var order = getOrderSelect();
      if (order == null) return S.current.noOrderSelect;
      updateEvent(CheckoutEvent.removeCustomer);
      await _customerRepository.deleteCustomer(order.id);
      state = state.copyWith(event: CheckoutEvent.normal, customer: null);
      homeNotifier.syncInfoCustomerPage(method: WindowsMethodEnum.customer);
      return null;
    } catch (ex) {
      // _lockOrder(ex);
      state = state.copyWith(event: CheckoutEvent.normal);
      return "${S.current.error_remove_customer_order}\n${ex.toString()}";
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
      var order = getOrderSelect();
      if (order == null) return S.current.noOrderSelect;
      updateEvent(CheckoutEvent.createCustomer);
      if (phone.isEmpty ||
          firstName.isEmpty ||
          lastName.isEmpty ||
          (noBOD ? false : birthday.isEmpty)) {
        updateEvent(null);
        return S.current.miss_information;
      }

      var customer = await _customerRepository.createCustomer(
        phone: phone,
        firstName: firstName,
        lastName: lastName,
        birthday: birthday,
        gender: gender,
        order: order,
        idCardNumber: idCardNumber,
        address: address,
      );
      if (customer == null) {
        DevConfig.autoAssignCustomerToOrderAfterCreation = false;
      }
      if (customer != null && DevConfig.autoAssignCustomerToOrderAfterCreation) {
        state = state.copyWith(customer: customer);
        homeNotifier.syncInfoCustomerPage(method: WindowsMethodEnum.customer);
      }
      updateEvent();
      return null;
    } catch (ex) {
      // _lockOrder(ex);
      updateEvent();
      return '${S.current.unable_add_customer}\n${ex.toString()}';
    }
  }

  /// kiểm tra thông tin thanh toán đã là mới nhất
  ({
    String? getProductCheckout,
    String? applyPolicy,
    String? getDataBill,
  }) checkLatestPaymentInfo() {
    String? getProductCheckout, applyPolicy, getDataBill;
    switch (state.productCheckoutState.status) {
      case PageCommonState.loading:
        getProductCheckout =
            'Danh sách món đã gọi đang được đồng bộ. Vui lòng chờ hệ thống cập nhật.';
        break;
      case PageCommonState.error:
        getProductCheckout = 'Danh sách món đã gọi chưa được đồng bộ.';
        break;
      case PageCommonState.success:
        if (state.productCheckout.isEmpty) {
          getProductCheckout = 'Vui lòng gọi món trước khi bấm thanh toán.';
        }
        break;
      default:
    }

    switch (state.dataBillState.status) {
      case PageCommonState.loading:
        getDataBill = 'Hệ thống đang cập nhật thông tin thanh toán, vui lòng đợi trong giây lát.';
        break;
      case PageCommonState.error:
        getDataBill = 'Hệ thống hiện chưa thể lấy thông tin thanh toán. Vui lòng thử lại sau.';
        break;
      default:
    }
    return (
      getProductCheckout: getProductCheckout,
      applyPolicy: applyPolicy,
      getDataBill: getDataBill,
    );
  }

  /// section voucher - tiền giảm hoặc % giảm
  void onChangeDiscountTypeSelect(DiscountTypeEnum value) {
    state = state.copyWith(discountTypeSelect: value);
  }

  Future<({String? error, String? titleError})> addVoucher({
    double value = 0,
    bool showLoading = true,
    DiscountTypeEnum? discountType,
    bool addVoucherToState = true,
  }) async {
    var order = getOrderSelect();

    try {
      if (order == null) {
        resetInfo();
        return (error: S.current.noOrderSelect, titleError: null);
      }
      if (showLoading) updateEvent(CheckoutEvent.addCoupon);
      // if (kDebugMode) {
      //   await Future.delayed(const Duration(seconds: 1));
      //   throw 'test';
      // }
      final result = await _couponRepository.addVoucher(
        order: order,
        totalBill: AppUtils.convertToDouble(state.dataBill.price.totalPrice) ?? 0.0,
        amount: value,
        type: discountType ?? state.discountTypeSelect,
      );

      if (showLoading) updateEvent();
      if (addVoucherToState) {
        state = state.copyWith(
          coupons: [
            CustomerPolicyModel(
              id: result.id,
              name: result.name,
              type: null,
              isType: 3,
              discount: [
                DiscountPolicy(
                  id: null,
                  name: null,
                  // do response trả về lại là số tiền giảm nên type sẽ là DiscountTypeEnum.vnd
                  // getProductCheckout sẽ ghi đè lại thông in mã giảm
                  type: DiscountTypeEnum.vnd.key,
                  amount: result.amount,
                ),
              ],
            ),
            ...state.coupons
          ],
        );
        getProductCheckout();
        getDataBill();
      }
      return (error: null, titleError: null);
    } catch (ex) {
      if (showLoading) updateEvent();
      bool isPercent = state.discountTypeSelect == DiscountTypeEnum.percent;
      return (
        error: ex.toString(),
        titleError: '${S.current.failed_apply_discount_code} '
            '(${isPercent ? AppUtils.getPercentValue(value) : AppUtils.formatCurrency(symbol: '', value: value)} ${isPercent ? '%' : 'đ'})',
      );
    }
  }

  Future<String?> deleteVoucher({
    required CustomerPolicyModel coupon,
    bool showLoading = true,
  }) async {
    try {
      if (showLoading) updateEvent(CheckoutEvent.removeCoupon);
      await _couponRepository.deleteVoucher(coupon.id);
      if (showLoading) updateEvent();
      var coupons = List<CustomerPolicyModel>.from(state.coupons);
      coupons.removeWhere((e) => e.id == coupon.id);
      state = state.copyWith(coupons: coupons);
      getDataBill();
      return null;
    } catch (ex) {
      // _lockOrder(ex);
      if (showLoading) updateEvent();
      return ex.toString();
    }
  }

  // áp dụng lại mã giảm giá (mã giảm nhập số tiền, %)
  // hiện tại chỉ đang cho add 1
  Future<
      ({
        List<CustomerPolicyModel> removeFailed,
        List<CustomerPolicyModel> addFailed,
      })> applyVoucher({
    bool retry = false,
  }) async {
    var coupons = List<CustomerPolicyModel>.from(state.coupons);
    if (coupons.isEmpty) {
      return (removeFailed: <CustomerPolicyModel>[], addFailed: <CustomerPolicyModel>[]);
    } else {
      List<CustomerPolicyModel> _couponsDeleteFailed = [];
      List<CustomerPolicyModel> _couponsAddFailed = [];
      updateEvent(CheckoutEvent.applyPolicy);

      for (var coupon in coupons) {
        try {
          await _couponRepository.deleteVoucher(coupon.id);
          var coupons = List<CustomerPolicyModel>.from(state.coupons);
          coupons.removeWhere((e) => e.id == coupon.id);
          state = state.copyWith(coupons: coupons);
          _couponsAddFailed.add(coupon);
          break;
        } catch (ex) {
          _couponsDeleteFailed.add(coupon);
        }
      }

      /// Mã giảm xoá thành công mà chưa được thêm lại
      List<CustomerPolicyModel> resultCouponsAddFailed = [];
      for (var coupon in _couponsAddFailed) {
        var discount = coupon.discount.firstOrNull;
        if (discount == null) continue;
        // discount.amount là số tiền hoặc % nhập

        var errorAdd = await addVoucher(
          value: AppUtils.convertToDouble(discount.amount) ?? 0.0,
          discountType: discount.type == DiscountTypeEnum.percent.key
              ? DiscountTypeEnum.percent
              : DiscountTypeEnum.vnd,
          showLoading: false,
          addVoucherToState: false,
        );
        if (errorAdd.error != null) {
          resultCouponsAddFailed.add(coupon);
        }
      }
      coupons.removeWhere((e) => resultCouponsAddFailed.contains(e));
      state = state.copyWith(coupons: coupons);
      if (_couponsAddFailed.isNotEmpty) {
        getProductCheckout();
        getDataBill();
      }
      updateEvent();
      return (removeFailed: _couponsDeleteFailed, addFailed: resultCouponsAddFailed);
    }
  }

  /// section coupon - nhập mã giảm giá (theo các NH của Aladdin hiện tại)
  Future<({String? error, String? titleError})> addCoupon({
    required String code,
    bool showLoading = true,
    bool applyPolicy = true,
    bool fetchDataBill = false,
  }) async {
    var order = getOrderSelect();
    try {
      if (order == null) {
        resetInfo();
        return (error: S.current.noOrderSelect, titleError: null);
      }
      var discountCode = code.trim().toLowerCase();
      if (discountCode.isEmpty) {
        return (error: 'Vui lòng nhập mã giảm trước khi xác nhận thêm mã', titleError: null);
      }
      if (state.coupons.any((element) => element.name.trim().toLowerCase() == discountCode)) {
        return (
          error: S.current.discount_code_already_exists,
          titleError: null,
        );
      }
      if (showLoading) updateEvent(CheckoutEvent.addCoupon);

      final couponRepo = await _couponRepository.addCoupon(
        code: discountCode,
        order: order,
        totalOrder: getFinalPrice(),
        numberOfAdults: state.numberOfAdults,
      );

      if (showLoading) updateEvent();
      List<CustomerPolicyModel> coupons = List<CustomerPolicyModel>.from(couponRepo.data);
      if (coupons.isEmpty) {
        final errorMessage = couponRepo.message;
        return (
          titleError:
              errorMessage.isEmpty ? null : "${S.current.discount_code_is_not_valid} ($code)",
          error: errorMessage.isEmpty
              ? "${S.current.discount_code_is_not_valid} ($code)"
              : errorMessage,
        );
      }
      // lấy customer trong coupon nếu có
      CustomerModel? customerCoupon = coupons.firstOrNull?.customer;
      state = state.copyWith(
        coupons: [...coupons, ...state.coupons],
        customer: state.customer ?? customerCoupon,
      );
      if (applyPolicy) await applyCustomerPolicy(fetchDataBill: fetchDataBill);

      return (error: null, titleError: null);
    } catch (ex) {
      if (showLoading) updateEvent();
      return (
        error: ex.toString(),
        titleError: "${S.current.failed_apply_discount_code} ($code)",
      );
    }
  }

  Future<String?> removeCoupon(
    CustomerPolicyModel coupon, {
    bool applyPolicy = true,
    bool showLoading = true,
  }) async {
    var order = getOrderSelect();
    try {
      if (order == null) {
        resetInfo();
        return S.current.noOrderSelect;
      }
      if (showLoading) updateEvent(CheckoutEvent.removeCoupon);
      final result = await _couponRepository.deleteCoupon(idCode: coupon.id, order: order);

      if (showLoading) updateEvent();
      if (result) {
        var coupons = List<CustomerPolicyModel>.from(state.coupons);
        coupons.removeWhere((element) => element.id == coupon.id);
        showLogs(coupon.customer, flags: 'coupon.customer');
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
        showLogs(state.customer, flags: 'state.customer');
        if (applyPolicy) {
          var resultApply = await applyCustomerPolicy(
              showLoading: showLoading, fetchDataBill: true, requireApply: true);
          if (resultApply != null) {
            return 'Áp dụng lại mã giảm giá thất bại\n'
                'Vui lòng bấm "Áp dụng lại"'
                'Sự cố: $resultApply';
          }
        }

        return null;
      }
      return S.current.discount_code_cannot_be_deleted;
    } catch (ex) {
      if (showLoading) updateEvent();
      return ex.toString();
    }
  }

  /// áp dụng mã giảm giá (đối với dùng coupon)
  Future<String?> applyCustomerPolicy({
    bool retry = true,
    bool showLoading = false,
    bool requireApply = false,
    bool fetchDataBill = false,
  }) async {
    var order = getOrderSelect();
    if (order == null) {
      resetInfo();
      return S.current.noOrderSelect;
    }
    if (!requireApply) {
      if (state.coupons.isEmpty &&
          state.dataBill.price.totalPriceVoucher == 0 &&
          state.dataBillState.status == PageCommonState.success) {
        state = state.copyWith(applyPolicyState: const PageState(status: PageCommonState.success));
        return null;
      }
    }

    try {
      state = state.copyWith(applyPolicyState: const PageState(status: PageCommonState.loading));
      if (showLoading) updateEvent(CheckoutEvent.applyPolicy);
      int countRetry = retry ? 3 : 1;

      int count = 0;
      while (count < countRetry) {
        try {
          var result = await _couponRepository.applyCustomerPolicy(
            coupons: state.coupons,
            // chính sách khách hàng?
            customerPolicy: [],
            // trừ đi số lượng món đã tặng để apply cho các mã khác
            products: state.productCheckout,
            // productCheckout.map(
            //   (e) {
            //     return e.copyWith(
            //       quantity: e.getQuantityFinal(),
            //       quantityCancel: 0,
            //     );
            //   },
            // ).toList(),
            order: order,
            customer: state.customer,
            totalOrder: getFinalPrice(),
            pointUseToMoney: 0,
            numberOfAdults: state.numberOfAdults,
          );
          state = state.copyWith(
            vouchers: result.data,
            createVouchers: result.dataCreateVouchers,
          );
          if (showLoading) updateEvent();
          state =
              state.copyWith(applyPolicyState: const PageState(status: PageCommonState.success));
          if (fetchDataBill) getDataBill();
          break;
        } catch (ex) {
          count++;
          if (count >= countRetry) {
            rethrow;
          }
        }
      }
    } catch (ex) {
      if (showLoading) updateEvent();
      state = state.copyWith(applyPolicyState: const PageState(status: PageCommonState.error));
    }

    return null;
  }

  // cancel item
  void changeCancelQuantity(ProductCheckoutModel item) {
    var productsCheckout = List<ProductCheckoutModel>.from(state.productCheckout);

    var index = productsCheckout.indexWhere((e) => e.id == item.id);
    if (index != -1) {
      productsCheckout[index] = item;
    }
    state = state.copyWith(productCheckout: productsCheckout);
  }

  Future<({String? checkPrinters, String? error, String? resultSendPrintData, int? timesOrders})>
      cancelProductCheckout({
    List<ProductCheckoutModel> productCheckout = const [],
    String reason = '',
    Set<PrinterModel> printerSelect = const <PrinterModel>{},
    bool useDefaultPrinter = true,
    bool processOrder = true,
    bool ignorePrint = false,
    int? turn,
  }) async {
    String? checkPrinters;
    String? resultSendPrintData;
    var order = getOrderSelect();
    if (order == null) {
      return (
        checkPrinters: null,
        error: null,
        resultSendPrintData: null,
        timesOrders: null,
      );
    }
    bool showLoading = processOrder || !ignorePrint;
    Set<PrinterModel> printers = <PrinterModel>{};
    Set<ProductModel> foods = <ProductModel>{}, drinks = <ProductModel>{};
    Set<ProductModel> productPrint = {};
    Set<PrinterModel> foodPrinterDefault = <PrinterModel>{}, barPrinterDefault = <PrinterModel>{};
    int? timesOrders = turn;
    try {
      if (showLoading) {
        ref
            .read(homeProvider.notifier)
            .updateEvent(processOrder ? HomeEvent.cancelProductsCheckout : HomeEvent.sendPrintData);
      }
      if (!ignorePrint) {
        var menu = ref.read(menuProvider);
        for (var item in printerSelect) {
          switch (item.type) {
            case ProductPrinterType.drink:
              barPrinterDefault.add(item);
              break;
            case ProductPrinterType.food:
              foodPrinterDefault.add(item);
              break;
          }
        }
        for (var item in productCheckout) {
          var p = menu.products.firstWhereOrNull((e) => e.id == item.id);
          if (p != null) {
            var _product = p.copyWith(
              numberSelecting: item.quantityCancel,
              unitPrice: item.unitPrice,
            );
            productPrint.add(_product);
            switch (p.printerType) {
              case ProductPrinterType.drink:
                drinks.add(_product);
                break;
              case ProductPrinterType.food:
                foods.add(_product);
                break;
            }
          } else {
            var pChange = ProductModel(
              id: item.id,
              printerType: item.printerType,
              name: item.name,
              unit: item.unit,
              unitPrice: item.unitPrice,
              numberSelecting: item.quantityCancel,
            );
            productPrint.add(pChange);
            switch (item.printerType) {
              case ProductPrinterType.drink:
                drinks.add(pChange);
                break;
              case ProductPrinterType.food:
                foods.add(pChange);
                break;
            }
          }
        }
        if (useDefaultPrinter) {
          if (drinks.isNotEmpty) {
            printers.addAll(barPrinterDefault);
          }
          if (foods.isNotEmpty) {
            printers.addAll(foodPrinterDefault);
          }
        } else {
          printers = Set<PrinterModel>.from(printerSelect);
        }

        checkPrinters = await AppPrinterCommon.checkListPrintersStatus(printers.toList());
        if (checkPrinters != null) throw checkPrinters;
      }
      if (processOrder) {
        var res = await _orderRepository.processOrderItem(
          order: order,
          total: 0,
          note: reason,
          cancel: true,
          productCheckout: productCheckout,
        );

        var map = {for (var e in state.productCheckout) e.id: e};
        for (final item in productCheckout) {
          var id = item.id;
          var pc = map[id];
          if (pc != null) {
            final remain = item.quantity - item.quantityCancel;
            if (remain > 0) {
              map[id] = pc.copyWith(quantity: remain, quantityCancel: 0);
            } else {
              map.remove(id);
            }
          }
        }
        state = state.copyWith(productCheckout: map.values.map((e) => e).toList());
        timesOrders = res.timesOrder;
        var checkoutNotifier = ref.read(checkoutProvider.notifier);
        // check code xem xét có cần gọi applyCustomerPolicy k
        try {
          checkoutNotifier.getProductCheckout();
          checkoutNotifier.getDataBill();
        } catch (ex) {
          //
        }
      }
      if (!ignorePrint) {
        if (useDefaultPrinter) {
          if (drinks.isNotEmpty) {
            resultSendPrintData = await ref.read(homeProvider.notifier).sendPrintData(
                  type: PrintTypeEnum.cancel,
                  note: reason,
                  products: drinks.toList(),
                  printers: barPrinterDefault.toList(),
                  timeOrder: timesOrders,
                  printDirectly: !processOrder,
                  useDefaultPrinters: true,
                  totalBill: true,
                );
          }
          if (foods.isNotEmpty) {
            resultSendPrintData = await ref.read(homeProvider.notifier).sendPrintData(
                  type: PrintTypeEnum.cancel,
                  note: reason,
                  products: foods.toList(),
                  printers: foodPrinterDefault.toList(),
                  timeOrder: timesOrders,
                  printDirectly: !processOrder,
                  useDefaultPrinters: true,
                  totalBill: true,
                );
          }
        } else {
          resultSendPrintData = await ref.read(homeProvider.notifier).sendPrintData(
                type: PrintTypeEnum.cancel,
                note: reason,
                products: productPrint.toList(),
                printers: printerSelect.toList(),
                timeOrder: timesOrders,
                printDirectly: !processOrder,
                useDefaultPrinters: false,
                totalBill: true,
              );
        }
      }
      if (showLoading) ref.read(homeProvider.notifier).updateEvent(HomeEvent.normal);

      return (
        checkPrinters: checkPrinters,
        error: null,
        resultSendPrintData: resultSendPrintData,
        timesOrders: timesOrders,
      );
    } catch (ex) {
      if (showLoading) ref.read(homeProvider.notifier).updateEvent(HomeEvent.normal);

      return (
        checkPrinters: checkPrinters,
        error: ex.toString(),
        resultSendPrintData: resultSendPrintData,
        timesOrders: timesOrders,
      );
    }
  }

  /// section invoice
  Future<bool> onUpdateOrderInvoice(
    OrderInvoice invoice, {
    bool isUpdate = false,
  }) async {
    try {
      updateEvent(isUpdate ? CheckoutEvent.updateInvoice : CheckoutEvent.insertInvoice);
      var order = getOrderSelect();
      if (order == null) throw S.current.noOrderSelect;
      await _invoiceRepository.updateOrderInvoice(
        orderId: order.id,
        orderInvoice: invoice,
      );

      state = state.copyWith(
        event: CheckoutEvent.processed,
        invoice: invoice,
      );
      return true;
    } catch (ex) {
      // _lockOrder(ex);
      state = state.copyWith(
        event: CheckoutEvent.processError,
        message: ex.toString(),
      );
      return false;
    }
  }

  /// section payment
  void onChangeCustomerPortraitSelect(CustomerPortrait? customerPortrait) {
    state = state.copyWith(customerPortraitSelect: customerPortrait);
  }

  // payment images
  //  update trùng sẽ xoá
  void updateImageBill(File image) {
    var order = getOrderSelect();
    if (order == null) return;
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

  void resetPaymentInfo() {
    state = state.copyWith(
      paymentMethodSelect: null,
      bankSelect: null,
      atmPosSelect: null,
      statusPaymentGateway: false,
      totalPaymentGateway: 0.0,
      cashReceivedAmount: 0,
      imageBills: [],
      customerPortraitSelect: null,
      completeNote: '',
      printNumberOfPeople: false,
    );
    //   for (var e in [
    //     WindowsMethodEnum.paymentMethod,
    //     WindowsMethodEnum.bank,
    //     WindowsMethodEnum.price,
    //   ]) {
    //     syncInfoCustomerPage(method: e);
    //   }
  }

  void onChangePrintNumberOfPeople() {
    state = state.copyWith(printNumberOfPeople: !state.printNumberOfPeople);
  }

  // section tax

  Future<String?> onUpdateTax(
    Map<int, double> taxMap, {
    PaymentMethod? paymentMethod,
    bool loadingHome = true,
  }) async {
    var order = getOrderSelect();
    if (order == null) {
      return S.current.noOrderSelect;
    }
    try {
      if (loadingHome) updateEvent(CheckoutEvent.updateTax);
      await _orderRepository.updateTax(
        order: order,
        taxMap: taxMap,
      );
      if (loadingHome) updateEvent();
      return null;
    } catch (ex) {
      if (loadingHome) updateEvent(null);
      return ex.toString();
    }
  }

  /// kiểm tra thuế
  /// - ĐK in bill
  ///   + Grab, Shopee (requireEditTax = true): có món thuế = 0 -> k được in bill
  ///   + các PTTT khác:
  ///     + Được in bill nếu các món thuế = 0 là món có cấu hình “Món được phép sửa thuế”
  ///     + Không được in bill nếu có các món thuế 0 và khác 0
  String? checkTaxOrderItem({
    required PaymentMethod paymentMethod,
    required List<LineItemDataBill> orderLineItems,
  }) {
    var products = ref.read(menuProvider).products;
    Set<LineItemDataBill> zeroTaxs = {};
    Set<LineItemDataBill> allowChangeTaxs = {};
    Set<LineItemDataBill> notZeroTaxs = {};
    for (var item in orderLineItems) {
      if (item.isChangeTax == 1) {
        allowChangeTaxs.add(item);
      }
      if (AppUtils.convertToDouble(item.tax) == 0) {
        zeroTaxs.add(item);
      } else {
        notZeroTaxs.add(item);
      }
    }

    bool check = isSameTaxType(productCheckout: state.productCheckout);
    if (!check) {
      return 'Các món đã chọn có cả 0% và có thuế, không thể thanh toán chung.';
    }

    /// PTTT Grab, Shopee (cấu hình requireEditTax = true)
    if (paymentMethod.requireEditTax) {
      // phải chọn các món thuế gốc = 0
      // nếu thuế món gốc của món
      if (zeroTaxs.isNotEmpty) {
        return 'Đơn bàn có các món thuế 0 nên không được phép hoàn thành đơn\n'
            'Vui lòng xóa các món không phù hợp hoặc chọn hình thức thanh toán khác để tiếp tục thanh toán';
      }
    } else {
      // các PTTT khác
      // phải chọn các món thuế gốc != 0
      //  Không được in bill nếu có các món thuế 0 và khác 0
      if (zeroTaxs.isNotEmpty && notZeroTaxs.isNotEmpty) {
        return 'Đơn bàn đang có đồng thời cả các món thuế 0 và khác 0 nên không được phép hoàn thành đơn';
        //  Được in bill nếu các món thuế = 0 là món có cấu hình “Món được phép sửa thuế”
      } else if (zeroTaxs.isNotEmpty) {
        if (allowChangeTaxs.isEmpty) {
          return 'Hình thức thanh toán không hợp lệ do danh sách món không đáp ứng điều kiện thanh toán.';
        } else if (!allowChangeTaxs.containsAll(zeroTaxs)) {
          return 'Đơn bàn không thể hoàn thành vì có món thuế 0 không được phép sửa.\n'
              'Hệ thống chỉ cho phép hoàn thành đơn khi tất cả món thuế 0 (sau khi sửa)'
              ' đều thuộc nhóm được cấu hình cho phép sửa thuế.';
        }
      }
    }
    return null;
  }

  bool isSameTaxType({
    PaymentMethod? paymentMethod,
    List<ProductModel> productSelect = const [],
    List<ProductCheckoutModel> productCheckout = const [],
  }) {
    bool valid = true;
    // if (paymentMethod == null) {
    // check cùng 1 kiểu thuế
    if (productSelect.isNotEmpty) {
      var firstTax = productSelect.firstOrNull?.tax ?? 1.0;
      for (var item in productSelect) {
        valid = (item.tax == 0) == (firstTax == 0);
        if (!valid) return false;
      }
      return true;
    } else if (productCheckout.isNotEmpty) {
      var firstTax = productCheckout.firstOrNull?.tax ?? 1.0;
      for (var item in productCheckout) {
        valid = (item.tax == 0) == (firstTax == 0);
        if (!valid) return false;
      }
      return true;
    }
    // } else {
    //   // check theo hình thức thanh toán
    //   // nếu
    // }
    return false;
  }
  // section payment

  void onChangeCashReceivedAmount(double amount) {
    state = state.copyWith(cashReceivedAmount: max(0.0, amount));
    // syncInfoCustomerPage(method: WindowsMethodEnum.price);
  }

  void getPaymentMethods() async {
    try {
      state = state.copyWith(
        paymentMethodState: const PageState(status: PageCommonState.loading),
        paymentMethodSelect: null,
        paymentMethods: [],
      );
      var order = getOrderSelect();
      if (order == null) {
        throw S.current.noOrderSelect;
      }
      // syncInfoCustomerPage(method: WindowsMethodEnum.paymentMethod);
      final result = await _restaurantRepository.getPaymentMethod(orderId: order.id);

      state = state.copyWith(
        paymentMethodState: const PageState(status: PageCommonState.success),
        paymentMethods: result,
      );
    } catch (ex) {
      state = state.copyWith(
        paymentMethodState: PageState(
          status: PageCommonState.error,
          messageError: ex.toString(),
        ),
      );
    }
  }

  void onChangePaymentMethodSelect(PaymentMethod? value) {
    state = state.copyWith(
      paymentMethodSelect: value,
      statusPaymentGateway: false,
      totalPaymentGateway: 0.0,
      cashReceivedAmount: 0,
      bankSelect: null,
      atmPosSelect: null,
    );

    //   for (var e in [
    //     WindowsMethodEnum.paymentMethod,
    //     WindowsMethodEnum.bank,
    //     WindowsMethodEnum.price,
    //   ]) {
    //     syncInfoCustomerPage(method: e);
    //   }
  }

  Future<void> getBanks() async {
    try {
      state = state.copyWith(
        banksState: const PageState(status: PageCommonState.loading),
        banks: [],
        bankSelect: null,
      );
      // syncInfoCustomerPage(method: WindowsMethodEnum.bank);
      var order = getOrderSelect();
      if (order == null) {
        throw S.current.noOrderSelect;
      }
      final apiBankParam = ApiBankParam(state.dataBill.order, state.dataBill.price.totalPriceFinal);
      final paymentMethodSelect = state.paymentMethodSelect;
      final result = await _restaurantRepository.getBanks(apiBankParam);

      var bankView = List<UserBankModel>.from(result);
      // Loại bỏ những bank không hỗ trợ PTTT
      bankView.removeWhere(
          (element) => element.listPaymentId.contains(paymentMethodSelect?.key) == false);

      if (bankView.length == 1) {
        state = state.copyWith(bankSelect: bankView.first);
        // syncInfoCustomerPage(method: WindowsMethodEnum.bank);
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

  void onChangeBankSelect(UserBankModel? bank) {
    state = state.copyWith(bankSelect: bank);
    // syncInfoCustomerPage(method: WindowsMethodEnum.bank);
  }

  Future<void> getAtmPos() async {
    try {
      state = state.copyWith(
        listAtmPosState: const PageState(status: PageCommonState.loading),
        atmPosSelect: null,
        listAtmPos: [],
      );
      var order = getOrderSelect();
      if (order == null) {
        throw S.current.noOrderSelect;
      }
      final result = await _restaurantRepository.getListAtmPos(
        orderId: order.id,
        totalBill: state.dataBill.price.totalPriceFinal,
      );

      state = state.copyWith(
        listAtmPosState: const PageState(status: PageCommonState.success),
        listAtmPos: result,
      );
    } catch (ex) {
      state = state.copyWith(
        listAtmPosState: PageState(
          status: PageCommonState.error,
          messageError: ex.toString(),
        ),
      );
    }
  }

  void onChangeAtmPosSelect(AtmPosModel? value) {
    state = state.copyWith(atmPosSelect: value);
  }

  void onChangeNumberOfPeople({
    int? numberOfAdults,
    int? numberOfChildren,
  }) {
    state = state.copyWith(
      numberOfAdults: numberOfAdults ?? state.numberOfAdults,
      numberOfChildren: numberOfChildren ?? state.numberOfChildren,
    );
  }

  void onChangeCompleteNote(String note) {
    state = state.copyWith(completeNote: note);
  }

  /// tạm tính
  Future<
      ({
        HomePaymentError? errorType,
        String msg,
        List<IpOrderModel> tmpPrinters,
        PaymentReceiptPrintRequest? requestPrint,
      })> onPayment(BuildContext context) async {
    List<IpOrderModel> printers = [];
    try {
      updateEvent(CheckoutEvent.paymentProcess);
      // syncInfoCustomerPage(
      //   method: WindowsMethodEnum.payment,
      //   arguments: PaymentStatusEnum.loading.name,
      // );

      int retryTempPayment = 0;
      int timesTempPayment = 3;
      // in tạm tính
      while (retryTempPayment < timesTempPayment) {
        try {
          var order = getOrderSelect();
          if (order == null) {
            updateEvent();
            // syncInfoCustomerPage(
            //   method: WindowsMethodEnum.payment,
            //   arguments: PaymentStatusEnum.cancel.name,
            // );
            return (
              errorType: HomePaymentError.temp,
              msg: S.current.noOrderSelect,
              tmpPrinters: <IpOrderModel>[],
              requestPrint: null,
            );
          }

          if (printers.isEmpty) {
            final resultPrinter = await _orderRepository.getPrinterBill(order, [1]);

            printers = List.from(resultPrinter);
          }

          // // Kiểm tra tình trạng máy in
          for (var ipPrinter in printers) {
            var checkPrinterAvailable = await AppPrinterCommon.checkPrinter(ipPrinter);
            if (checkPrinterAvailable != null) {
              throw checkPrinterAvailable;
            }
          }

          var price = state.dataBill.price;

          await _orderRepository.payment(
            order: order,
            infoPrint: printers,
            products: state.productCheckout,
            vouchers: state.coupons,
            createVouchers: state.createVouchers,
            comment: null,
            numberOfAdults: state.numberOfAdults,
            numberOfChildren: state.numberOfChildren,
            note: state.completeNote,
            flagInvoice: !(state.invoice?.isEmpty() ?? true),
            customerRatings: [],
            imageBills: state.imageBills,
            paymentMethod: state.paymentMethodSelect?.key,
            customerPortrait: state.customerPortraitSelect,
            statusPaymentCompleted: state.statusPaymentGateway,
            totalPaymentCompleted:
                state.statusPaymentGateway ? state.totalPaymentGateway : price.totalPriceFinal,
          );

          // try {
          //   LocalStorage.deleteNotePerOrderItem(
          //     order: state.orderSelect!,
          //   );
          // } catch (ex) {
          //   //
          // }

          break;
        } catch (ex) {
          retryTempPayment++;
          if (retryTempPayment >= timesTempPayment) {
            updateEvent();
            // syncInfoCustomerPage(
            //   method: WindowsMethodEnum.payment,
            //   arguments: PaymentStatusEnum.cancel.name,
            // );
            return (
              errorType: HomePaymentError.temp,
              msg: ex.toString(),
              tmpPrinters: <IpOrderModel>[],
              requestPrint: null,
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
      // syncInfoCustomerPage(
      //   method: WindowsMethodEnum.payment,
      //   arguments: PaymentStatusEnum.success.name,
      // );

      if (completeStatus.error != null) {
        updateEvent();
        return (
          errorType: HomePaymentError.complete,
          msg: completeStatus.error!,
          tmpPrinters: printers,
          requestPrint: completeStatus.requestPrint,
        );
      }
      clearImageBill();
      if (completeStatus.errorSendPrint != null) {
        updateEvent();
        return (
          errorType: HomePaymentError.printCompleteError,
          msg: completeStatus.errorSendPrint!,
          tmpPrinters: printers,
          requestPrint: completeStatus.requestPrint,
        );
      }
      updateEvent();
      return (
        errorType: null,
        msg: '',
        tmpPrinters: printers,
        requestPrint: null,
      );
    } catch (ex) {
      updateEvent();
      return (
        errorType: HomePaymentError.temp,
        msg: ex.toString(),
        tmpPrinters: <IpOrderModel>[],
        requestPrint: null,
      );
    }
  }

  Future<
      ({
        String? error,
        String? errorSendPrint,
        PaymentReceiptPrintRequest? requestPrint,
      })> completeBill({
    required BuildContext context,
    bool loadingHome = true,
    List<IpOrderModel> printers = const [],
    bool printKitchenBill = false,
  }) async {
    try {
      PaymentReceiptPrintRequest? requestPrint;
      String? errorSendPrint;
      if (loadingHome) updateEvent(CheckoutEvent.completeBillAgain);

      int retry = 0;
      while (retry < 3) {
        try {
          PriceDataBill price = state.dataBill.price;
          var order = getOrderSelect();
          if (order == null) {
            if (loadingHome) updateEvent();
            return (error: S.current.noOrderSelect, errorSendPrint: null, requestPrint: null);
          }
          var paymentMethodSelect = state.paymentMethodSelect;
          if (paymentMethodSelect == null) {
            throw 'Chưa chọn phương thức thanh toán';
          }
          var result = await _orderRepository.completeBill(
            order: order,
            portrait: state.customerPortraitSelect?.key ?? '',
            amountAdult: state.numberOfAdults,
            amountChildren: state.numberOfChildren,
            description: state.completeNote,
            arrMethod: ['${paymentMethodSelect.key}--${price.totalPriceFinal}'],
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
          for (var e in (state.dataBill.print?.orderLineItems ?? <LineItemDataBill>[])) {
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
          requestPrint = PaymentReceiptPrintRequest(
            order: order,
            price: price,
            receiptType: ReceiptTypeEnum.paymentReceipt,
            paymentMethod: state.paymentMethodSelect,
            paymentAmount: state.statusPaymentGateway
                ? (double.tryParse((state.totalPaymentGateway ?? 0.0).toString()) ?? 0.0)
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
            timeCompleted: DateTime.now(),
            timeCreatedAt: null,
            invoiceQr: result ?? '',
          );

          try {
            errorSendPrint = await ref.read(homeProvider.notifier).sendPrintData(
                  type: PrintTypeEnum.payment,
                  paymentData: requestPrint,
                  printers: printers
                      .map(
                        (e) => PrinterModel(
                            ip: e.ip,
                            port: e.port,
                            name: e.name,
                            type: e.type,
                            typeAreaLocation: e.typeAreaLocation),
                      )
                      .toList(),
                );
          } catch (ex) {
            errorSendPrint = ex.toString();
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
      return (error: null, errorSendPrint: errorSendPrint, requestPrint: requestPrint);
    } catch (ex) {
      if (loadingHome) updateEvent(null);
      return (error: ex.toString(), errorSendPrint: null, requestPrint: null);
    }
  }

  /// cà thẻ động
  Future<String?> dynamicAtmPosCallback() async {
    try {
      updateEvent(CheckoutEvent.dynamicPosCallback);
      if (state.atmPosSelect == null) {
        throw S.current.no_select_pos_machine;
      }
      if (kDebugMode) {
        await Future.delayed(const Duration(seconds: 1));
        // throw '12133';
        updateEvent();
        return null;
      }
      await _restaurantRepository.atmPosCallback(
        orderId: state.dataBill.price.totalPriceFinal,
        urlPos: state.atmPosSelect!.url,
      );
      updateEvent();
      return null;
    } catch (ex) {
      updateEvent();
      return ex.toString();
    }
  }

  Future<({String? url, String? qr, int? expiryMin, String? error, int? statusCode})>
      getPaymentGateway() async {
    String? url, qr, error;
    int? statusCode;
    int? expiryMin;
    try {
      updateEvent(CheckoutEvent.getPaymentGateway);
      final apiBankParam = ApiBankParam(state.dataBill.order, state.dataBill.price.totalPriceFinal);

      final paymentMethodSelect = state.paymentMethodSelect;
      if (paymentMethodSelect == null) {
        throw S.current.payment_method_not_select;
      }
      final result = await _restaurantRepository.getPayooPaymentGateway(
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
    updateEvent();
    return (
      url: url,
      qr: qr,
      expiryMin: expiryMin,
      error: error,
      statusCode: statusCode,
    );
  }

  void updatePaymentGatewayInfo({
    bool? status,
    dynamic amount,
    bool usePriceDataBillForAmount = false,
  }) {
    showLog(
        'status: ${status}, amount: ${amount}, usePriceDataBillForAmount: ${usePriceDataBillForAmount}',
        flags: 'state updatePaymentGatewayInfo data change');
    showLogs(null, flags: 'state updatePaymentGatewayInfo before');
    showLog(state.statusPaymentGateway, flags: 'statusPaymentGateway');
    showLog(state.totalPaymentGateway, flags: 'totalPaymentGateway');
    state = state.copyWith(
      statusPaymentGateway: status ?? state.statusPaymentGateway,
      totalPaymentGateway: usePriceDataBillForAmount
          ? (AppUtils.convertToDouble(state.dataBill.price.totalPriceFinal) ?? 0.0)
          : amount ?? state.totalPaymentGateway,
    );
    showLogs(null, flags: 'state updatePaymentGatewayInfo after');
    showLog(state.statusPaymentGateway, flags: 'statusPaymentGateway');
    showLog(state.totalPaymentGateway, flags: 'totalPaymentGateway');
  }
}

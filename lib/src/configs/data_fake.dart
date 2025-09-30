import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/core/network/responses/data_bill.dart';
import 'package:aladdin_franchise/src/core/network/responses/product_checkout.dart';
import 'package:aladdin_franchise/src/models/atm_pos.dart';
import 'package:aladdin_franchise/src/models/category.dart';
import 'package:aladdin_franchise/src/models/customer/customer.dart';
import 'package:aladdin_franchise/src/models/customer/customer_policy.dart';
import 'package:aladdin_franchise/src/models/data_bill.dart';
import 'package:aladdin_franchise/src/models/employee_sale.dart';
import 'package:aladdin_franchise/src/models/ip_order.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:aladdin_franchise/src/models/order_invoice/order_invoice.dart';
import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/table.dart';
import 'package:aladdin_franchise/src/models/user_bank.dart';
import 'package:aladdin_franchise/src/models/waiter.dart';
import 'package:collection/collection.dart';

bool useDataFake = false;

Future<void> delayFunc({int? second}) async {
  await Future.delayed(Duration(seconds: second ?? 1));
}

List<EmployeeSaleModel> kSales = [
  ...List.generate(
    10,
    (index) => EmployeeSaleModel(
      employeeCode: 'employee-${index + 1}',
      fullName: 'employee-${index + 1}',
      isOnline: 2,
    ),
  ),
  ...List.generate(
    10,
    (index) => EmployeeSaleModel(
      employeeCode: 'employee-${index + 11}',
      fullName: 'employee-${index + 11}-off',
      isOnline: 1,
    ),
  ),
];

List<PaymentMethod> kPaymentMethods = [
  PaymentMethod(
    key: 25,
    name: 'Tiền mặt',
    isCash: true,
  ),
  PaymentMethod(
    key: 1,
    name: 'Chuyển khoản',
    isBank: true,
  ),
  PaymentMethod(
    key: 2,
    name: 'Chuyển khoản - lây hđ',
    isBank: true,
    isVat: true,
  ),
  PaymentMethod(
    key: 3,
    name: 'ATM',
    isAtm: true,
  ),
  PaymentMethod(
    key: 4,
    name: 'Grab',
    requireEditTax: true,
  ),
  PaymentMethod(
    key: 5,
    name: 'Shopee',
    requireEditTax: true,
  ),
  PaymentMethod(
    key: 6,
    name: 'Payoo',
    isGateway: true,
  ),
  PaymentMethod(
    key: 7,
    name: 'Nợ',
  ),
];
List<AtmPosModel> kAtmPos = [
  AtmPosModel(
      id: 1,
      name: 'Máy pos - setting 1',
      setting: 1,
      url: 'https://google.com'),
  AtmPosModel(
      id: 2,
      name: 'Máy pos - setting 2',
      setting: 2,
      url: 'https://google.com'),
];
List<CategoryModel> kCategories = [
  CategoryModel(
    id: 1,
    title: 'Cơm niêu',
  ),
  CategoryModel(
    id: 2,
    title: 'Dimsum',
  ),
  CategoryModel(
    id: 3,
    title: 'Món khai vị - Salad',
  ),
  CategoryModel(
    id: 4,
    title: 'Trà - tráng miệng',
  ),
  CategoryModel(
    id: 5,
    title: 'Gọi thêm',
  ),
  CategoryModel(
    id: 6,
    title: 'Nước ép- trà',
  ),
  CategoryModel(
    id: 7,
    title: 'Món bán trên app',
    children: [
      SubCategoryModel(id: 8, title: 'Món lẻ trên app'),
      SubCategoryModel(id: 9, title: 'Combo trên app'),
    ],
  ),
];
var _comNieu = [
  ProductModel(
    id: 1,
    categoryId: 1,
    name: 'Cơm niêu xá xíu',
    unitPrice: '89000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/160725020109.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 2,
    categoryId: 1,
    name: 'Cơm niêu bò xốt tiêu đen Hải Sư',
    unitPrice: '89000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/160725020054.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 3,
    categoryId: 1,
    name: 'Cơm niêu gà nấm',
    unitPrice: '89000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/310725014643.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 4,
    categoryId: 1,
    name: 'Cơm niêu lươn xốt Teriyaki',
    unitPrice: '129000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/160725020135.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 5,
    categoryId: 1,
    name: 'Cơm niêu cá hồi xốt',
    unitPrice: '129000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/160725020149.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 6,
    categoryId: 1,
    name: 'Cơm niêu cá hồi chiên xù',
    unitPrice: '129000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/160725020202.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 7,
    categoryId: 1,
    name: 'Cơm rang xá xíu',
    unitPrice: '89000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/160725020215.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 8,
    categoryId: 1,
    name: 'Cơm niêu sườn heo',
    unitPrice: '89000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/160925110716.jpg',
    tax: 0.08,
  ),
];

var _dimsum = [
  ProductModel(
    id: 9,
    categoryId: 2,
    name: 'Há cảo tôm thịt',
    unitPrice: '39000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/030625103230.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 10,
    categoryId: 2,
    name: 'Há cảo sò điệp',
    unitPrice: '39000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/030625093430.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 11,
    categoryId: 2,
    name: 'Há cảo than tre',
    unitPrice: '39000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/030625093529.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 12,
    categoryId: 2,
    name: 'Há cảo ngọc bích',
    unitPrice: '39000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/030625093640.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 13,
    categoryId: 2,
    name: 'Xíu mại trứng cua',
    unitPrice: '39000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/030625093759.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 14,
    categoryId: 2,
    name: 'Bánh bao trà xanh',
    unitPrice: '15000',
    unit: 'Chiếc',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/030625094320.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 15,
    categoryId: 2,
    name: 'Bánh bao nấm',
    unitPrice: '15000',
    unit: 'Chiếc',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/030625094556.jpg',
    tax: 0.08,
  ),
];

var _khaivi = [
  ProductModel(
    id: 16,
    categoryId: 3,
    name: 'Chân gà hấp tàu xì',
    unitPrice: '49000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/030625092234.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 17,
    categoryId: 3,
    name: 'Cải hấp HongKong',
    unitPrice: '40000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/030625092438.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 18,
    categoryId: 3,
    name: 'Salad nhiệt đới xốt chang leo',
    unitPrice: '59000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/030625092548.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 19,
    categoryId: 3,
    name: 'Salad rong biển xốt mè',
    unitPrice: '59000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/030625103159.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 20,
    categoryId: 3,
    name: 'Kim chi',
    unitPrice: '15000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/030925025617.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 21,
    categoryId: 3,
    name: 'Dưa chuột muối',
    unitPrice: '15000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/160725015621.jpg',
    tax: 0.08,
  ),
];

var _trangmieng = [
  ProductModel(
    id: 22,
    categoryId: 4,
    name: 'Trà đào cam sả',
    unitPrice: '29000',
    unit: 'Cốc',
    printerType: 4,
    image: 'https://haisu.vn/Upload/Products/030625101745.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 23,
    categoryId: 4,
    name: 'Trà sâm nha đam',
    unitPrice: '20000',
    unit: 'Cốc',
    printerType: 4,
    image: 'https://haisu.vn/Upload/Products/030625101907.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 24,
    categoryId: 4,
    name: 'Trà ô long',
    unitPrice: '10000',
    unit: 'Cốc',
    printerType: 4,
    image: 'https://haisu.vn/Upload/Products/030625102358.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 25,
    categoryId: 4,
    name: 'Trà sâm thảo mộc',
    unitPrice: '20000',
    unit: 'Lon',
    printerType: 4,
    image: 'https://haisu.vn/Upload/Products/030625102508.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 26,
    categoryId: 4,
    name: 'Nước lọc Dasani',
    unitPrice: '18000',
    unit: 'Chai',
    printerType: 4,
    image: 'https://haisu.vn/Upload/Products/030625102648.jpg',
    tax: 0.08,
  ),
];
var _goithem = [
  ProductModel(
    id: 27,
    categoryId: 5,
    name: 'Dẻ sườn bò hầm nõn đuôi',
    unitPrice: '89000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/160925095923.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 28,
    categoryId: 5,
    name: 'Sườn heo, nõn đuôi hầm hoàng kim',
    unitPrice: '79000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/160925100011.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 29,
    categoryId: 5,
    name: 'Niêu cơm cháy',
    unitPrice: '39000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/030625095701.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 30,
    categoryId: 5,
    name: 'Trứng kho ngũ hương',
    unitPrice: '39000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/160925100227.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 31,
    categoryId: 5,
    name: 'Cá hồi chiên xù',
    unitPrice: '119000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/030625095934.jpg',
    tax: 0.08,
  ),
];
var _tra = [
  ProductModel(
    id: 32,
    categoryId: 6,
    name: 'Bia tiger',
    unitPrice: '32000',
    unit: 'Lon',
    printerType: 4,
    image: 'https://haisu.vn/Upload/Products/030625102839.jpg',
    tax: 0.08,
  ),
  ProductModel(
    id: 33,
    categoryId: 6,
    name: 'Coca',
    unitPrice: '20000',
    unit: 'Lon',
    printerType: 4,
    image: 'https://haisu.vn/Upload/Products/030625102738.jpg',
    tax: 0.08,
  ),
];
var _montrenapp = [
  ProductModel(
    id: 34,
    categoryId: 7,
    name: 'Món trên app',
    unitPrice: '20000',
    unit: 'Lon',
    printerType: 4,
    image: 'https://haisu.vn/Upload/Products/030625102738.jpg',
    tax: 0.08,
  ),
];
var _monletrenapp = [
  ProductModel(
    id: 35,
    categoryId: 8,
    name: 'Cơm niêu xá xíu (App)',
    unitPrice: '89000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/160725020109.jpg',
    tax: 0,
  ),
  ProductModel(
    id: 36,
    categoryId: 8,
    name: 'Cơm niêu bò xốt tiêu đen Hải Sư (App)',
    unitPrice: '89000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/160725020054.jpg',
    tax: 0.0,
  ),
  ProductModel(
    id: 37,
    categoryId: 8,
    name: 'Cơm niêu gà nấm (App)',
    unitPrice: '89000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/310725014643.jpg',
    tax: 0.0,
  ),
  ProductModel(
    id: 38,
    categoryId: 8,
    name: 'Cơm niêu lươn xốt Teriyaki (App)',
    unitPrice: '129000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/160725020135.jpg',
    tax: 0.0,
  ),
];
var _combotrenapp = [
  ProductModel(
    id: 39,
    categoryId: 9,
    name: 'Cơm niêu xá xíu (combo App)',
    unitPrice: '89000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/160725020109.jpg',
    tax: 0,
  ),
  ProductModel(
    id: 40,
    categoryId: 9,
    name: 'Cơm niêu bò xốt tiêu đen Hải Sư (combo App)',
    unitPrice: '89000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/160725020054.jpg',
    tax: 0.0,
  ),
  ProductModel(
    id: 41,
    categoryId: 9,
    name: 'Cơm niêu gà nấm (combo App)',
    unitPrice: '89000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/310725014643.jpg',
    tax: 0.0,
  ),
  ProductModel(
    id: 42,
    categoryId: 9,
    name: 'Cơm niêu lươn xốt Teriyaki (combo App)',
    unitPrice: '129000',
    unit: 'Suất',
    printerType: 2,
    image: 'https://haisu.vn/Upload/Products/160725020135.jpg',
    tax: 0.0,
  ),
];
List<ProductModel> kProducts = [
  ..._comNieu,
  ..._dimsum,
  ..._khaivi,
  ..._trangmieng,
  ..._goithem,
  ..._tra,
  ..._montrenapp,
  ..._monletrenapp,
  ..._combotrenapp,
];

List<UserBankModel> kBanks = [
  UserBankModel(
    useInvoice: null,
    listPaymentId: [],
    bankBin: '123',
    bankName: 'VCB',
    bankNumber: '1028964489',
    qrCode: '123',
    title: 'VCB - TITLE',
  ),
  UserBankModel(
    useInvoice: true,
    listPaymentId: [],
    bankBin: '123',
    bankName: 'VCB',
    bankNumber: '1028964489',
    qrCode: '123',
    title: 'VCB - TITLE - có invoice',
  ),
  UserBankModel(
    useInvoice: false,
    listPaymentId: [],
    bankBin: '123',
    bankName: 'VCB',
    bankNumber: '1028964489',
    qrCode: '123',
    title: 'VCB - TITLE - k invoice',
  ),
];

List<TableModel> kOnTables = List<TableModel>.generate(
    10, (index) => TableModel(id: index + 11, name: 'MV ${index + 1}'));
List<TableModel> kOffTables = List<TableModel>.generate(
    9, (index) => TableModel(id: index + 1, name: '10${index + 1}'));
// List<TableModel> kWaitingTables = List<TableModel>.generate(
//     9, (index) => TableModel(id: index + 1, name: '10${index + 1}', ));

List<TableModel> kNotUseOnTables = List<TableModel>.from(kOnTables);
List<TableModel> kNotUseOffTables = List<TableModel>.from(kOffTables);
List<TableModel> kUsingOnTables = [];
List<TableModel> kUsingOffTables = [];
List<OrderModel> kOffOrders = [];
List<OrderModel> kOnOrders = [];

List<WaiterModel> kWaiters = List.generate(
    7, (index) => WaiterModel(id: index + 1, name: 'PV ${index + 1}'));
int orderId = 1;
Future<({int? orderId, String? message})> kCreateNewOrder({
  required List<int> tableId,
  int? typeOrder,
}) async {
  List<TableModel> validTables = [];
  List<TableModel> invalidTables = [];
  bool isOffline = (typeOrder ?? kTypeOrder) == 2;
  var tables = (isOffline ? kNotUseOffTables : kNotUseOnTables);
  var checkIds = (isOffline ? kNotUseOffTables : kNotUseOnTables)
      .map((e) => e.id)
      .toList();
  for (var id in tableId) {
    if (checkIds.contains(id)) {
      var t = tables.firstWhereOrNull((e) => e.id == id);
      if (t != null) {
        validTables.add(t);
      }
    } else {
      var t = (isOffline ? kUsingOffTables : kUsingOnTables)
          .firstWhereOrNull((e) => e.id == id);
      if (t != null) {
        invalidTables.add(t);
      }
    }
  }

  if (invalidTables.isNotEmpty) {
    return (
      orderId: null,
      message:
          'Bàn ${invalidTables.map((e) => e.name).toList().join(', ')} đã được sử dụng'
    );
  }
  if (isOffline) {
    kOffOrders.add(OrderModel(
      id: orderId,
      qrO2O: ['1222'],
      misc: '{"order_code": "code-${orderId}"}',
      name: validTables.map((e) => e.name ?? '').toList().join(', '),
      waiterId: 1,
    ));
    kNotUseOffTables.removeWhere((e) => validTables.contains(e));
    kUsingOffTables.addAll(validTables);
  } else {
    kOnOrders.add(OrderModel(
      id: orderId,
      misc: '{"order_code": "code-${orderId}"}',
      qrO2O: ['1222'],
      name: validTables.map((e) => e.name ?? '').toList().join(', '),
      waiterId: 1,
    ));
    kNotUseOnTables.removeWhere((e) => validTables.contains(e));
    kUsingOnTables.addAll(validTables);
  }
  orderId++;
  return (orderId: orderId - 1, message: '');
}

Future<({int? orderId, String? message})> kUpdateTableOrder({
  required List<int> tableId,
  int? typeOrder,
  required OrderModel order,
}) async {
  List<TableModel> validTables = [];
  List<TableModel> invalidTables = [];
  bool isOffline = (typeOrder ?? kTypeOrder) == 2;
  for (var table in (isOffline ? kNotUseOffTables : kNotUseOnTables)) {
    if (tableId.contains(table.id)) {
      validTables.add(table);
    } else {
      invalidTables.add(table);
    }
  }

  if (invalidTables.isNotEmpty) {
    return (
      orderId: null,
      message:
          'Bàn ${invalidTables.map((e) => e.name).toList().join(', ')} đã được sử dụng'
    );
  }
  if (isOffline) {
    kOffOrders.add(OrderModel(
      id: orderId,
      qrO2O: ['1222'],
      misc: '{"order_code": "code-${orderId}"}',
      name: validTables.map((e) => e.name ?? '').toList().join(', '),
      waiterId: 1,
    ));
    kNotUseOffTables.removeWhere((e) => validTables.contains(e));
    kUsingOffTables.addAll(validTables);
  } else {
    kOnOrders.add(OrderModel(
      id: orderId,
      misc: '{"order_code": "code-${orderId}"}',
      qrO2O: ['1222'],
      name: validTables.map((e) => e.name ?? '').toList().join(', '),
      waiterId: 1,
    ));
    kNotUseOnTables.removeWhere((e) => validTables.contains(e));
    kUsingOnTables.addAll(validTables);
  }
  orderId++;
  return (orderId: orderId - 1, message: '');
}

List<CustomerModel> _customers = [];

///
/// adult: int
///
/// checkout: List<ProductCheckoutResponseData>
///
/// customer: CustomerModel?
///
/// coupon: List<CustomerPolicyModel>
///
/// price: PriceDataBill
///
/// invoice : OrderInvoice

Map<int, Map<String, dynamic>> _maps = {};

Future<CustomerModel> kFindCustomerForOrder({
  required String number,
  required int orderId,
}) async {
  var customer = _customers.firstWhereOrNull((e) => e.phoneNumber == number);
  if (customer != null) {
    var mapOrderId = _maps[orderId];

    if (mapOrderId == null) {
      _maps[orderId] = {
        'customer': customer,
      };
    } else {
      mapOrderId['customer'] = customer;
      _maps[orderId] = mapOrderId;
    }
    return customer;
  } else {
    throw 'Không tìm thấy thông tin khách hàng';
  }
}

Future<
    ({
      String message,
      int numberOfAdults,
      List<ProductCheckoutResponseData> checkoutData,
      CustomerModel? customer,
      List<CustomerPolicyModel> coupons,
    })> kGetProductCheckout(int orderId) async {
  var mapOrderId = _maps[orderId];
  if (mapOrderId == null) {
    return (
      message: '',
      numberOfAdults: 1,
      checkoutData: <ProductCheckoutResponseData>[],
      customer: null,
      coupons: <CustomerPolicyModel>[],
    );
  }
  return (
    message: '',
    numberOfAdults: (mapOrderId['adult'] ?? 1) as int,
    checkoutData:
        (mapOrderId['checkout'] ?? []) as List<ProductCheckoutResponseData>,
    customer: mapOrderId['customer'] as CustomerModel?,
    coupons: (mapOrderId['coupon'] ?? []) as List<CustomerPolicyModel>,
  );
}

List<IpOrderModel> kPrinters = [
  IpOrderModel(
    ip: '127.0.0.1',
    port: 9100,
    type: 2,
    name: 'Máy in bếp',
  ),
  IpOrderModel(
    ip: '127.0.0.1',
    port: 9100,
    type: 4,
    name: 'Máy in bar',
  ),
  IpOrderModel(
    ip: '127.0.0.1',
    port: 9100,
    type: 1,
    name: 'Máy in tạm tính',
  ),
  IpOrderModel(
    ip: '127.0.0.1',
    port: 9100,
    type: 3,
    name: 'Máy in bill',
  ),
];

Future<OrderInvoice> kGetOrderInvoice(int orderId) async {
  var mapOrderId = _maps[orderId];
  if (mapOrderId == null) {
    return const OrderInvoice();
  }
  return mapOrderId['invoice'] ?? const OrderInvoice();
}

Future<DataBillResponseData> kGetOrderDataBill(int orderId) async {
  var mapOrderId = _maps[orderId];
  var order =
      [...kOffOrders, ...kOnOrders].firstWhereOrNull((e) => e.id == orderId);
  return DataBillResponseData(
    price: (mapOrderId?['price'] ?? const PriceDataBill()) as PriceDataBill,
    order: OrderDataBill(
      amountAdult: (mapOrderId?['adult'] ?? 1) as int,
      amountChildren: (mapOrderId?['children'] ?? 0) as int,
      id: orderId,
      code: order?.getOrderMisc() ?? '',
      tableName: order?.name ?? '',
    ),
  );
}

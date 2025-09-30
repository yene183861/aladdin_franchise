// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ErrorLogModelImpl _$$ErrorLogModelImplFromJson(Map<String, dynamic> json) =>
    _$ErrorLogModelImpl(
      action: $enumDecode(_$AppLogActionEnumMap, json['action']),
      waiter: json['waiter'] == null
          ? null
          : UserModel.fromJson(json['waiter'] as Map<String, dynamic>),
      ipConfig: json['ip_config'] as String?,
      ipNetwork: json['ip_network'] as String?,
      wifiName: json['wifi_name'] as String?,
      errorMessage: json['error_message'] as String?,
      createAt: json['create_at'],
      order: json['order'] == null
          ? null
          : OrderModel.fromJson(json['order'] as Map<String, dynamic>),
      api: json['api'] as String?,
      request: json['request'],
      response: json['response'],
      modelInterface: json['model_interface'],
      appVersion: json['app_version'] as String?,
      deviceId: (json['device_id'] as num?)?.toInt(),
      waiterId: (json['waiter_id'] as num?)?.toInt(),
      makeDeviceId: json['make_device_id'] as String?,
    );

Map<String, dynamic> _$$ErrorLogModelImplToJson(_$ErrorLogModelImpl instance) =>
    <String, dynamic>{
      'action': _actionToName(instance.action),
      'waiter': instance.waiter?.toJson(),
      'ip_config': instance.ipConfig,
      'ip_network': instance.ipNetwork,
      'wifi_name': instance.wifiName,
      'error_message': instance.errorMessage,
      'create_at': instance.createAt,
      'order': instance.order?.toJson(),
      'api': instance.api,
      'request': instance.request,
      'response': instance.response,
      'model_interface': instance.modelInterface,
      'app_version': instance.appVersion,
      'device_id': instance.deviceId,
      'waiter_id': instance.waiterId,
      'make_device_id': instance.makeDeviceId,
    };

const _$AppLogActionEnumMap = {
  AppLogAction.general: 'general',
  AppLogAction.updateApp: 'updateApp',
  AppLogAction.login: 'login',
  AppLogAction.loginSuccess: 'loginSuccess',
  AppLogAction.checkCodeWaiter: 'checkCodeWaiter',
  AppLogAction.closingShift: 'closingShift',
  AppLogAction.getCategory: 'getCategory',
  AppLogAction.getProductByCategory: 'getProductByCategory',
  AppLogAction.getDataBill: 'getDataBill',
  AppLogAction.getIpPrinterOrder: 'getIpPrinterOrder',
  AppLogAction.pingPrinter: 'pingPrinter',
  AppLogAction.getOrders: 'getOrders',
  AppLogAction.createAndUpdateOrder: 'createAndUpdateOrder',
  AppLogAction.checkStatusLockOrder: 'checkStatusLockOrder',
  AppLogAction.getStatusLockOrder: 'getStatusLockOrder',
  AppLogAction.lockOrder: 'lockOrder',
  AppLogAction.sendPaymentRating: 'sendPaymentRating',
  AppLogAction.updateInvoiceForOrder: 'updateInvoiceForOrder',
  AppLogAction.getInvoiceByOrder: 'getInvoiceByOrder',
  AppLogAction.processOrder: 'processOrder',
  AppLogAction.processOrderBill: 'processOrderBill',
  AppLogAction.cancelDishBill: 'cancelDishBill',
  AppLogAction.cancelDish: 'cancelDish',
  AppLogAction.getProductCheckout: 'getProductCheckout',
  AppLogAction.completeBill: 'completeBill',
  AppLogAction.payment: 'payment',
  AppLogAction.updateTax: 'updateTax',
  AppLogAction.getPaymentGateway: 'getPaymentGateway',
  AppLogAction.posCallback: 'posCallback',
  AppLogAction.findCustomer: 'findCustomer',
  AppLogAction.createCustomer: 'createCustomer',
  AppLogAction.getLinkZaloOA: 'getLinkZaloOA',
  AppLogAction.applyPolicy: 'applyPolicy',
  AppLogAction.getBankPayment: 'getBankPayment',
  AppLogAction.getPaymentMethod: 'getPaymentMethod',
  AppLogAction.getListPos: 'getListPos',
  AppLogAction.getCashiers: 'getCashiers',
  AppLogAction.historyOrder: 'historyOrder',
  AppLogAction.getInfoByTaxCode: 'getInfoByTaxCode',
  AppLogAction.getEmployeeSales: 'getEmployeeSales',
  AppLogAction.getCouponByCode: 'getCouponByCode',
  AppLogAction.unblockCouponCode: 'unblockCouponCode',
  AppLogAction.getTickets: 'getTickets',
  AppLogAction.createTicket: 'createTicket',
  AppLogAction.localStorage: 'localStorage',
};

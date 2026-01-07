// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Order not exist`
  String get orderNotExist {
    return Intl.message(
      'Order not exist',
      name: 'orderNotExist',
      desc: '',
      args: [],
    );
  }

  /// `Email or username`
  String get username {
    return Intl.message(
      'Email or username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Verification code`
  String get verificationCodes {
    return Intl.message(
      'Verification code',
      name: 'verificationCodes',
      desc: '',
      args: [],
    );
  }

  /// `Enter auth code`
  String get enterAuthCode {
    return Intl.message(
      'Enter auth code',
      name: 'enterAuthCode',
      desc: '',
      args: [],
    );
  }

  /// `Verification`
  String get verification {
    return Intl.message(
      'Verification',
      name: 'verification',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get agree {
    return Intl.message(
      'Agree',
      name: 'agree',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Verification code is incorrect`
  String get verificationCodeIsIncorrect {
    return Intl.message(
      'Verification code is incorrect',
      name: 'verificationCodeIsIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please, connect IT support!`
  String get forgotPasswordMessage {
    return Intl.message(
      'Please, connect IT support!',
      name: 'forgotPasswordMessage',
      desc: '',
      args: [],
    );
  }

  /// `Create new customers`
  String get createNewCustomers {
    return Intl.message(
      'Create new customers',
      name: 'createNewCustomers',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone {
    return Intl.message(
      'Phone number',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get firstName {
    return Intl.message(
      'First name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lastName {
    return Intl.message(
      'Last name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `B.O.D`
  String get bOD {
    return Intl.message(
      'B.O.D',
      name: 'bOD',
      desc: '',
      args: [],
    );
  }

  /// `inaccurate Data`
  String get inaccurateData {
    return Intl.message(
      'inaccurate Data',
      name: 'inaccurateData',
      desc: '',
      args: [],
    );
  }

  /// `Select table`
  String get selectTable {
    return Intl.message(
      'Select table',
      name: 'selectTable',
      desc: '',
      args: [],
    );
  }

  /// `Table off`
  String get tableOff {
    return Intl.message(
      'Table off',
      name: 'tableOff',
      desc: '',
      args: [],
    );
  }

  /// `Can not load tables`
  String get canNotLoadTables {
    return Intl.message(
      'Can not load tables',
      name: 'canNotLoadTables',
      desc: '',
      args: [],
    );
  }

  /// `Not tables selected`
  String get notTableSelected {
    return Intl.message(
      'Not tables selected',
      name: 'notTableSelected',
      desc: '',
      args: [],
    );
  }

  /// `not waiter selected`
  String get notWaiterSelected {
    return Intl.message(
      'not waiter selected',
      name: 'notWaiterSelected',
      desc: '',
      args: [],
    );
  }

  /// `Created new order`
  String get createdNewOrder {
    return Intl.message(
      'Created new order',
      name: 'createdNewOrder',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get detail {
    return Intl.message(
      'Detail',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  /// `No info`
  String get noInfo {
    return Intl.message(
      'No info',
      name: 'noInfo',
      desc: '',
      args: [],
    );
  }

  /// `Request history`
  String get requestHistory {
    return Intl.message(
      'Request history',
      name: 'requestHistory',
      desc: '',
      args: [],
    );
  }

  /// `No request`
  String get noRequest {
    return Intl.message(
      'No request',
      name: 'noRequest',
      desc: '',
      args: [],
    );
  }

  /// `Call more`
  String get callMore {
    return Intl.message(
      'Call more',
      name: 'callMore',
      desc: '',
      args: [],
    );
  }

  /// `Cancel request`
  String get cancelRequest {
    return Intl.message(
      'Cancel request',
      name: 'cancelRequest',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant`
  String get restaurant {
    return Intl.message(
      'Restaurant',
      name: 'restaurant',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Transfer order`
  String get transferOrder {
    return Intl.message(
      'Transfer order',
      name: 'transferOrder',
      desc: '',
      args: [],
    );
  }

  /// `No order yet`
  String get noOrderYet {
    return Intl.message(
      'No order yet',
      name: 'noOrderYet',
      desc: '',
      args: [],
    );
  }

  /// `Select order`
  String get selectOrder {
    return Intl.message(
      'Select order',
      name: 'selectOrder',
      desc: '',
      args: [],
    );
  }

  /// `Create new order`
  String get createNewOrder {
    return Intl.message(
      'Create new order',
      name: 'createNewOrder',
      desc: '',
      args: [],
    );
  }

  /// `Update order current`
  String get updateOrderCurrent {
    return Intl.message(
      'Update order current',
      name: 'updateOrderCurrent',
      desc: '',
      args: [],
    );
  }

  /// `Transfer order current`
  String get transferOrderCurrent {
    return Intl.message(
      'Transfer order current',
      name: 'transferOrderCurrent',
      desc: '',
      args: [],
    );
  }

  /// `Please select order first!`
  String get pleaseSelectOrderFirst {
    return Intl.message(
      'Please select order first!',
      name: 'pleaseSelectOrderFirst',
      desc: '',
      args: [],
    );
  }

  /// `Cancel order current`
  String get cancelOrderCurrent {
    return Intl.message(
      'Cancel order current',
      name: 'cancelOrderCurrent',
      desc: '',
      args: [],
    );
  }

  /// `Cancel order`
  String get cancelOrder {
    return Intl.message(
      'Cancel order',
      name: 'cancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `Once canceled, it cannot be restored\nOnly done when the wrong order is created or the customer cancels an order that is no longer needed`
  String get messageCancelOrder {
    return Intl.message(
      'Once canceled, it cannot be restored\nOnly done when the wrong order is created or the customer cancels an order that is no longer needed',
      name: 'messageCancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `Cancel order success!`
  String get cancelOrderSuccess {
    return Intl.message(
      'Cancel order success!',
      name: 'cancelOrderSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Can not load order`
  String get canNotLoadOrder {
    return Intl.message(
      'Can not load order',
      name: 'canNotLoadOrder',
      desc: '',
      args: [],
    );
  }

  /// `The mode of operation can be changed in the restaurant's options menu.`
  String get messageSelectTypeOrder {
    return Intl.message(
      'The mode of operation can be changed in the restaurant\'s options menu.',
      name: 'messageSelectTypeOrder',
      desc: '',
      args: [],
    );
  }

  /// `Reason for Cancellation`
  String get reasonForCancellation {
    return Intl.message(
      'Reason for Cancellation',
      name: 'reasonForCancellation',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get processing {
    return Intl.message(
      'Processing',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Update - Chose table`
  String get updateAndChoseTable {
    return Intl.message(
      'Update - Chose table',
      name: 'updateAndChoseTable',
      desc: '',
      args: [],
    );
  }

  /// `Transfer update order`
  String get transferUpdateOrder {
    return Intl.message(
      'Transfer update order',
      name: 'transferUpdateOrder',
      desc: '',
      args: [],
    );
  }

  /// `Update success!`
  String get updateSuccess {
    return Intl.message(
      'Update success!',
      name: 'updateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Transfer order success!`
  String get transferOrderSuccess {
    return Intl.message(
      'Transfer order success!',
      name: 'transferOrderSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Transfer success!`
  String get transferSuccess {
    return Intl.message(
      'Transfer success!',
      name: 'transferSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Apply products`
  String get applyProducts {
    return Intl.message(
      'Apply products',
      name: 'applyProducts',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Discount code`
  String get discountCode {
    return Intl.message(
      'Discount code',
      name: 'discountCode',
      desc: '',
      args: [],
    );
  }

  /// `Input code`
  String get inputCode {
    return Intl.message(
      'Input code',
      name: 'inputCode',
      desc: '',
      args: [],
    );
  }

  /// `Bill total`
  String get billTotal {
    return Intl.message(
      'Bill total',
      name: 'billTotal',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `No order select`
  String get noOrderSelect {
    return Intl.message(
      'No order select',
      name: 'noOrderSelect',
      desc: '',
      args: [],
    );
  }

  /// `Selecting dish`
  String get selectingDish {
    return Intl.message(
      'Selecting dish',
      name: 'selectingDish',
      desc: '',
      args: [],
    );
  }

  /// `Selected dish`
  String get selectedDish {
    return Intl.message(
      'Selected dish',
      name: 'selectedDish',
      desc: '',
      args: [],
    );
  }

  /// `Invoice detail`
  String get invoiceDetail {
    return Intl.message(
      'Invoice detail',
      name: 'invoiceDetail',
      desc: '',
      args: [],
    );
  }

  /// `Total amount dish selecting`
  String get totalAmountSelecting {
    return Intl.message(
      'Total amount dish selecting',
      name: 'totalAmountSelecting',
      desc: '',
      args: [],
    );
  }

  /// `Total amount selected`
  String get totalAmountSelected {
    return Intl.message(
      'Total amount selected',
      name: 'totalAmountSelected',
      desc: '',
      args: [],
    );
  }

  /// `Total amount payment`
  String get totalAmountPayment {
    return Intl.message(
      'Total amount payment',
      name: 'totalAmountPayment',
      desc: '',
      args: [],
    );
  }

  /// `No products`
  String get noProducts {
    return Intl.message(
      'No products',
      name: 'noProducts',
      desc: '',
      args: [],
    );
  }

  /// `Order confirm?`
  String get orderConfirm {
    return Intl.message(
      'Order confirm?',
      name: 'orderConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `Process order success!`
  String get processOrderSuccess {
    return Intl.message(
      'Process order success!',
      name: 'processOrderSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Process order`
  String get processOrder {
    return Intl.message(
      'Process order',
      name: 'processOrder',
      desc: '',
      args: [],
    );
  }

  /// `No ordered products are on the discount list`
  String get messageAddCouponNoProducts {
    return Intl.message(
      'No ordered products are on the discount list',
      name: 'messageAddCouponNoProducts',
      desc: '',
      args: [],
    );
  }

  /// `No B.O.D`
  String get noBOD {
    return Intl.message(
      'No B.O.D',
      name: 'noBOD',
      desc: '',
      args: [],
    );
  }

  /// `Rank`
  String get rank {
    return Intl.message(
      'Rank',
      name: 'rank',
      desc: '',
      args: [],
    );
  }

  /// `Not available yet`
  String get notAvailableYet {
    return Intl.message(
      'Not available yet',
      name: 'notAvailableYet',
      desc: '',
      args: [],
    );
  }

  /// `Accumulated points`
  String get accPoints {
    return Intl.message(
      'Accumulated points',
      name: 'accPoints',
      desc: '',
      args: [],
    );
  }

  /// `Point`
  String get point {
    return Intl.message(
      'Point',
      name: 'point',
      desc: '',
      args: [],
    );
  }

  /// `Point to money`
  String get pointToMoney {
    return Intl.message(
      'Point to money',
      name: 'pointToMoney',
      desc: '',
      args: [],
    );
  }

  /// `Use`
  String get use {
    return Intl.message(
      'Use',
      name: 'use',
      desc: '',
      args: [],
    );
  }

  /// `Reduce`
  String get reduce {
    return Intl.message(
      'Reduce',
      name: 'reduce',
      desc: '',
      args: [],
    );
  }

  /// `Qty`
  String get quantityCut {
    return Intl.message(
      'Qty',
      name: 'quantityCut',
      desc: '',
      args: [],
    );
  }

  /// `Customer policy`
  String get customerPolicy {
    return Intl.message(
      'Customer policy',
      name: 'customerPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Find customer`
  String get findCustomer {
    return Intl.message(
      'Find customer',
      name: 'findCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Check`
  String get check {
    return Intl.message(
      'Check',
      name: 'check',
      desc: '',
      args: [],
    );
  }

  /// `Input`
  String get input {
    return Intl.message(
      'Input',
      name: 'input',
      desc: '',
      args: [],
    );
  }

  /// `Delete customer from invoice?`
  String get removeCustomer {
    return Intl.message(
      'Delete customer from invoice?',
      name: 'removeCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Delete discount code`
  String get deleteDiscountCode {
    return Intl.message(
      'Delete discount code',
      name: 'deleteDiscountCode',
      desc: '',
      args: [],
    );
  }

  /// `No discount codes applied`
  String get notDiscountApply {
    return Intl.message(
      'No discount codes applied',
      name: 'notDiscountApply',
      desc: '',
      args: [],
    );
  }

  /// `Apply selected policies and discount codes?`
  String get messageApplyDiscount {
    return Intl.message(
      'Apply selected policies and discount codes?',
      name: 'messageApplyDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!`
  String get congratulations {
    return Intl.message(
      'Congratulations!',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `Apply policy & discount code successfully!\nSee discounted price in invoice`
  String get messageApplyDiscountResult {
    return Intl.message(
      'Apply policy & discount code successfully!\nSee discounted price in invoice',
      name: 'messageApplyDiscountResult',
      desc: '',
      args: [],
    );
  }

  /// `Total amount order`
  String get totalAmoutOrder {
    return Intl.message(
      'Total amount order',
      name: 'totalAmoutOrder',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message(
      'Discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Amount payment`
  String get amountPayment {
    return Intl.message(
      'Amount payment',
      name: 'amountPayment',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Get info processing`
  String get getInfoProcessing {
    return Intl.message(
      'Get info processing',
      name: 'getInfoProcessing',
      desc: '',
      args: [],
    );
  }

  /// `Checking`
  String get checking {
    return Intl.message(
      'Checking',
      name: 'checking',
      desc: '',
      args: [],
    );
  }

  /// `Canceling`
  String get canceling {
    return Intl.message(
      'Canceling',
      name: 'canceling',
      desc: '',
      args: [],
    );
  }

  /// `Called products`
  String get calledProducts {
    return Intl.message(
      'Called products',
      name: 'calledProducts',
      desc: '',
      args: [],
    );
  }

  /// `Calling products`
  String get callingProducts {
    return Intl.message(
      'Calling products',
      name: 'callingProducts',
      desc: '',
      args: [],
    );
  }

  /// `Cancel dish`
  String get cancelDish {
    return Intl.message(
      'Cancel dish',
      name: 'cancelDish',
      desc: '',
      args: [],
    );
  }

  /// `Confirm cancel dish`
  String get confirmCancelDish {
    return Intl.message(
      'Confirm cancel dish',
      name: 'confirmCancelDish',
      desc: '',
      args: [],
    );
  }

  /// `Invoice`
  String get invoice {
    return Intl.message(
      'Invoice',
      name: 'invoice',
      desc: '',
      args: [],
    );
  }

  /// `Endow`
  String get endow {
    return Intl.message(
      'Endow',
      name: 'endow',
      desc: '',
      args: [],
    );
  }

  /// `Config`
  String get config {
    return Intl.message(
      'Config',
      name: 'config',
      desc: '',
      args: [],
    );
  }

  /// `Lets Order Food`
  String get letsOrderFood {
    return Intl.message(
      'Lets Order Food',
      name: 'letsOrderFood',
      desc: '',
      args: [],
    );
  }

  /// `Waiter`
  String get waiter {
    return Intl.message(
      'Waiter',
      name: 'waiter',
      desc: '',
      args: [],
    );
  }

  /// `Payment now`
  String get paymentNow {
    return Intl.message(
      'Payment now',
      name: 'paymentNow',
      desc: '',
      args: [],
    );
  }

  /// `Please call service to make payment`
  String get messageCallWaiterPayment {
    return Intl.message(
      'Please call service to make payment',
      name: 'messageCallWaiterPayment',
      desc: '',
      args: [],
    );
  }

  /// `Scroll to end`
  String get scrollToEnd {
    return Intl.message(
      'Scroll to end',
      name: 'scrollToEnd',
      desc: '',
      args: [],
    );
  }

  /// `Called`
  String get called {
    return Intl.message(
      'Called',
      name: 'called',
      desc: '',
      args: [],
    );
  }

  /// `Search dish`
  String get searchDish {
    return Intl.message(
      'Search dish',
      name: 'searchDish',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get tryAgain {
    return Intl.message(
      'Try again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Confirm that you want to sign out?`
  String get logoutConfirm {
    return Intl.message(
      'Confirm that you want to sign out?',
      name: 'logoutConfirm',
      desc: '',
      args: [],
    );
  }

  /// `There is a cancellation request that has not been processed, please wait and reload the list to check!`
  String get noticeRequestCancel {
    return Intl.message(
      'There is a cancellation request that has not been processed, please wait and reload the list to check!',
      name: 'noticeRequestCancel',
      desc: '',
      args: [],
    );
  }

  /// `Long Wang`
  String get longWang {
    return Intl.message(
      'Long Wang',
      name: 'longWang',
      desc: '',
      args: [],
    );
  }

  /// `Hong Kong hydrothermal steaming hotpot`
  String get longWangSlogan {
    return Intl.message(
      'Hong Kong hydrothermal steaming hotpot',
      name: 'longWangSlogan',
      desc: '',
      args: [],
    );
  }

  /// `Quan Moc Young Beef`
  String get btqm {
    return Intl.message(
      'Quan Moc Young Beef',
      name: 'btqm',
      desc: '',
      args: [],
    );
  }

  /// `The beauty of Hanoi's old streets`
  String get btqmSlogan {
    return Intl.message(
      'The beauty of Hanoi\'s old streets',
      name: 'btqmSlogan',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Vietnamese`
  String get tiengViet {
    return Intl.message(
      'Vietnamese',
      name: 'tiengViet',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get tiengAnh {
    return Intl.message(
      'English',
      name: 'tiengAnh',
      desc: '',
      args: [],
    );
  }

  /// `Table`
  String get table {
    return Intl.message(
      'Table',
      name: 'table',
      desc: '',
      args: [],
    );
  }

  /// `Error!\nPress to try again`
  String get errorAndPressAgain {
    return Intl.message(
      'Error!\nPress to try again',
      name: 'errorAndPressAgain',
      desc: '',
      args: [],
    );
  }

  /// `Sell Online`
  String get orderOnline {
    return Intl.message(
      'Sell Online',
      name: 'orderOnline',
      desc: '',
      args: [],
    );
  }

  /// `At restaurant`
  String get orderOffline {
    return Intl.message(
      'At restaurant',
      name: 'orderOffline',
      desc: '',
      args: [],
    );
  }

  /// `Order sell mode`
  String get orderSellType {
    return Intl.message(
      'Order sell mode',
      name: 'orderSellType',
      desc: '',
      args: [],
    );
  }

  /// `Price does not include VAT`
  String get infoVAT {
    return Intl.message(
      'Price does not include VAT',
      name: 'infoVAT',
      desc: '',
      args: [],
    );
  }

  /// `Update data`
  String get updateData {
    return Intl.message(
      'Update data',
      name: 'updateData',
      desc: '',
      args: [],
    );
  }

  /// `More data: categories, dish, order,...`
  String get updateDataInfo {
    return Intl.message(
      'More data: categories, dish, order,...',
      name: 'updateDataInfo',
      desc: '',
      args: [],
    );
  }

  /// `Delete cache`
  String get deleteCache {
    return Intl.message(
      'Delete cache',
      name: 'deleteCache',
      desc: '',
      args: [],
    );
  }

  /// `Delete the data of the currently selected dishes and payment information saved on the current device`
  String get deleteCacheInfo {
    return Intl.message(
      'Delete the data of the currently selected dishes and payment information saved on the current device',
      name: 'deleteCacheInfo',
      desc: '',
      args: [],
    );
  }

  /// `Personal`
  String get personal {
    return Intl.message(
      'Personal',
      name: 'personal',
      desc: '',
      args: [],
    );
  }

  /// `Click to switch order sell mode`
  String get orderSellTypeInfo {
    return Intl.message(
      'Click to switch order sell mode',
      name: 'orderSellTypeInfo',
      desc: '',
      args: [],
    );
  }

  /// `Software`
  String get software {
    return Intl.message(
      'Software',
      name: 'software',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Device information`
  String get infoDevice {
    return Intl.message(
      'Device information',
      name: 'infoDevice',
      desc: '',
      args: [],
    );
  }

  /// `Device code`
  String get deviceCode {
    return Intl.message(
      'Device code',
      name: 'deviceCode',
      desc: '',
      args: [],
    );
  }

  /// `IP address`
  String get deviceIP {
    return Intl.message(
      'IP address',
      name: 'deviceIP',
      desc: '',
      args: [],
    );
  }

  /// `Network connect`
  String get networkConnect {
    return Intl.message(
      'Network connect',
      name: 'networkConnect',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Check for update`
  String get checkForUpdate {
    return Intl.message(
      'Check for update',
      name: 'checkForUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Success!`
  String get success {
    return Intl.message(
      'Success!',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Chose`
  String get chose {
    return Intl.message(
      'Chose',
      name: 'chose',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Save success!`
  String get saveSuccess {
    return Intl.message(
      'Save success!',
      name: 'saveSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Info config`
  String get infoConfig {
    return Intl.message(
      'Info config',
      name: 'infoConfig',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant is empty`
  String get restaurantEmpty {
    return Intl.message(
      'Restaurant is empty',
      name: 'restaurantEmpty',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Order online is ON`
  String get enableOnline {
    return Intl.message(
      'Order online is ON',
      name: 'enableOnline',
      desc: '',
      args: [],
    );
  }

  /// `Order online is OFF`
  String get disableOnline {
    return Intl.message(
      'Order online is OFF',
      name: 'disableOnline',
      desc: '',
      args: [],
    );
  }

  /// `Verifying`
  String get verifying {
    return Intl.message(
      'Verifying',
      name: 'verifying',
      desc: '',
      args: [],
    );
  }

  /// `Creating a new order`
  String get creating_a_new_order {
    return Intl.message(
      'Creating a new order',
      name: 'creating_a_new_order',
      desc: '',
      args: [],
    );
  }

  /// `Updating for order`
  String get updating_order {
    return Intl.message(
      'Updating for order',
      name: 'updating_order',
      desc: '',
      args: [],
    );
  }

  /// `Canceling order`
  String get cancel_order {
    return Intl.message(
      'Canceling order',
      name: 'cancel_order',
      desc: '',
      args: [],
    );
  }

  /// `Updating the operation panel menu`
  String get updating_order_panel {
    return Intl.message(
      'Updating the operation panel menu',
      name: 'updating_order_panel',
      desc: '',
      args: [],
    );
  }

  /// `Orders are being delivered`
  String get orders_are_being_delivered {
    return Intl.message(
      'Orders are being delivered',
      name: 'orders_are_being_delivered',
      desc: '',
      args: [],
    );
  }

  /// `Sending request to cancel order`
  String get sending_request_to_cancel_order {
    return Intl.message(
      'Sending request to cancel order',
      name: 'sending_request_to_cancel_order',
      desc: '',
      args: [],
    );
  }

  /// `Checking connection`
  String get checking_connection {
    return Intl.message(
      'Checking connection',
      name: 'checking_connection',
      desc: '',
      args: [],
    );
  }

  /// `Changing form of sell mode`
  String get changing_form_of_sell_mode {
    return Intl.message(
      'Changing form of sell mode',
      name: 'changing_form_of_sell_mode',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred, please try again`
  String get an_error_occurred {
    return Intl.message(
      'An error occurred, please try again',
      name: 'an_error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Attention`
  String get attention {
    return Intl.message(
      'Attention',
      name: 'attention',
      desc: '',
      args: [],
    );
  }

  /// `Ordered food, but cannot print receipt`
  String get attention_processed_print {
    return Intl.message(
      'Ordered food, but cannot print receipt',
      name: 'attention_processed_print',
      desc: '',
      args: [],
    );
  }

  /// `Order canceled, but invoice cannot be printed`
  String get attention_canceled_print {
    return Intl.message(
      'Order canceled, but invoice cannot be printed',
      name: 'attention_canceled_print',
      desc: '',
      args: [],
    );
  }

  /// `Try printing again`
  String get try_printing_again {
    return Intl.message(
      'Try printing again',
      name: 'try_printing_again',
      desc: '',
      args: [],
    );
  }

  /// `No customer information found`
  String get find_customer_not_found {
    return Intl.message(
      'No customer information found',
      name: 'find_customer_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Discount code already exists`
  String get discount_code_already_exists {
    return Intl.message(
      'Discount code already exists',
      name: 'discount_code_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `Discount code is not valid`
  String get discount_code_is_not_valid {
    return Intl.message(
      'Discount code is not valid',
      name: 'discount_code_is_not_valid',
      desc: '',
      args: [],
    );
  }

  /// `Discount code cannot be deleted`
  String get discount_code_cannot_be_deleted {
    return Intl.message(
      'Discount code cannot be deleted',
      name: 'discount_code_cannot_be_deleted',
      desc: '',
      args: [],
    );
  }

  /// `Miss information`
  String get miss_information {
    return Intl.message(
      'Miss information',
      name: 'miss_information',
      desc: '',
      args: [],
    );
  }

  /// `The printer has not been set up`
  String get printer_not_config {
    return Intl.message(
      'The printer has not been set up',
      name: 'printer_not_config',
      desc: '',
      args: [],
    );
  }

  /// `Printer cannot be connected\nPlease check again!`
  String get printer_not_connect {
    return Intl.message(
      'Printer cannot be connected\nPlease check again!',
      name: 'printer_not_connect',
      desc: '',
      args: [],
    );
  }

  /// `Request is being revoked`
  String get request_is_being_revoked {
    return Intl.message(
      'Request is being revoked',
      name: 'request_is_being_revoked',
      desc: '',
      args: [],
    );
  }

  /// `Quantity not selected yet`
  String get quantity_not_selected_yet {
    return Intl.message(
      'Quantity not selected yet',
      name: 'quantity_not_selected_yet',
      desc: '',
      args: [],
    );
  }

  /// `Loading list`
  String get loading_list {
    return Intl.message(
      'Loading list',
      name: 'loading_list',
      desc: '',
      args: [],
    );
  }

  /// `Loading data`
  String get loading_data {
    return Intl.message(
      'Loading data',
      name: 'loading_data',
      desc: '',
      args: [],
    );
  }

  /// `Add notes`
  String get add_notes {
    return Intl.message(
      'Add notes',
      name: 'add_notes',
      desc: '',
      args: [],
    );
  }

  /// `Number of people`
  String get number_of_people {
    return Intl.message(
      'Number of people',
      name: 'number_of_people',
      desc: '',
      args: [],
    );
  }

  /// `Number of adults`
  String get number_of_adults {
    return Intl.message(
      'Number of adults',
      name: 'number_of_adults',
      desc: '',
      args: [],
    );
  }

  /// `Number of children`
  String get number_of_children {
    return Intl.message(
      'Number of children',
      name: 'number_of_children',
      desc: '',
      args: [],
    );
  }

  /// `Confirm to change language [{title}]?\nATTENTION: The software will restart after changing the language.`
  String confirm_change_language(String title) {
    return Intl.message(
      'Confirm to change language [$title]?\nATTENTION: The software will restart after changing the language.',
      name: 'confirm_change_language',
      desc: '',
      args: [title],
    );
  }

  /// `Software in use`
  String get current_language_use {
    return Intl.message(
      'Software in use',
      name: 'current_language_use',
      desc: '',
      args: [],
    );
  }

  /// `Total amount`
  String get total_amount {
    return Intl.message(
      'Total amount',
      name: 'total_amount',
      desc: '',
      args: [],
    );
  }

  /// `Discount money`
  String get discount_money {
    return Intl.message(
      'Discount money',
      name: 'discount_money',
      desc: '',
      args: [],
    );
  }

  /// `Tax money`
  String get tax_money {
    return Intl.message(
      'Tax money',
      name: 'tax_money',
      desc: '',
      args: [],
    );
  }

  /// `Category has not been set yet`
  String get error_category_not_set {
    return Intl.message(
      'Category has not been set yet',
      name: 'error_category_not_set',
      desc: '',
      args: [],
    );
  }

  /// `Product list has not been set up yet`
  String get error_products_not_set {
    return Intl.message(
      'Product list has not been set up yet',
      name: 'error_products_not_set',
      desc: '',
      args: [],
    );
  }

  /// `QR customer registration Zalo-OA`
  String get qr_reg_zalo_oa {
    return Intl.message(
      'QR customer registration Zalo-OA',
      name: 'qr_reg_zalo_oa',
      desc: '',
      args: [],
    );
  }

  /// `Bring up`
  String get bring_up {
    return Intl.message(
      'Bring up',
      name: 'bring_up',
      desc: '',
      args: [],
    );
  }

  /// `Check items`
  String get check_items {
    return Intl.message(
      'Check items',
      name: 'check_items',
      desc: '',
      args: [],
    );
  }

  /// `Food information`
  String get food_information {
    return Intl.message(
      'Food information',
      name: 'food_information',
      desc: '',
      args: [],
    );
  }

  /// `In ordered combo`
  String get included_in_the_ordered_combo {
    return Intl.message(
      'In ordered combo',
      name: 'included_in_the_ordered_combo',
      desc: '',
      args: [],
    );
  }

  /// `Customers`
  String get customers {
    return Intl.message(
      'Customers',
      name: 'customers',
      desc: '',
      args: [],
    );
  }

  /// `Search by phone number`
  String get search_by_phone_number {
    return Intl.message(
      'Search by phone number',
      name: 'search_by_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Scan code (Zalo-OA)`
  String get scan_code_zalo {
    return Intl.message(
      'Scan code (Zalo-OA)',
      name: 'scan_code_zalo',
      desc: '',
      args: [],
    );
  }

  /// `Create new customer via Zalo-OA`
  String get create_new_customers_via_Zalo_OA {
    return Intl.message(
      'Create new customer via Zalo-OA',
      name: 'create_new_customers_via_Zalo_OA',
      desc: '',
      args: [],
    );
  }

  /// `The feature is only available on the Order Tab`
  String get only_available_on_the_Order_Tab {
    return Intl.message(
      'The feature is only available on the Order Tab',
      name: 'only_available_on_the_Order_Tab',
      desc: '',
      args: [],
    );
  }

  /// `Code validation enabled`
  String get code_validation_enabled {
    return Intl.message(
      'Code validation enabled',
      name: 'code_validation_enabled',
      desc: '',
      args: [],
    );
  }

  /// `Authentication unlocked`
  String get authentication_unlocked {
    return Intl.message(
      'Authentication unlocked',
      name: 'authentication_unlocked',
      desc: '',
      args: [],
    );
  }

  /// `Reload list`
  String get reload_list {
    return Intl.message(
      'Reload list',
      name: 'reload_list',
      desc: '',
      args: [],
    );
  }

  /// `The data has been updated!`
  String get data_updated {
    return Intl.message(
      'The data has been updated!',
      name: 'data_updated',
      desc: '',
      args: [],
    );
  }

  /// `Accumulated money`
  String get accumulated_money {
    return Intl.message(
      'Accumulated money',
      name: 'accumulated_money',
      desc: '',
      args: [],
    );
  }

  /// `View order - cancellation history`
  String get view_order_and_cancel_history {
    return Intl.message(
      'View order - cancellation history',
      name: 'view_order_and_cancel_history',
      desc: '',
      args: [],
    );
  }

  /// `Turn`
  String get turn {
    return Intl.message(
      'Turn',
      name: 'turn',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get no_data {
    return Intl.message(
      'No data',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Restore`
  String get restore {
    return Intl.message(
      'Restore',
      name: 'restore',
      desc: '',
      args: [],
    );
  }

  /// `Enter quantity`
  String get enter_quantity {
    return Intl.message(
      'Enter quantity',
      name: 'enter_quantity',
      desc: '',
      args: [],
    );
  }

  /// `Cancellation request is pending`
  String get cancellation_request_is_pending {
    return Intl.message(
      'Cancellation request is pending',
      name: 'cancellation_request_is_pending',
      desc: '',
      args: [],
    );
  }

  /// `Recall`
  String get recall {
    return Intl.message(
      'Recall',
      name: 'recall',
      desc: '',
      args: [],
    );
  }

  /// `Revoke the order cancellation request`
  String get revoke_the_order_cancellation_request {
    return Intl.message(
      'Revoke the order cancellation request',
      name: 'revoke_the_order_cancellation_request',
      desc: '',
      args: [],
    );
  }

  /// `Payment confirmation`
  String get payment_confirmation {
    return Intl.message(
      'Payment confirmation',
      name: 'payment_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to complete and print the bill?`
  String get confirm_payment_tmp {
    return Intl.message(
      'Do you want to complete and print the bill?',
      name: 'confirm_payment_tmp',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation from waiter`
  String get confirmation_from_waiter {
    return Intl.message(
      'Confirmation from waiter',
      name: 'confirmation_from_waiter',
      desc: '',
      args: [],
    );
  }

  /// `Enter note content`
  String get enter_note_content {
    return Intl.message(
      'Enter note content',
      name: 'enter_note_content',
      desc: '',
      args: [],
    );
  }

  /// `Customer gets invoice`
  String get customer_gets_invoice {
    return Intl.message(
      'Customer gets invoice',
      name: 'customer_gets_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Customer reviews`
  String get customer_reviews {
    return Intl.message(
      'Customer reviews',
      name: 'customer_reviews',
      desc: '',
      args: [],
    );
  }

  /// `Assessment questions have not been established`
  String get customer_rating_not_setup {
    return Intl.message(
      'Assessment questions have not been established',
      name: 'customer_rating_not_setup',
      desc: '',
      args: [],
    );
  }

  /// `Customer reviews notes`
  String get customer_reviews_note {
    return Intl.message(
      'Customer reviews notes',
      name: 'customer_reviews_note',
      desc: '',
      args: [],
    );
  }

  /// `We always listen to all your suggestions`
  String get customer_reviews_hint {
    return Intl.message(
      'We always listen to all your suggestions',
      name: 'customer_reviews_hint',
      desc: '',
      args: [],
    );
  }

  /// `Register customers via Zalo-OA`
  String get register_customers_via_zalo_oa {
    return Intl.message(
      'Register customers via Zalo-OA',
      name: 'register_customers_via_zalo_oa',
      desc: '',
      args: [],
    );
  }

  /// `Use Camera/Zalo to scan the code`
  String get use_camera_zalo_to_scan_the_code {
    return Intl.message(
      'Use Camera/Zalo to scan the code',
      name: 'use_camera_zalo_to_scan_the_code',
      desc: '',
      args: [],
    );
  }

  /// `Load code error`
  String get load_code_error {
    return Intl.message(
      'Load code error',
      name: 'load_code_error',
      desc: '',
      args: [],
    );
  }

  /// `Generating code`
  String get generating_code {
    return Intl.message(
      'Generating code',
      name: 'generating_code',
      desc: '',
      args: [],
    );
  }

  /// `Payment success!`
  String get payment_success {
    return Intl.message(
      'Payment success!',
      name: 'payment_success',
      desc: '',
      args: [],
    );
  }

  /// `You have not entered customer information for Bill payment.\nDo you still want to print the bill to complete payment?`
  String get attention_confirm_info_customer {
    return Intl.message(
      'You have not entered customer information for Bill payment.\nDo you still want to print the bill to complete payment?',
      name: 'attention_confirm_info_customer',
      desc: '',
      args: [],
    );
  }

  /// `Continue payment`
  String get continue_payment {
    return Intl.message(
      'Continue payment',
      name: 'continue_payment',
      desc: '',
      args: [],
    );
  }

  /// `Add customer Information`
  String get add_customer_information {
    return Intl.message(
      'Add customer Information',
      name: 'add_customer_information',
      desc: '',
      args: [],
    );
  }

  /// `Error loading invoice data`
  String get error_loading_invoice_data {
    return Intl.message(
      'Error loading invoice data',
      name: 'error_loading_invoice_data',
      desc: '',
      args: [],
    );
  }

  /// `Error loading payment QR code`
  String get error_loading_payment_QR_code {
    return Intl.message(
      'Error loading payment QR code',
      name: 'error_loading_payment_QR_code',
      desc: '',
      args: [],
    );
  }

  /// `N.Dish`
  String get name_of_dish_cut {
    return Intl.message(
      'N.Dish',
      name: 'name_of_dish_cut',
      desc: '',
      args: [],
    );
  }

  /// `U.Price`
  String get price_of_dish_cut {
    return Intl.message(
      'U.Price',
      name: 'price_of_dish_cut',
      desc: '',
      args: [],
    );
  }

  /// `Tax`
  String get tax_of_dish_cut {
    return Intl.message(
      'Tax',
      name: 'tax_of_dish_cut',
      desc: '',
      args: [],
    );
  }

  /// `I.Money`
  String get total_price_of_dish_cut {
    return Intl.message(
      'I.Money',
      name: 'total_price_of_dish_cut',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get reload {
    return Intl.message(
      'Reload',
      name: 'reload',
      desc: '',
      args: [],
    );
  }

  /// `Have you completed payment to the customer?`
  String get confirm_payment_done {
    return Intl.message(
      'Have you completed payment to the customer?',
      name: 'confirm_payment_done',
      desc: '',
      args: [],
    );
  }

  /// `Bank account has not been set up`
  String get bank_account_not_setup {
    return Intl.message(
      'Bank account has not been set up',
      name: 'bank_account_not_setup',
      desc: '',
      args: [],
    );
  }

  /// `Add invoice information`
  String get add_invoice_information {
    return Intl.message(
      'Add invoice information',
      name: 'add_invoice_information',
      desc: '',
      args: [],
    );
  }

  /// `Tax code`
  String get tax_code {
    return Intl.message(
      'Tax code',
      name: 'tax_code',
      desc: '',
      args: [],
    );
  }

  /// `Company name`
  String get company_name {
    return Intl.message(
      'Company name',
      name: 'company_name',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Bank`
  String get bank {
    return Intl.message(
      'Bank',
      name: 'bank',
      desc: '',
      args: [],
    );
  }

  /// `Bank number`
  String get bank_number {
    return Intl.message(
      'Bank number',
      name: 'bank_number',
      desc: '',
      args: [],
    );
  }

  /// `Not be empty`
  String get not_be_empty {
    return Intl.message(
      'Not be empty',
      name: 'not_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Finding by tax code`
  String get finding_by_tax_code {
    return Intl.message(
      'Finding by tax code',
      name: 'finding_by_tax_code',
      desc: '',
      args: [],
    );
  }

  /// `View & update`
  String get view_and_update {
    return Intl.message(
      'View & update',
      name: 'view_and_update',
      desc: '',
      args: [],
    );
  }

  /// `Creating`
  String get creating {
    return Intl.message(
      'Creating',
      name: 'creating',
      desc: '',
      args: [],
    );
  }

  /// `Updating`
  String get updating {
    return Intl.message(
      'Updating',
      name: 'updating',
      desc: '',
      args: [],
    );
  }

  /// `Update invoice information`
  String get update_invoice_information {
    return Intl.message(
      'Update invoice information',
      name: 'update_invoice_information',
      desc: '',
      args: [],
    );
  }

  /// `Complete payment`
  String get complete_payment {
    return Intl.message(
      'Complete payment',
      name: 'complete_payment',
      desc: '',
      args: [],
    );
  }

  /// `Loading invoice information`
  String get loading_order_invoice {
    return Intl.message(
      'Loading invoice information',
      name: 'loading_order_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Error when retrieving invoice information`
  String get error_loading_order_invoice {
    return Intl.message(
      'Error when retrieving invoice information',
      name: 'error_loading_order_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Payment amount`
  String get payment_amount {
    return Intl.message(
      'Payment amount',
      name: 'payment_amount',
      desc: '',
      args: [],
    );
  }

  /// `Transfer content`
  String get transfer_content {
    return Intl.message(
      'Transfer content',
      name: 'transfer_content',
      desc: '',
      args: [],
    );
  }

  /// `Value invalid`
  String get value_invalid {
    return Intl.message(
      'Value invalid',
      name: 'value_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Payment notes`
  String get payment_notes {
    return Intl.message(
      'Payment notes',
      name: 'payment_notes',
      desc: '',
      args: [],
    );
  }

  /// `Note: Once you select Create payment slip, there will be no going back!`
  String get note_after_rating {
    return Intl.message(
      'Note: Once you select Create payment slip, there will be no going back!',
      name: 'note_after_rating',
      desc: '',
      args: [],
    );
  }

  /// `Discount vouchers`
  String get voucher_discount {
    return Intl.message(
      'Discount vouchers',
      name: 'voucher_discount',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Please check again`
  String get confirm_rating_to_payment_pre {
    return Intl.message(
      'Please check again',
      name: 'confirm_rating_to_payment_pre',
      desc: '',
      args: [],
    );
  }

  /// `before Creating bill payment`
  String get confirm_rating_to_payment_post {
    return Intl.message(
      'before Creating bill payment',
      name: 'confirm_rating_to_payment_post',
      desc: '',
      args: [],
    );
  }

  /// `Total amount dish selected`
  String get total_amount_dish_selected {
    return Intl.message(
      'Total amount dish selected',
      name: 'total_amount_dish_selected',
      desc: '',
      args: [],
    );
  }

  /// `Come back`
  String get come_back {
    return Intl.message(
      'Come back',
      name: 'come_back',
      desc: '',
      args: [],
    );
  }

  /// `Create invoices`
  String get create_invoices {
    return Intl.message(
      'Create invoices',
      name: 'create_invoices',
      desc: '',
      args: [],
    );
  }

  /// `Customer survey`
  String get customer_survey {
    return Intl.message(
      'Customer survey',
      name: 'customer_survey',
      desc: '',
      args: [],
    );
  }

  /// `Bill`
  String get bill {
    return Intl.message(
      'Bill',
      name: 'bill',
      desc: '',
      args: [],
    );
  }

  /// `Confirm creation of bill payment`
  String get confirm_creation_of_bill_payment {
    return Intl.message(
      'Confirm creation of bill payment',
      name: 'confirm_creation_of_bill_payment',
      desc: '',
      args: [],
    );
  }

  /// `Customer information`
  String get customer_information {
    return Intl.message(
      'Customer information',
      name: 'customer_information',
      desc: '',
      args: [],
    );
  }

  /// `Create bill payment`
  String get create_bill_payment {
    return Intl.message(
      'Create bill payment',
      name: 'create_bill_payment',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_text {
    return Intl.message(
      'Continue',
      name: 'continue_text',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant chain belonging to Aladdin.,JSC`
  String get restaurant_slogan {
    return Intl.message(
      'Restaurant chain belonging to Aladdin.,JSC',
      name: 'restaurant_slogan',
      desc: '',
      args: [],
    );
  }

  /// `An Vu rice paper`
  String get btav {
    return Intl.message(
      'An Vu rice paper',
      name: 'btav',
      desc: '',
      args: [],
    );
  }

  /// `Hanoi's specialty roasted pork rice paper`
  String get btav_slogan {
    return Intl.message(
      'Hanoi\'s specialty roasted pork rice paper',
      name: 'btav_slogan',
      desc: '',
      args: [],
    );
  }

  /// `Pay bills`
  String get pay_bills {
    return Intl.message(
      'Pay bills',
      name: 'pay_bills',
      desc: '',
      args: [],
    );
  }

  /// `Error downloading QR Code`
  String get qr_code_loading_error {
    return Intl.message(
      'Error downloading QR Code',
      name: 'qr_code_loading_error',
      desc: '',
      args: [],
    );
  }

  /// `No QR code`
  String get no_qr_code {
    return Intl.message(
      'No QR code',
      name: 'no_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `Submit a review`
  String get submit_a_review {
    return Intl.message(
      'Submit a review',
      name: 'submit_a_review',
      desc: '',
      args: [],
    );
  }

  /// `Skip review`
  String get skip_review {
    return Intl.message(
      'Skip review',
      name: 'skip_review',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to skip the review?`
  String get skip_review_confirm {
    return Intl.message(
      'Are you sure you want to skip the review?',
      name: 'skip_review_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for rating!`
  String get thank_for_rating {
    return Intl.message(
      'Thank you for rating!',
      name: 'thank_for_rating',
      desc: '',
      args: [],
    );
  }

  /// `Review is empty`
  String get review_is_empty {
    return Intl.message(
      'Review is empty',
      name: 'review_is_empty',
      desc: '',
      args: [],
    );
  }

  /// `Submitting your review`
  String get submitting_your_review {
    return Intl.message(
      'Submitting your review',
      name: 'submitting_your_review',
      desc: '',
      args: [],
    );
  }

  /// `Payment method`
  String get payment_method {
    return Intl.message(
      'Payment method',
      name: 'payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Loading payment method`
  String get loading_payment_method {
    return Intl.message(
      'Loading payment method',
      name: 'loading_payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Error loading payment method`
  String get error_payment_method {
    return Intl.message(
      'Error loading payment method',
      name: 'error_payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Payment method is empty`
  String get payment_method_is_empty {
    return Intl.message(
      'Payment method is empty',
      name: 'payment_method_is_empty',
      desc: '',
      args: [],
    );
  }

  /// `Payment method has not been selected`
  String get payment_method_not_select {
    return Intl.message(
      'Payment method has not been selected',
      name: 'payment_method_not_select',
      desc: '',
      args: [],
    );
  }

  /// `Haven't selected a bank account yet`
  String get bank_not_select {
    return Intl.message(
      'Haven\'t selected a bank account yet',
      name: 'bank_not_select',
      desc: '',
      args: [],
    );
  }

  /// `Select a payment method`
  String get select_a_payment_method {
    return Intl.message(
      'Select a payment method',
      name: 'select_a_payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Select a bank`
  String get select_a_bank {
    return Intl.message(
      'Select a bank',
      name: 'select_a_bank',
      desc: '',
      args: [],
    );
  }

  /// `Email address is not valid`
  String get email_invalid {
    return Intl.message(
      'Email address is not valid',
      name: 'email_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is not valid`
  String get phone_invalid {
    return Intl.message(
      'Phone number is not valid',
      name: 'phone_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Error updating the currently selected item.\nIf reloading fails, go to personal menu > Clear cache and try again.`
  String get error_reload_menu_check_product_selecting {
    return Intl.message(
      'Error updating the currently selected item.\nIf reloading fails, go to personal menu > Clear cache and try again.',
      name: 'error_reload_menu_check_product_selecting',
      desc: '',
      args: [],
    );
  }

  /// `Problem`
  String get ex_problem {
    return Intl.message(
      'Problem',
      name: 'ex_problem',
      desc: '',
      args: [],
    );
  }

  /// `Authentication error\nAccount or password is incorrect`
  String get login_unauthorized_message {
    return Intl.message(
      'Authentication error\nAccount or password is incorrect',
      name: 'login_unauthorized_message',
      desc: '',
      args: [],
    );
  }

  /// `Customer Portrait`
  String get customer_portrait {
    return Intl.message(
      'Customer Portrait',
      name: 'customer_portrait',
      desc: '',
      args: [],
    );
  }

  /// `Select customer portrait`
  String get customer_portrait_select_portrait_group {
    return Intl.message(
      'Select customer portrait',
      name: 'customer_portrait_select_portrait_group',
      desc: '',
      args: [],
    );
  }

  /// `Customer portrait not setup, please login again!`
  String get customer_portrait_not_setup {
    return Intl.message(
      'Customer portrait not setup, please login again!',
      name: 'customer_portrait_not_setup',
      desc: '',
      args: [],
    );
  }

  /// `Customer portrait has not been selected`
  String get customer_portrait_has_not_been_selected {
    return Intl.message(
      'Customer portrait has not been selected',
      name: 'customer_portrait_has_not_been_selected',
      desc: '',
      args: [],
    );
  }

  /// `Creating customers`
  String get creating_customer {
    return Intl.message(
      'Creating customers',
      name: 'creating_customer',
      desc: '',
      args: [],
    );
  }

  /// `Discount code is being applied`
  String get applied_policy {
    return Intl.message(
      'Discount code is being applied',
      name: 'applied_policy',
      desc: '',
      args: [],
    );
  }

  /// `Closing payment`
  String get closing_order_payment {
    return Intl.message(
      'Closing payment',
      name: 'closing_order_payment',
      desc: '',
      args: [],
    );
  }

  /// `Condition apply`
  String get coupon_condition_apply {
    return Intl.message(
      'Condition apply',
      name: 'coupon_condition_apply',
      desc: '',
      args: [],
    );
  }

  /// `No conditions`
  String get no_conditions {
    return Intl.message(
      'No conditions',
      name: 'no_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Conditions & products apply`
  String get conditions_and_products_apply {
    return Intl.message(
      'Conditions & products apply',
      name: 'conditions_and_products_apply',
      desc: '',
      args: [],
    );
  }

  /// `ATTENTION: Endow has not been applied successfully`
  String get attention_endow_has_not_been_applied_successfully {
    return Intl.message(
      'ATTENTION: Endow has not been applied successfully',
      name: 'attention_endow_has_not_been_applied_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Go to the Endow tab`
  String get go_to_the_endow_tab {
    return Intl.message(
      'Go to the Endow tab',
      name: 'go_to_the_endow_tab',
      desc: '',
      args: [],
    );
  }

  /// `- Move current table to another table -> Deselect the current table and select the table to move\n- Add unused tables to the current table menu -> Just select the table\n- Remove tables from the current table menu -> Uncheck the table to be removed from the list`
  String get content_help_move_table {
    return Intl.message(
      '- Move current table to another table -> Deselect the current table and select the table to move\n- Add unused tables to the current table menu -> Just select the table\n- Remove tables from the current table menu -> Uncheck the table to be removed from the list',
      name: 'content_help_move_table',
      desc: '',
      args: [],
    );
  }

  /// `Transfer current order to another waiter -> Just select the waiter`
  String get content_help_select_waiter {
    return Intl.message(
      'Transfer current order to another waiter -> Just select the waiter',
      name: 'content_help_select_waiter',
      desc: '',
      args: [],
    );
  }

  /// `Current account`
  String get current_account {
    return Intl.message(
      'Current account',
      name: 'current_account',
      desc: '',
      args: [],
    );
  }

  /// `Manage accounts on devices`
  String get manage_accounts_on_devices {
    return Intl.message(
      'Manage accounts on devices',
      name: 'manage_accounts_on_devices',
      desc: '',
      args: [],
    );
  }

  /// `Login accounts have been saved`
  String get login_accounts_have_been_saved {
    return Intl.message(
      'Login accounts have been saved',
      name: 'login_accounts_have_been_saved',
      desc: '',
      args: [],
    );
  }

  /// `Last login`
  String get last_login {
    return Intl.message(
      'Last login',
      name: 'last_login',
      desc: '',
      args: [],
    );
  }

  /// `There are no accounts`
  String get there_are_no_accounts {
    return Intl.message(
      'There are no accounts',
      name: 'there_are_no_accounts',
      desc: '',
      args: [],
    );
  }

  /// `Order to online`
  String get order_to_online {
    return Intl.message(
      'Order to online',
      name: 'order_to_online',
      desc: '',
      args: [],
    );
  }

  /// `Accepted`
  String get accepted {
    return Intl.message(
      'Accepted',
      name: 'accepted',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceled {
    return Intl.message(
      'Canceled',
      name: 'canceled',
      desc: '',
      args: [],
    );
  }

  /// `Reason for cancellation`
  String get cancellation_reason {
    return Intl.message(
      'Reason for cancellation',
      name: 'cancellation_reason',
      desc: '',
      args: [],
    );
  }

  /// `No note`
  String get no_note {
    return Intl.message(
      'No note',
      name: 'no_note',
      desc: '',
      args: [],
    );
  }

  /// `minute(s)`
  String get minutes {
    return Intl.message(
      'minute(s)',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `hour(s)`
  String get hours {
    return Intl.message(
      'hour(s)',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `day(s)`
  String get days {
    return Intl.message(
      'day(s)',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `month(s)`
  String get months {
    return Intl.message(
      'month(s)',
      name: 'months',
      desc: '',
      args: [],
    );
  }

  /// `year(s)`
  String get years {
    return Intl.message(
      'year(s)',
      name: 'years',
      desc: '',
      args: [],
    );
  }

  /// `ago`
  String get time_before {
    return Intl.message(
      'ago',
      name: 'time_before',
      desc: '',
      args: [],
    );
  }

  /// `just done`
  String get just_done {
    return Intl.message(
      'just done',
      name: 'just_done',
      desc: '',
      args: [],
    );
  }

  /// `New order request`
  String get new_order_request {
    return Intl.message(
      'New order request',
      name: 'new_order_request',
      desc: '',
      args: [],
    );
  }

  /// `has a new order request`
  String get has_a_new_order_request {
    return Intl.message(
      'has a new order request',
      name: 'has_a_new_order_request',
      desc: '',
      args: [],
    );
  }

  /// `There are no orders currently`
  String get no_orders {
    return Intl.message(
      'There are no orders currently',
      name: 'no_orders',
      desc: '',
      args: [],
    );
  }

  /// `Latest`
  String get latest {
    return Intl.message(
      'Latest',
      name: 'latest',
      desc: '',
      args: [],
    );
  }

  /// `Oldest`
  String get oldest {
    return Intl.message(
      'Oldest',
      name: 'oldest',
      desc: '',
      args: [],
    );
  }

  /// `Loading request list`
  String get loading_request_list {
    return Intl.message(
      'Loading request list',
      name: 'loading_request_list',
      desc: '',
      args: [],
    );
  }

  /// `Canceling request`
  String get canceling_request {
    return Intl.message(
      'Canceling request',
      name: 'canceling_request',
      desc: '',
      args: [],
    );
  }

  /// `An error has occurred.`
  String get an_error_has_occurred {
    return Intl.message(
      'An error has occurred.',
      name: 'an_error_has_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Please try again`
  String get please_try_again {
    return Intl.message(
      'Please try again',
      name: 'please_try_again',
      desc: '',
      args: [],
    );
  }

  /// `QR code to order food at the table`
  String get qr_order_to_online {
    return Intl.message(
      'QR code to order food at the table',
      name: 'qr_order_to_online',
      desc: '',
      args: [],
    );
  }

  /// `View order QR code`
  String get view_order_qr {
    return Intl.message(
      'View order QR code',
      name: 'view_order_qr',
      desc: '',
      args: [],
    );
  }

  /// `There are currently no orders to confirm!`
  String get no_orders_to_confirm {
    return Intl.message(
      'There are currently no orders to confirm!',
      name: 'no_orders_to_confirm',
      desc: '',
      args: [],
    );
  }

  /// `There are no previously confirmed order requests`
  String get no_previously_confirmed_order_requests {
    return Intl.message(
      'There are no previously confirmed order requests',
      name: 'no_previously_confirmed_order_requests',
      desc: '',
      args: [],
    );
  }

  /// `No orders have been cancelled`
  String get no_orders_have_been_cancelled {
    return Intl.message(
      'No orders have been cancelled',
      name: 'no_orders_have_been_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Printing QR code`
  String get printing_QR_code {
    return Intl.message(
      'Printing QR code',
      name: 'printing_QR_code',
      desc: '',
      args: [],
    );
  }

  /// `Print the QR code to order at the table successfully`
  String get print_QR_code_o2o_success {
    return Intl.message(
      'Print the QR code to order at the table successfully',
      name: 'print_QR_code_o2o_success',
      desc: '',
      args: [],
    );
  }

  /// `At the printer`
  String get at_the_printer {
    return Intl.message(
      'At the printer',
      name: 'at_the_printer',
      desc: '',
      args: [],
    );
  }

  /// `Retrieving printer list`
  String get retrieving_printer_list {
    return Intl.message(
      'Retrieving printer list',
      name: 'retrieving_printer_list',
      desc: '',
      args: [],
    );
  }

  /// `The table is waiting for payment`
  String get table_waiting_for_payment {
    return Intl.message(
      'The table is waiting for payment',
      name: 'table_waiting_for_payment',
      desc: '',
      args: [],
    );
  }

  /// `Print QR`
  String get print_QR {
    return Intl.message(
      'Print QR',
      name: 'print_QR',
      desc: '',
      args: [],
    );
  }

  /// `Print`
  String get print {
    return Intl.message(
      'Print',
      name: 'print',
      desc: '',
      args: [],
    );
  }

  /// `There are no printers`
  String get no_printers {
    return Intl.message(
      'There are no printers',
      name: 'no_printers',
      desc: '',
      args: [],
    );
  }

  /// `Choose a QR printer to order at the table`
  String get choose_printer_o2o {
    return Intl.message(
      'Choose a QR printer to order at the table',
      name: 'choose_printer_o2o',
      desc: '',
      args: [],
    );
  }

  /// `The order is temporarily locked because the payment slip is being opened.`
  String get temporarily_locked_order {
    return Intl.message(
      'The order is temporarily locked because the payment slip is being opened.',
      name: 'temporarily_locked_order',
      desc: '',
      args: [],
    );
  }

  /// `Please check other devices using the same order!`
  String get msg_check_other_devices_using_the_same_order {
    return Intl.message(
      'Please check other devices using the same order!',
      name: 'msg_check_other_devices_using_the_same_order',
      desc: '',
      args: [],
    );
  }

  /// `Check the order status again`
  String get check_the_order_status_again {
    return Intl.message(
      'Check the order status again',
      name: 'check_the_order_status_again',
      desc: '',
      args: [],
    );
  }

  /// `Tian Long`
  String get tianLong {
    return Intl.message(
      'Tian Long',
      name: 'tianLong',
      desc: '',
      args: [],
    );
  }

  /// `Chaozhou fresh beef hotpot`
  String get tianLongSlogan {
    return Intl.message(
      'Chaozhou fresh beef hotpot',
      name: 'tianLongSlogan',
      desc: '',
      args: [],
    );
  }

  /// `Select all`
  String get select_all {
    return Intl.message(
      'Select all',
      name: 'select_all',
      desc: '',
      args: [],
    );
  }

  /// `Cashier note`
  String get note_the_dish {
    return Intl.message(
      'Cashier note',
      name: 'note_the_dish',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation content`
  String get confirmation_content {
    return Intl.message(
      'Confirmation content',
      name: 'confirmation_content',
      desc: '',
      args: [],
    );
  }

  /// `No request`
  String get no_o2o_request {
    return Intl.message(
      'No request',
      name: 'no_o2o_request',
      desc: '',
      args: [],
    );
  }

  /// `Call staff`
  String get call_staff {
    return Intl.message(
      'Call staff',
      name: 'call_staff',
      desc: '',
      args: [],
    );
  }

  /// `Request payment`
  String get request_payment {
    return Intl.message(
      'Request payment',
      name: 'request_payment',
      desc: '',
      args: [],
    );
  }

  /// `Chat with customers`
  String get chat_with_customers {
    return Intl.message(
      'Chat with customers',
      name: 'chat_with_customers',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load chat content`
  String get unable_to_load_chat_content {
    return Intl.message(
      'Unable to load chat content',
      name: 'unable_to_load_chat_content',
      desc: '',
      args: [],
    );
  }

  /// `No messages`
  String get no_messages {
    return Intl.message(
      'No messages',
      name: 'no_messages',
      desc: '',
      args: [],
    );
  }

  /// `Request service`
  String get request_service {
    return Intl.message(
      'Request service',
      name: 'request_service',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get content {
    return Intl.message(
      'Content',
      name: 'content',
      desc: '',
      args: [],
    );
  }

  /// `Calls for payment`
  String get request_payment_1 {
    return Intl.message(
      'Calls for payment',
      name: 'request_payment_1',
      desc: '',
      args: [],
    );
  }

  /// `Hai Su Pot rice`
  String get hai_su_pot_rice {
    return Intl.message(
      'Hai Su Pot rice',
      name: 'hai_su_pot_rice',
      desc: '',
      args: [],
    );
  }

  /// `Request list`
  String get list_request_o2o {
    return Intl.message(
      'Request list',
      name: 'list_request_o2o',
      desc: '',
      args: [],
    );
  }

  /// `Loading payment gateway URL`
  String get loading_payment_gateway_url {
    return Intl.message(
      'Loading payment gateway URL',
      name: 'loading_payment_gateway_url',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending_reser {
    return Intl.message(
      'Pending',
      name: 'pending_reser',
      desc: '',
      args: [],
    );
  }

  /// `Accepted`
  String get accepted_reser {
    return Intl.message(
      'Accepted',
      name: 'accepted_reser',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceled_reser {
    return Intl.message(
      'Canceled',
      name: 'canceled_reser',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get rejected_reser {
    return Intl.message(
      'Rejected',
      name: 'rejected_reser',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed_reser {
    return Intl.message(
      'Completed',
      name: 'completed_reser',
      desc: '',
      args: [],
    );
  }

  /// `Guests are using the service`
  String get processing_reser {
    return Intl.message(
      'Guests are using the service',
      name: 'processing_reser',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Search for table reservations`
  String get search_reservation {
    return Intl.message(
      'Search for table reservations',
      name: 'search_reservation',
      desc: '',
      args: [],
    );
  }

  /// `No reservations found!`
  String get no_reservations {
    return Intl.message(
      'No reservations found!',
      name: 'no_reservations',
      desc: '',
      args: [],
    );
  }

  /// `Loading the reservations...`
  String get loading_reservations {
    return Intl.message(
      'Loading the reservations...',
      name: 'loading_reservations',
      desc: '',
      args: [],
    );
  }

  /// `Choose reservation`
  String get choose_reservation {
    return Intl.message(
      'Choose reservation',
      name: 'choose_reservation',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load table list! Please try again.`
  String get error_get_reservations {
    return Intl.message(
      'Unable to load table list! Please try again.',
      name: 'error_get_reservations',
      desc: '',
      args: [],
    );
  }

  /// `Payment method does not apply`
  String get payment_method_does_not_apply {
    return Intl.message(
      'Payment method does not apply',
      name: 'payment_method_does_not_apply',
      desc: '',
      args: [],
    );
  }

  /// `Shift closing`
  String get shift_closing {
    return Intl.message(
      'Shift closing',
      name: 'shift_closing',
      desc: '',
      args: [],
    );
  }

  /// `The registration link is currently unavailable.`
  String get unvailable_link_registration_zalo_oa {
    return Intl.message(
      'The registration link is currently unavailable.',
      name: 'unvailable_link_registration_zalo_oa',
      desc: '',
      args: [],
    );
  }

  /// `Table order history`
  String get table_order_history {
    return Intl.message(
      'Table order history',
      name: 'table_order_history',
      desc: '',
      args: [],
    );
  }

  /// `Customer screen`
  String get customer_screen {
    return Intl.message(
      'Customer screen',
      name: 'customer_screen',
      desc: '',
      args: [],
    );
  }

  /// `Server status`
  String get server_status {
    return Intl.message(
      'Server status',
      name: 'server_status',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Connection lost`
  String get connection_lost {
    return Intl.message(
      'Connection lost',
      name: 'connection_lost',
      desc: '',
      args: [],
    );
  }

  /// `The payment receipt is being reprinted...`
  String get msg_reprint_payment_receipt {
    return Intl.message(
      'The payment receipt is being reprinted...',
      name: 'msg_reprint_payment_receipt',
      desc: '',
      args: [],
    );
  }

  /// `Reprinting kitchen order...`
  String get msg_reprinting_kitchen_order {
    return Intl.message(
      'Reprinting kitchen order...',
      name: 'msg_reprinting_kitchen_order',
      desc: '',
      args: [],
    );
  }

  /// `Completing the table order...`
  String get msg_completing_order {
    return Intl.message(
      'Completing the table order...',
      name: 'msg_completing_order',
      desc: '',
      args: [],
    );
  }

  /// `Order code`
  String get order_code {
    return Intl.message(
      'Order code',
      name: 'order_code',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Voucher`
  String get voucher {
    return Intl.message(
      'Voucher',
      name: 'voucher',
      desc: '',
      args: [],
    );
  }

  /// `Method`
  String get method {
    return Intl.message(
      'Method',
      name: 'method',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `The orders of the day`
  String get order_of_the_day {
    return Intl.message(
      'The orders of the day',
      name: 'order_of_the_day',
      desc: '',
      args: [],
    );
  }

  /// `Unable to retrieve payment information for the table order.`
  String get msg_unable_retrieve_payment_info {
    return Intl.message(
      'Unable to retrieve payment information for the table order.',
      name: 'msg_unable_retrieve_payment_info',
      desc: '',
      args: [],
    );
  }

  /// `Please select a table order before proceeding to complete.`
  String get msg_select_order_before_complete {
    return Intl.message(
      'Please select a table order before proceeding to complete.',
      name: 'msg_select_order_before_complete',
      desc: '',
      args: [],
    );
  }

  /// `Please select a table order before printing the payment receipt.`
  String get msg_select_order_before_print_receipt {
    return Intl.message(
      'Please select a table order before printing the payment receipt.',
      name: 'msg_select_order_before_print_receipt',
      desc: '',
      args: [],
    );
  }

  /// `Unable to print the receipt for the customer.`
  String get msg_error_print_receipt {
    return Intl.message(
      'Unable to print the receipt for the customer.',
      name: 'msg_error_print_receipt',
      desc: '',
      args: [],
    );
  }

  /// `Search by order code, customer name, phone number, or voucher...`
  String get search_order_history {
    return Intl.message(
      'Search by order code, customer name, phone number, or voucher...',
      name: 'search_order_history',
      desc: '',
      args: [],
    );
  }

  /// `Order details`
  String get order_detail {
    return Intl.message(
      'Order details',
      name: 'order_detail',
      desc: '',
      args: [],
    );
  }

  /// `Complete the order`
  String get complete_order {
    return Intl.message(
      'Complete the order',
      name: 'complete_order',
      desc: '',
      args: [],
    );
  }

  /// `Item`
  String get item {
    return Intl.message(
      'Item',
      name: 'item',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Tax`
  String get tax {
    return Intl.message(
      'Tax',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `List of dishes`
  String get list_dish {
    return Intl.message(
      'List of dishes',
      name: 'list_dish',
      desc: '',
      args: [],
    );
  }

  /// `No dishes have been ordered`
  String get no_dish_order {
    return Intl.message(
      'No dishes have been ordered',
      name: 'no_dish_order',
      desc: '',
      args: [],
    );
  }

  /// `List of vouchers`
  String get list_voucher {
    return Intl.message(
      'List of vouchers',
      name: 'list_voucher',
      desc: '',
      args: [],
    );
  }

  /// `Payment infomation`
  String get payment_info {
    return Intl.message(
      'Payment infomation',
      name: 'payment_info',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Attached image`
  String get attached_image {
    return Intl.message(
      'Attached image',
      name: 'attached_image',
      desc: '',
      args: [],
    );
  }

  /// `The menu is currently empty.`
  String get no_product {
    return Intl.message(
      'The menu is currently empty.',
      name: 'no_product',
      desc: '',
      args: [],
    );
  }

  /// `Unable to retrieve the latest order data.`
  String get msg_unable_retrieve_latest_order_data {
    return Intl.message(
      'Unable to retrieve the latest order data.',
      name: 'msg_unable_retrieve_latest_order_data',
      desc: '',
      args: [],
    );
  }

  /// `The order is temporarily locked due to an open payment receipt.`
  String get msg_locked_order {
    return Intl.message(
      'The order is temporarily locked due to an open payment receipt.',
      name: 'msg_locked_order',
      desc: '',
      args: [],
    );
  }

  /// `Unlock`
  String get unlock {
    return Intl.message(
      'Unlock',
      name: 'unlock',
      desc: '',
      args: [],
    );
  }

  /// `Please identify the device that opened the payment receipt in order to unlock the order.`
  String get msg_id_device_to_unlock_order {
    return Intl.message(
      'Please identify the device that opened the payment receipt in order to unlock the order.',
      name: 'msg_id_device_to_unlock_order',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load the table order list.`
  String get unable_load_order_list {
    return Intl.message(
      'Unable to load the table order list.',
      name: 'unable_load_order_list',
      desc: '',
      args: [],
    );
  }

  /// `Total note`
  String get total_note {
    return Intl.message(
      'Total note',
      name: 'total_note',
      desc: '',
      args: [],
    );
  }

  /// `Please remove and re-enter the discount code ([{coupon}]) before applying!`
  String msg_delete_coupon_and_apply_again(String coupon) {
    return Intl.message(
      'Please remove and re-enter the discount code ([$coupon]) before applying!',
      name: 'msg_delete_coupon_and_apply_again',
      desc: '',
      args: [coupon],
    );
  }

  /// `The discount code has been applied to an item in the canceled list.`
  String get discount_code_applied_item_in_canceled_list {
    return Intl.message(
      'The discount code has been applied to an item in the canceled list.',
      name: 'discount_code_applied_item_in_canceled_list',
      desc: '',
      args: [],
    );
  }

  /// `If you cancel an item, the discount code will be canceled as well. You will need to re-enter the discount code to apply it to another item (if any).`
  String get msg_remind_apply_coupon_again {
    return Intl.message(
      'If you cancel an item, the discount code will be canceled as well. You will need to re-enter the discount code to apply it to another item (if any).',
      name: 'msg_remind_apply_coupon_again',
      desc: '',
      args: [],
    );
  }

  /// `Please check other devices using the same table order!`
  String get check_other_device_locked_order {
    return Intl.message(
      'Please check other devices using the same table order!',
      name: 'check_other_device_locked_order',
      desc: '',
      args: [],
    );
  }

  /// `Please order before proceeding with the payment.`
  String get order_before_payment {
    return Intl.message(
      'Please order before proceeding with the payment.',
      name: 'order_before_payment',
      desc: '',
      args: [],
    );
  }

  /// `Customer details have not been entered. Would you like to continue with the payment?`
  String get noti_enter_customer_info {
    return Intl.message(
      'Customer details have not been entered. Would you like to continue with the payment?',
      name: 'noti_enter_customer_info',
      desc: '',
      args: [],
    );
  }

  /// `The list of dishes has not been updated in the system!`
  String get error_update_order_item {
    return Intl.message(
      'The list of dishes has not been updated in the system!',
      name: 'error_update_order_item',
      desc: '',
      args: [],
    );
  }

  /// `Please wait a moment and try again.`
  String get wait_a_moment_and_try_again {
    return Intl.message(
      'Please wait a moment and try again.',
      name: 'wait_a_moment_and_try_again',
      desc: '',
      args: [],
    );
  }

  /// `Payment is only available after the discount has been successfully applied.`
  String get payment_available_after_apply_discount_success {
    return Intl.message(
      'Payment is only available after the discount has been successfully applied.',
      name: 'payment_available_after_apply_discount_success',
      desc: '',
      args: [],
    );
  }

  /// `Navigate to the Endow`
  String get go_to_endow {
    return Intl.message(
      'Navigate to the Endow',
      name: 'go_to_endow',
      desc: '',
      args: [],
    );
  }

  /// `Shift closed successfully.`
  String get closing_shift_success {
    return Intl.message(
      'Shift closed successfully.',
      name: 'closing_shift_success',
      desc: '',
      args: [],
    );
  }

  /// `Order not found`
  String get order_not_found {
    return Intl.message(
      'Order not found',
      name: 'order_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Automatic order transfer/update failed.\nPlease select the order again!`
  String get error_change_order {
    return Intl.message(
      'Automatic order transfer/update failed.\nPlease select the order again!',
      name: 'error_change_order',
      desc: '',
      args: [],
    );
  }

  /// `Failed to transfer the account.`
  String get error_transfer_account {
    return Intl.message(
      'Failed to transfer the account.',
      name: 'error_transfer_account',
      desc: '',
      args: [],
    );
  }

  /// `Unable to add the customer to the system.`
  String get unable_add_customer {
    return Intl.message(
      'Unable to add the customer to the system.',
      name: 'unable_add_customer',
      desc: '',
      args: [],
    );
  }

  /// `Failed to apply the discount code`
  String get failed_apply_discount_code {
    return Intl.message(
      'Failed to apply the discount code',
      name: 'failed_apply_discount_code',
      desc: '',
      args: [],
    );
  }

  /// `Payment closing failed!`
  String get failed_payment_closing {
    return Intl.message(
      'Payment closing failed!',
      name: 'failed_payment_closing',
      desc: '',
      args: [],
    );
  }

  /// `The [{coupon_length}] discount codes [{coupons}] cannot be used with the payment method ([{payment_method}]).\nPlease remove the codes or choose a different payment method!`
  String msg_coupons_invalid_with_payment_method(
      String coupon_length, String coupons, String payment_method) {
    return Intl.message(
      'The [$coupon_length] discount codes [$coupons] cannot be used with the payment method ([$payment_method]).\nPlease remove the codes or choose a different payment method!',
      name: 'msg_coupons_invalid_with_payment_method',
      desc: '',
      args: [coupon_length, coupons, payment_method],
    );
  }

  /// `Cannot check the payment method!`
  String get can_not_check_payment_method {
    return Intl.message(
      'Cannot check the payment method!',
      name: 'can_not_check_payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Unable to remove the customer from the current order.`
  String get error_remove_customer_order {
    return Intl.message(
      'Unable to remove the customer from the current order.',
      name: 'error_remove_customer_order',
      desc: '',
      args: [],
    );
  }

  /// `Unable to send the bill to the kitchen.`
  String get unable_send_bill_kitchen {
    return Intl.message(
      'Unable to send the bill to the kitchen.',
      name: 'unable_send_bill_kitchen',
      desc: '',
      args: [],
    );
  }

  /// `No POS machine selected for payment.`
  String get no_select_pos_machine {
    return Intl.message(
      'No POS machine selected for payment.',
      name: 'no_select_pos_machine',
      desc: '',
      args: [],
    );
  }

  /// `Completing payment verification...`
  String get completing_payment_verification {
    return Intl.message(
      'Completing payment verification...',
      name: 'completing_payment_verification',
      desc: '',
      args: [],
    );
  }

  /// `The dialog will automatically close after`
  String get dialog_auto_close_after {
    return Intl.message(
      'The dialog will automatically close after',
      name: 'dialog_auto_close_after',
      desc: '',
      args: [],
    );
  }

  /// `Payment completed successfully!`
  String get payment_successful {
    return Intl.message(
      'Payment completed successfully!',
      name: 'payment_successful',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for choosing [{restaurant_name}]! We wish you a delicious meal!`
  String msg_thanks_customer(String restaurant_name) {
    return Intl.message(
      'Thank you for choosing [$restaurant_name]! We wish you a delicious meal!',
      name: 'msg_thanks_customer',
      desc: '',
      args: [restaurant_name],
    );
  }

  /// `Table is being served`
  String get table_served {
    return Intl.message(
      'Table is being served',
      name: 'table_served',
      desc: '',
      args: [],
    );
  }

  /// `Deny`
  String get deny {
    return Intl.message(
      'Deny',
      name: 'deny',
      desc: '',
      args: [],
    );
  }

  /// `Allow`
  String get allow {
    return Intl.message(
      'Allow',
      name: 'allow',
      desc: '',
      args: [],
    );
  }

  /// `WebView permission requested`
  String get webview_permission_request {
    return Intl.message(
      'WebView permission requested',
      name: 'webview_permission_request',
      desc: '',
      args: [],
    );
  }

  /// `WebView has requested permission`
  String get webview_permission_request_1 {
    return Intl.message(
      'WebView has requested permission',
      name: 'webview_permission_request_1',
      desc: '',
      args: [],
    );
  }

  /// `QR code is loading`
  String get loading_qr_code {
    return Intl.message(
      'QR code is loading',
      name: 'loading_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load QR code`
  String get error_loading_qr_code {
    return Intl.message(
      'Unable to load QR code',
      name: 'error_loading_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `Remaining time`
  String get remaining_time {
    return Intl.message(
      'Remaining time',
      name: 'remaining_time',
      desc: '',
      args: [],
    );
  }

  /// `Chinese`
  String get chinese {
    return Intl.message(
      'Chinese',
      name: 'chinese',
      desc: '',
      args: [],
    );
  }

  /// `Processing payment`
  String get processing_payment {
    return Intl.message(
      'Processing payment',
      name: 'processing_payment',
      desc: '',
      args: [],
    );
  }

  /// `Switching accounts`
  String get switching_accounts {
    return Intl.message(
      'Switching accounts',
      name: 'switching_accounts',
      desc: '',
      args: [],
    );
  }

  /// `Switched to account`
  String get switched_accounts {
    return Intl.message(
      'Switched to account',
      name: 'switched_accounts',
      desc: '',
      args: [],
    );
  }

  /// `Checking payment method`
  String get checking_payment_method {
    return Intl.message(
      'Checking payment method',
      name: 'checking_payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Removing customer...`
  String get removing_customer {
    return Intl.message(
      'Removing customer...',
      name: 'removing_customer',
      desc: '',
      args: [],
    );
  }

  /// `Transmitting order to kitchen...`
  String get sending_bill_kitchen {
    return Intl.message(
      'Transmitting order to kitchen...',
      name: 'sending_bill_kitchen',
      desc: '',
      args: [],
    );
  }

  /// `Completing order...`
  String get completing_order {
    return Intl.message(
      'Completing order...',
      name: 'completing_order',
      desc: '',
      args: [],
    );
  }

  /// `Cancelling item...`
  String get cancelling_item {
    return Intl.message(
      'Cancelling item...',
      name: 'cancelling_item',
      desc: '',
      args: [],
    );
  }

  /// `Sending ticket...`
  String get sending_ticket {
    return Intl.message(
      'Sending ticket...',
      name: 'sending_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Sending command to card terminal...`
  String get sending_command_pos {
    return Intl.message(
      'Sending command to card terminal...',
      name: 'sending_command_pos',
      desc: '',
      args: [],
    );
  }

  /// `System is closing the shift...`
  String get system_closing_shift {
    return Intl.message(
      'System is closing the shift...',
      name: 'system_closing_shift',
      desc: '',
      args: [],
    );
  }

  /// `Updating tax...`
  String get updating_tax {
    return Intl.message(
      'Updating tax...',
      name: 'updating_tax',
      desc: '',
      args: [],
    );
  }

  /// `Payment recognition server is not configured`
  String get error_payment_recognition_server_not_configure {
    return Intl.message(
      'Payment recognition server is not configured',
      name: 'error_payment_recognition_server_not_configure',
      desc: '',
      args: [],
    );
  }

  /// `Payment gateway`
  String get payment_gateway {
    return Intl.message(
      'Payment gateway',
      name: 'payment_gateway',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to reload the payment gateway?`
  String get confirm_reload_payment_gateway {
    return Intl.message(
      'Do you want to reload the payment gateway?',
      name: 'confirm_reload_payment_gateway',
      desc: '',
      args: [],
    );
  }

  /// `The driver has not been initialized`
  String get driver_not_initialized {
    return Intl.message(
      'The driver has not been initialized',
      name: 'driver_not_initialized',
      desc: '',
      args: [],
    );
  }

  /// `Opening payment gateway, please wait...`
  String get opening_payment_gateway {
    return Intl.message(
      'Opening payment gateway, please wait...',
      name: 'opening_payment_gateway',
      desc: '',
      args: [],
    );
  }

  /// `Failed to connect to the payment verification server`
  String get failed_connect_payment_verification_server {
    return Intl.message(
      'Failed to connect to the payment verification server',
      name: 'failed_connect_payment_verification_server',
      desc: '',
      args: [],
    );
  }

  /// `If the connection fails, please use a different payment method!`
  String get using_other_payment_method_if_failed {
    return Intl.message(
      'If the connection fails, please use a different payment method!',
      name: 'using_other_payment_method_if_failed',
      desc: '',
      args: [],
    );
  }

  /// `Reconnect`
  String get reconnect {
    return Intl.message(
      'Reconnect',
      name: 'reconnect',
      desc: '',
      args: [],
    );
  }

  /// `Connecting to payment verification server...`
  String get connecting_payment_verification_server {
    return Intl.message(
      'Connecting to payment verification server...',
      name: 'connecting_payment_verification_server',
      desc: '',
      args: [],
    );
  }

  /// `The payment gateway will automatically close once the payment is received by the system`
  String get msg_auto_close_payment_gateway {
    return Intl.message(
      'The payment gateway will automatically close once the payment is received by the system',
      name: 'msg_auto_close_payment_gateway',
      desc: '',
      args: [],
    );
  }

  /// `You're about to close the payment gateway manually. Please make sure the customer has completed the payment.`
  String get msg_close_payment_gateway_manually {
    return Intl.message(
      'You\'re about to close the payment gateway manually. Please make sure the customer has completed the payment.',
      name: 'msg_close_payment_gateway_manually',
      desc: '',
      args: [],
    );
  }

  /// `The customer has not paid yet.`
  String get customer_not_paid {
    return Intl.message(
      'The customer has not paid yet.',
      name: 'customer_not_paid',
      desc: '',
      args: [],
    );
  }

  /// `The customer has paid.`
  String get customer_paid {
    return Intl.message(
      'The customer has paid.',
      name: 'customer_paid',
      desc: '',
      args: [],
    );
  }

  /// `If the customer has not paid, the payment method will be canceled after the gateway is closed.`
  String get cancel_payment_method_if_customer_not_paid {
    return Intl.message(
      'If the customer has not paid, the payment method will be canceled after the gateway is closed.',
      name: 'cancel_payment_method_if_customer_not_paid',
      desc: '',
      args: [],
    );
  }

  /// `Update failed, please try again.`
  String get update_app_failed_try_again {
    return Intl.message(
      'Update failed, please try again.',
      name: 'update_app_failed_try_again',
      desc: '',
      args: [],
    );
  }

  /// `Update app`
  String get update_app {
    return Intl.message(
      'Update app',
      name: 'update_app',
      desc: '',
      args: [],
    );
  }

  /// `A new version is available.`
  String get new_version_available {
    return Intl.message(
      'A new version is available.',
      name: 'new_version_available',
      desc: '',
      args: [],
    );
  }

  /// `This is a mandatory update. Please update the app to continue using it.`
  String get mandatory_update {
    return Intl.message(
      'This is a mandatory update. Please update the app to continue using it.',
      name: 'mandatory_update',
      desc: '',
      args: [],
    );
  }

  /// `Version on device`
  String get version_on_device {
    return Intl.message(
      'Version on device',
      name: 'version_on_device',
      desc: '',
      args: [],
    );
  }

  /// `New version information`
  String get new_version_info {
    return Intl.message(
      'New version information',
      name: 'new_version_info',
      desc: '',
      args: [],
    );
  }

  /// `Version code`
  String get version_code {
    return Intl.message(
      'Version code',
      name: 'version_code',
      desc: '',
      args: [],
    );
  }

  /// `Release date`
  String get release_date {
    return Intl.message(
      'Release date',
      name: 'release_date',
      desc: '',
      args: [],
    );
  }

  /// `Please wait until the update process is complete`
  String get wait_updating_complete {
    return Intl.message(
      'Please wait until the update process is complete',
      name: 'wait_updating_complete',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Unable to open the link`
  String get unable_open_link {
    return Intl.message(
      'Unable to open the link',
      name: 'unable_open_link',
      desc: '',
      args: [],
    );
  }

  /// `Download manually`
  String get download_manually {
    return Intl.message(
      'Download manually',
      name: 'download_manually',
      desc: '',
      args: [],
    );
  }

  /// `Please make sure your device is connected to the internet.`
  String get sure_connected_network {
    return Intl.message(
      'Please make sure your device is connected to the internet.',
      name: 'sure_connected_network',
      desc: '',
      args: [],
    );
  }

  /// `Your device is using the latest version.`
  String get using_lastest_version {
    return Intl.message(
      'Your device is using the latest version.',
      name: 'using_lastest_version',
      desc: '',
      args: [],
    );
  }

  /// `Download via browser`
  String get download_via_browser {
    return Intl.message(
      'Download via browser',
      name: 'download_via_browser',
      desc: '',
      args: [],
    );
  }

  /// `Update now`
  String get update_now {
    return Intl.message(
      'Update now',
      name: 'update_now',
      desc: '',
      args: [],
    );
  }

  /// `Downloading... Please wait for the installer to open.`
  String get downloading_update {
    return Intl.message(
      'Downloading... Please wait for the installer to open.',
      name: 'downloading_update',
      desc: '',
      args: [],
    );
  }

  /// `Opening installer, please wait...`
  String get opening_installer {
    return Intl.message(
      'Opening installer, please wait...',
      name: 'opening_installer',
      desc: '',
      args: [],
    );
  }

  /// `Downloading update, please wait...`
  String get downloading_update_1 {
    return Intl.message(
      'Downloading update, please wait...',
      name: 'downloading_update_1',
      desc: '',
      args: [],
    );
  }

  /// `Failed to initialize file`
  String get failed_initialize_file {
    return Intl.message(
      'Failed to initialize file',
      name: 'failed_initialize_file',
      desc: '',
      args: [],
    );
  }

  /// `Unable to open the installer. Please download and install it using your browser.`
  String get unable_open_installer_please_download_browser {
    return Intl.message(
      'Unable to open the installer. Please download and install it using your browser.',
      name: 'unable_open_installer_please_download_browser',
      desc: '',
      args: [],
    );
  }

  /// `Server`
  String get server {
    return Intl.message(
      'Server',
      name: 'server',
      desc: '',
      args: [],
    );
  }

  /// `If the update process doesn't work, please use Google Chrome to download and install it from our website`
  String get note_update_process_note_work {
    return Intl.message(
      'If the update process doesn\'t work, please use Google Chrome to download and install it from our website',
      name: 'note_update_process_note_work',
      desc: '',
      args: [],
    );
  }

  /// `Payment received`
  String get payment_received {
    return Intl.message(
      'Payment received',
      name: 'payment_received',
      desc: '',
      args: [],
    );
  }

  /// `Change returned`
  String get change_returned {
    return Intl.message(
      'Change returned',
      name: 'change_returned',
      desc: '',
      args: [],
    );
  }

  /// `Out of stock`
  String get out_of_stock {
    return Intl.message(
      'Out of stock',
      name: 'out_of_stock',
      desc: '',
      args: [],
    );
  }

  /// `The code is limited to specific payment methods`
  String get code_limit_payment_method {
    return Intl.message(
      'The code is limited to specific payment methods',
      name: 'code_limit_payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Note: Closing this will also close the QR code on the customer's screen.`
  String get note_show_qr_register_zalo_oa {
    return Intl.message(
      'Note: Closing this will also close the QR code on the customer\'s screen.',
      name: 'note_show_qr_register_zalo_oa',
      desc: '',
      args: [],
    );
  }

  /// `Scan information from the Citizen ID`
  String get scan_info_from_id {
    return Intl.message(
      'Scan information from the Citizen ID',
      name: 'scan_info_from_id',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get bod {
    return Intl.message(
      'Date of birth',
      name: 'bod',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth not identified`
  String get no_identified_bod {
    return Intl.message(
      'Date of birth not identified',
      name: 'no_identified_bod',
      desc: '',
      args: [],
    );
  }

  /// `Invalid date of birth format`
  String get dob_not_format {
    return Intl.message(
      'Invalid date of birth format',
      name: 'dob_not_format',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message(
      'Complete',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for payment`
  String get waiting_payment {
    return Intl.message(
      'Waiting for payment',
      name: 'waiting_payment',
      desc: '',
      args: [],
    );
  }

  /// `All payment methods are accepted`
  String get accept_all_payment_method {
    return Intl.message(
      'All payment methods are accepted',
      name: 'accept_all_payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Not`
  String get not {
    return Intl.message(
      'Not',
      name: 'not',
      desc: '',
      args: [],
    );
  }

  /// `applicable to ingredients in Set/Combo`
  String get apply_with_combo_item {
    return Intl.message(
      'applicable to ingredients in Set/Combo',
      name: 'apply_with_combo_item',
      desc: '',
      args: [],
    );
  }

  /// `The order has been paid by the customer!`
  String get paid_order {
    return Intl.message(
      'The order has been paid by the customer!',
      name: 'paid_order',
      desc: '',
      args: [],
    );
  }

  /// `The order is unpaid, please re-select a payment method and continue!`
  String get unpaid_order_select_payment_method_again {
    return Intl.message(
      'The order is unpaid, please re-select a payment method and continue!',
      name: 'unpaid_order_select_payment_method_again',
      desc: '',
      args: [],
    );
  }

  /// `Payment gateway URL load failed`
  String get failed_load_gateway_url {
    return Intl.message(
      'Payment gateway URL load failed',
      name: 'failed_load_gateway_url',
      desc: '',
      args: [],
    );
  }

  /// `Edit tax information`
  String get edit_tax_information {
    return Intl.message(
      'Edit tax information',
      name: 'edit_tax_information',
      desc: '',
      args: [],
    );
  }

  /// `Save and continue payment`
  String get save_and_continue_payment {
    return Intl.message(
      'Save and continue payment',
      name: 'save_and_continue_payment',
      desc: '',
      args: [],
    );
  }

  /// `Please enter non-zero tax for all items before completing order.`
  String get error_edit_tax {
    return Intl.message(
      'Please enter non-zero tax for all items before completing order.',
      name: 'error_edit_tax',
      desc: '',
      args: [],
    );
  }

  /// `No payment bank selected`
  String get no_bank_select {
    return Intl.message(
      'No payment bank selected',
      name: 'no_bank_select',
      desc: '',
      args: [],
    );
  }

  /// `Choose a card machine`
  String get choose_card_machine {
    return Intl.message(
      'Choose a card machine',
      name: 'choose_card_machine',
      desc: '',
      args: [],
    );
  }

  /// `No card reader type selected`
  String get no_card_machine_select {
    return Intl.message(
      'No card reader type selected',
      name: 'no_card_machine_select',
      desc: '',
      args: [],
    );
  }

  /// `Please ask customers to pay via card machine.`
  String get ask_customer_pay_via_card_machine {
    return Intl.message(
      'Please ask customers to pay via card machine.',
      name: 'ask_customer_pay_via_card_machine',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message(
      'Product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `Apply all`
  String get apply_all {
    return Intl.message(
      'Apply all',
      name: 'apply_all',
      desc: '',
      args: [],
    );
  }

  /// `Default`
  String get default_1 {
    return Intl.message(
      'Default',
      name: 'default_1',
      desc: '',
      args: [],
    );
  }

  /// `via POS machine`
  String get via_pos_machine {
    return Intl.message(
      'via POS machine',
      name: 'via_pos_machine',
      desc: '',
      args: [],
    );
  }

  /// `Please check and verify if the customer has paid.\nIf yes, please attach a receipt image for comparison before clicking confirm.`
  String get confirm_before_complete_order {
    return Intl.message(
      'Please check and verify if the customer has paid.\nIf yes, please attach a receipt image for comparison before clicking confirm.',
      name: 'confirm_before_complete_order',
      desc: '',
      args: [],
    );
  }

  /// `The customer has successfully paid but cannot complete the bill.`
  String get payment_done_but_not_complete_order {
    return Intl.message(
      'The customer has successfully paid but cannot complete the bill.',
      name: 'payment_done_but_not_complete_order',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get completed {
    return Intl.message(
      'Complete',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Another time`
  String get another_time {
    return Intl.message(
      'Another time',
      name: 'another_time',
      desc: '',
      args: [],
    );
  }

  /// `Your order is in pending status. Please complete the order to continue.`
  String get pending_order_requried_complete_order {
    return Intl.message(
      'Your order is in pending status. Please complete the order to continue.',
      name: 'pending_order_requried_complete_order',
      desc: '',
      args: [],
    );
  }

  /// `Loading payment methods..`
  String get loading_payment_method_list {
    return Intl.message(
      'Loading payment methods..',
      name: 'loading_payment_method_list',
      desc: '',
      args: [],
    );
  }

  /// `Reselect payment method`
  String get reselect_payment_method {
    return Intl.message(
      'Reselect payment method',
      name: 'reselect_payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Confirm delete code & continue`
  String get confirm_delete_code_and_continue {
    return Intl.message(
      'Confirm delete code & continue',
      name: 'confirm_delete_code_and_continue',
      desc: '',
      args: [],
    );
  }

  /// `Error deleting coupon code`
  String get error_delete_coupon_code {
    return Intl.message(
      'Error deleting coupon code',
      name: 'error_delete_coupon_code',
      desc: '',
      args: [],
    );
  }

  /// `Please delete the code, then choose the payment method again!`
  String get noti_delete_code_and_choose_payment_method_again {
    return Intl.message(
      'Please delete the code, then choose the payment method again!',
      name: 'noti_delete_code_and_choose_payment_method_again',
      desc: '',
      args: [],
    );
  }

  /// `Discount applied failed`
  String get discount_apply_failed {
    return Intl.message(
      'Discount applied failed',
      name: 'discount_apply_failed',
      desc: '',
      args: [],
    );
  }

  /// `Please close the payment slip, review & reapply to continue.`
  String get close_payment_slip_reapply_coupons {
    return Intl.message(
      'Please close the payment slip, review & reapply to continue.',
      name: 'close_payment_slip_reapply_coupons',
      desc: '',
      args: [],
    );
  }

  /// `Amount received`
  String get amount_received {
    return Intl.message(
      'Amount received',
      name: 'amount_received',
      desc: '',
      args: [],
    );
  }

  /// `Money returned to customers`
  String get money_return {
    return Intl.message(
      'Money returned to customers',
      name: 'money_return',
      desc: '',
      args: [],
    );
  }

  /// `The selected method will open the payment gateway.`
  String get payment_method_open_gateway {
    return Intl.message(
      'The selected method will open the payment gateway.',
      name: 'payment_method_open_gateway',
      desc: '',
      args: [],
    );
  }

  /// `not used for promotion`
  String get not_used_promotion {
    return Intl.message(
      'not used for promotion',
      name: 'not_used_promotion',
      desc: '',
      args: [],
    );
  }

  /// `Please remove the coupon code to use the selected method or go back and choose another payment method.`
  String get remove_coupon_or_select_other_payment_method {
    return Intl.message(
      'Please remove the coupon code to use the selected method or go back and choose another payment method.',
      name: 'remove_coupon_or_select_other_payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Bank account`
  String get bank_account {
    return Intl.message(
      'Bank account',
      name: 'bank_account',
      desc: '',
      args: [],
    );
  }

  /// `support invoice`
  String get invoice_support {
    return Intl.message(
      'support invoice',
      name: 'invoice_support',
      desc: '',
      args: [],
    );
  }

  /// `has not been set up yet`
  String get not_set_up {
    return Intl.message(
      'has not been set up yet',
      name: 'not_set_up',
      desc: '',
      args: [],
    );
  }

  /// `The order information`
  String get order_info {
    return Intl.message(
      'The order information',
      name: 'order_info',
      desc: '',
      args: [],
    );
  }

  /// `Machine type`
  String get machine_type {
    return Intl.message(
      'Machine type',
      name: 'machine_type',
      desc: '',
      args: [],
    );
  }

  /// `Getting list of pos machine...`
  String get loading_pos_list {
    return Intl.message(
      'Getting list of pos machine...',
      name: 'loading_pos_list',
      desc: '',
      args: [],
    );
  }

  /// `No pos information`
  String get no_pos_info {
    return Intl.message(
      'No pos information',
      name: 'no_pos_info',
      desc: '',
      args: [],
    );
  }

  /// `Please select a pos to continue.`
  String get select_pos_to_continue {
    return Intl.message(
      'Please select a pos to continue.',
      name: 'select_pos_to_continue',
      desc: '',
      args: [],
    );
  }

  /// `Voucher, ID card, Transfer bill,...`
  String get attached_image_purpose {
    return Intl.message(
      'Voucher, ID card, Transfer bill,...',
      name: 'attached_image_purpose',
      desc: '',
      args: [],
    );
  }

  /// `Take photos with Camera`
  String get take_photo_use_camera {
    return Intl.message(
      'Take photos with Camera',
      name: 'take_photo_use_camera',
      desc: '',
      args: [],
    );
  }

  /// `Select a photo from the library`
  String get select_photo_from_galley {
    return Intl.message(
      'Select a photo from the library',
      name: 'select_photo_from_galley',
      desc: '',
      args: [],
    );
  }

  /// `Invalid image, please select again`
  String get invalid_photo_select_again {
    return Intl.message(
      'Invalid image, please select again',
      name: 'invalid_photo_select_again',
      desc: '',
      args: [],
    );
  }

  /// `Image error, please delete!`
  String get image_error_delete {
    return Intl.message(
      'Image error, please delete!',
      name: 'image_error_delete',
      desc: '',
      args: [],
    );
  }

  /// `Budget relationship unit code`
  String get budget_relationship_unit_code {
    return Intl.message(
      'Budget relationship unit code',
      name: 'budget_relationship_unit_code',
      desc: '',
      args: [],
    );
  }

  /// `Citizen identification card`
  String get citizen_id_card {
    return Intl.message(
      'Citizen identification card',
      name: 'citizen_id_card',
      desc: '',
      args: [],
    );
  }

  /// `Delete information`
  String get delete_info {
    return Intl.message(
      'Delete information',
      name: 'delete_info',
      desc: '',
      args: [],
    );
  }

  /// `Please enter all required information`
  String get require_enter_info {
    return Intl.message(
      'Please enter all required information',
      name: 'require_enter_info',
      desc: '',
      args: [],
    );
  }

  /// `Unable to read information`
  String get can_not_read_info {
    return Intl.message(
      'Unable to read information',
      name: 'can_not_read_info',
      desc: '',
      args: [],
    );
  }

  /// `Feature available only on Tab Order`
  String get not_available_feature {
    return Intl.message(
      'Feature available only on Tab Order',
      name: 'not_available_feature',
      desc: '',
      args: [],
    );
  }

  /// `Minimum number of adults is 1`
  String get error_min_number_of_adults {
    return Intl.message(
      'Minimum number of adults is 1',
      name: 'error_min_number_of_adults',
      desc: '',
      args: [],
    );
  }

  /// `Select up to`
  String get select_up_to {
    return Intl.message(
      'Select up to',
      name: 'select_up_to',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get selected {
    return Intl.message(
      'Selected',
      name: 'selected',
      desc: '',
      args: [],
    );
  }

  /// `Complimentary gift`
  String get complimentary_gift {
    return Intl.message(
      'Complimentary gift',
      name: 'complimentary_gift',
      desc: '',
      args: [],
    );
  }

  /// `There is a free gift code applicable to this item.\nIf canceling, please re-select the item the code will apply to in the Offers section`
  String get warning_delete_item_with_complimentary_gift {
    return Intl.message(
      'There is a free gift code applicable to this item.\nIf canceling, please re-select the item the code will apply to in the Offers section',
      name: 'warning_delete_item_with_complimentary_gift',
      desc: '',
      args: [],
    );
  }

  /// `Confirm change of customer screen language [{title}]?`
  String confirm_change_customer_language(String title) {
    return Intl.message(
      'Confirm change of customer screen language [$title]?',
      name: 'confirm_change_customer_language',
      desc: '',
      args: [title],
    );
  }

  /// `Complimentary item`
  String get complimentary_item {
    return Intl.message(
      'Complimentary item',
      name: 'complimentary_item',
      desc: '',
      args: [],
    );
  }

  /// `Customer Screen Language`
  String get customer_screen_language {
    return Intl.message(
      'Customer Screen Language',
      name: 'customer_screen_language',
      desc: '',
      args: [],
    );
  }

  /// `Application language`
  String get app_language {
    return Intl.message(
      'Application language',
      name: 'app_language',
      desc: '',
      args: [],
    );
  }

  /// `Invalid restaurant information`
  String get invalid_restaurant_info {
    return Intl.message(
      'Invalid restaurant information',
      name: 'invalid_restaurant_info',
      desc: '',
      args: [],
    );
  }

  /// `Error retrieving printer information`
  String get error_retrieving_printer_info {
    return Intl.message(
      'Error retrieving printer information',
      name: 'error_retrieving_printer_info',
      desc: '',
      args: [],
    );
  }

  /// `Unable to get invoice information`
  String get error_get_invoice_info {
    return Intl.message(
      'Unable to get invoice information',
      name: 'error_get_invoice_info',
      desc: '',
      args: [],
    );
  }

  /// `Error in printing bill order`
  String get error_print_bill_order {
    return Intl.message(
      'Error in printing bill order',
      name: 'error_print_bill_order',
      desc: '',
      args: [],
    );
  }

  /// `Unable to identify single-desk printer information\nCHECK CAUSES:\n- The table order has been paid\n- The table order has been changed (Transfer table, update table order)\nPlease check and re-select the table order to operate!`
  String get error_ping_printer {
    return Intl.message(
      'Unable to identify single-desk printer information\nCHECK CAUSES:\n- The table order has been paid\n- The table order has been changed (Transfer table, update table order)\nPlease check and re-select the table order to operate!',
      name: 'error_ping_printer',
      desc: '',
      args: [],
    );
  }

  /// `List of available tables`
  String get empty_orders {
    return Intl.message(
      'List of available tables',
      name: 'empty_orders',
      desc: '',
      args: [],
    );
  }

  /// `Please select a sales person before clicking complete order.`
  String get not_sale_select_before_complete_order {
    return Intl.message(
      'Please select a sales person before clicking complete order.',
      name: 'not_sale_select_before_complete_order',
      desc: '',
      args: [],
    );
  }

  /// `Settings saved!`
  String get settings_saved {
    return Intl.message(
      'Settings saved!',
      name: 'settings_saved',
      desc: '',
      args: [],
    );
  }

  /// `List of sales staff`
  String get list_sales {
    return Intl.message(
      'List of sales staff',
      name: 'list_sales',
      desc: '',
      args: [],
    );
  }

  /// `Search by name`
  String get search_by_name {
    return Intl.message(
      'Search by name',
      name: 'search_by_name',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load sales staff list`
  String get unable_load_sales_list {
    return Intl.message(
      'Unable to load sales staff list',
      name: 'unable_load_sales_list',
      desc: '',
      args: [],
    );
  }

  /// `The list of sales staff is empty.`
  String get list_sales_empty {
    return Intl.message(
      'The list of sales staff is empty.',
      name: 'list_sales_empty',
      desc: '',
      args: [],
    );
  }

  /// `Please select a sales person before proceeding to the next step.`
  String get please_select_a_sale {
    return Intl.message(
      'Please select a sales person before proceeding to the next step.',
      name: 'please_select_a_sale',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to complete the order with this sales person?`
  String get confirm_complete_order_with_sale {
    return Intl.message(
      'Are you sure you want to complete the order with this sales person?',
      name: 'confirm_complete_order_with_sale',
      desc: '',
      args: [],
    );
  }

  /// `Printed bill successfully`
  String get print_bill_success {
    return Intl.message(
      'Printed bill successfully',
      name: 'print_bill_success',
      desc: '',
      args: [],
    );
  }

  /// `Print bill`
  String get print_bill {
    return Intl.message(
      'Print bill',
      name: 'print_bill',
      desc: '',
      args: [],
    );
  }

  /// `Sales staff`
  String get sale_staff {
    return Intl.message(
      'Sales staff',
      name: 'sale_staff',
      desc: '',
      args: [],
    );
  }

  /// `No sales staff selected`
  String get no_sale_selected {
    return Intl.message(
      'No sales staff selected',
      name: 'no_sale_selected',
      desc: '',
      args: [],
    );
  }

  /// `No Sales staff set up yet`
  String get no_sale_staff_set_up {
    return Intl.message(
      'No Sales staff set up yet',
      name: 'no_sale_staff_set_up',
      desc: '',
      args: [],
    );
  }

  /// `Select sales staff`
  String get select_sales_staff {
    return Intl.message(
      'Select sales staff',
      name: 'select_sales_staff',
      desc: '',
      args: [],
    );
  }

  /// `Attention*: No sales staff, please select unknown`
  String get attention_unknown_sale {
    return Intl.message(
      'Attention*: No sales staff, please select unknown',
      name: 'attention_unknown_sale',
      desc: '',
      args: [],
    );
  }

  /// `Submit a support request`
  String get submit_support_request {
    return Intl.message(
      'Submit a support request',
      name: 'submit_support_request',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Submit an error ticket`
  String get submit_error_ticket {
    return Intl.message(
      'Submit an error ticket',
      name: 'submit_error_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Scan the code (QR Code)`
  String get scan_qr_code {
    return Intl.message(
      'Scan the code (QR Code)',
      name: 'scan_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `Number of guests`
  String get number_of_guest {
    return Intl.message(
      'Number of guests',
      name: 'number_of_guest',
      desc: '',
      args: [],
    );
  }

  /// `Checking printer status`
  String get checking_printer_status {
    return Intl.message(
      'Checking printer status',
      name: 'checking_printer_status',
      desc: '',
      args: [],
    );
  }

  /// `Updating payment information`
  String get updating_payment_info {
    return Intl.message(
      'Updating payment information',
      name: 'updating_payment_info',
      desc: '',
      args: [],
    );
  }

  /// `Unlocking order`
  String get unlocking_order {
    return Intl.message(
      'Unlocking order',
      name: 'unlocking_order',
      desc: '',
      args: [],
    );
  }

  /// `Printer list`
  String get printer_list {
    return Intl.message(
      'Printer list',
      name: 'printer_list',
      desc: '',
      args: [],
    );
  }

  /// `Please select the printer to check`
  String get please_select_printer_to_check {
    return Intl.message(
      'Please select the printer to check',
      name: 'please_select_printer_to_check',
      desc: '',
      args: [],
    );
  }

  /// `Printer works stably`
  String get printer_work_stably {
    return Intl.message(
      'Printer works stably',
      name: 'printer_work_stably',
      desc: '',
      args: [],
    );
  }

  /// `Check printer status`
  String get check_printer_status {
    return Intl.message(
      'Check printer status',
      name: 'check_printer_status',
      desc: '',
      args: [],
    );
  }

  /// `Create ticket (APOS Lite System)`
  String get create_ticket_apos_lite_sys {
    return Intl.message(
      'Create ticket (APOS Lite System)',
      name: 'create_ticket_apos_lite_sys',
      desc: '',
      args: [],
    );
  }

  /// `Problem`
  String get problem {
    return Intl.message(
      'Problem',
      name: 'problem',
      desc: '',
      args: [],
    );
  }

  /// `Send ticket`
  String get send_ticket {
    return Intl.message(
      'Send ticket',
      name: 'send_ticket',
      desc: '',
      args: [],
    );
  }

  /// `No date selected`
  String get no_date_selected {
    return Intl.message(
      'No date selected',
      name: 'no_date_selected',
      desc: '',
      args: [],
    );
  }

  /// `Delete desired completion date`
  String get delete_desired_completion_date {
    return Intl.message(
      'Delete desired completion date',
      name: 'delete_desired_completion_date',
      desc: '',
      args: [],
    );
  }

  /// `Desired completion date`
  String get desired_completion_date {
    return Intl.message(
      'Desired completion date',
      name: 'desired_completion_date',
      desc: '',
      args: [],
    );
  }

  /// `Select completion date`
  String get select_completion_date {
    return Intl.message(
      'Select completion date',
      name: 'select_completion_date',
      desc: '',
      args: [],
    );
  }

  /// `Invalid image, please select again`
  String get invalid_image_please_take_again {
    return Intl.message(
      'Invalid image, please select again',
      name: 'invalid_image_please_take_again',
      desc: '',
      args: [],
    );
  }

  /// `Attach (Max 3 photos)`
  String get attach_three_image {
    return Intl.message(
      'Attach (Max 3 photos)',
      name: 'attach_three_image',
      desc: '',
      args: [],
    );
  }

  /// `Add attachments`
  String get add_attachment {
    return Intl.message(
      'Add attachments',
      name: 'add_attachment',
      desc: '',
      args: [],
    );
  }

  /// `No attached photos`
  String get no_attached_photos {
    return Intl.message(
      'No attached photos',
      name: 'no_attached_photos',
      desc: '',
      args: [],
    );
  }

  /// `Sending ticket failed`
  String get sending_ticket_failed {
    return Intl.message(
      'Sending ticket failed',
      name: 'sending_ticket_failed',
      desc: '',
      args: [],
    );
  }

  /// `Your ticket has been recorded!\nView and check the status under Cashier.`
  String get msg_send_ticket_success {
    return Intl.message(
      'Your ticket has been recorded!\nView and check the status under Cashier.',
      name: 'msg_send_ticket_success',
      desc: '',
      args: [],
    );
  }

  /// `When changing the number of guests, please reapply.`
  String get apply_policy_after_change_adults {
    return Intl.message(
      'When changing the number of guests, please reapply.',
      name: 'apply_policy_after_change_adults',
      desc: '',
      args: [],
    );
  }

  /// `Ticket submission history`
  String get ticket_submission_history {
    return Intl.message(
      'Ticket submission history',
      name: 'ticket_submission_history',
      desc: '',
      args: [],
    );
  }

  /// `Out of dishes`
  String get out_of_dish {
    return Intl.message(
      'Out of dishes',
      name: 'out_of_dish',
      desc: '',
      args: [],
    );
  }

  /// `Print bill creation failed!`
  String get create_print_bill_failed {
    return Intl.message(
      'Print bill creation failed!',
      name: 'create_print_bill_failed',
      desc: '',
      args: [],
    );
  }

  /// `Error loading bill image`
  String get error_loading_bill_image {
    return Intl.message(
      'Error loading bill image',
      name: 'error_loading_bill_image',
      desc: '',
      args: [],
    );
  }

  /// `Print failed!`
  String get print_failed {
    return Intl.message(
      'Print failed!',
      name: 'print_failed',
      desc: '',
      args: [],
    );
  }

  /// `Not in correct format`
  String get not_correct_format {
    return Intl.message(
      'Not in correct format',
      name: 'not_correct_format',
      desc: '',
      args: [],
    );
  }

  /// `Invalid date`
  String get invalid_date {
    return Intl.message(
      'Invalid date',
      name: 'invalid_date',
      desc: '',
      args: [],
    );
  }

  /// `Unit price`
  String get unit_price_shortcut {
    return Intl.message(
      'Unit price',
      name: 'unit_price_shortcut',
      desc: '',
      args: [],
    );
  }

  /// `New version available, update now`
  String get new_version {
    return Intl.message(
      'New version available, update now',
      name: 'new_version',
      desc: '',
      args: [],
    );
  }

  /// `Software updates`
  String get software_update {
    return Intl.message(
      'Software updates',
      name: 'software_update',
      desc: '',
      args: [],
    );
  }

  /// `Is print the number of people?`
  String get print_number_of_people {
    return Intl.message(
      'Is print the number of people?',
      name: 'print_number_of_people',
      desc: '',
      args: [],
    );
  }

  /// `Apply again`
  String get apply_policy_again {
    return Intl.message(
      'Apply again',
      name: 'apply_policy_again',
      desc: '',
      args: [],
    );
  }

  /// `No sales staff, please select unknown`
  String get attention_unknown_sale_1 {
    return Intl.message(
      'No sales staff, please select unknown',
      name: 'attention_unknown_sale_1',
      desc: '',
      args: [],
    );
  }

  /// `Haven't chosen a table to manipulate`
  String get haven_t_chosen_a_table_to_manipulate {
    return Intl.message(
      'Haven\'t chosen a table to manipulate',
      name: 'haven_t_chosen_a_table_to_manipulate',
      desc: '',
      args: [],
    );
  }

  /// `Operate on the current table order:`
  String get manipulate_with_the_current_table {
    return Intl.message(
      'Operate on the current table order:',
      name: 'manipulate_with_the_current_table',
      desc: '',
      args: [],
    );
  }

  /// `Unselect`
  String get unselect {
    return Intl.message(
      'Unselect',
      name: 'unselect',
      desc: '',
      args: [],
    );
  }

  /// `The current order`
  String get current_order {
    return Intl.message(
      'The current order',
      name: 'current_order',
      desc: '',
      args: [],
    );
  }

  /// `The list of ordered items is empty`
  String get list_ordered_item_empty {
    return Intl.message(
      'The list of ordered items is empty',
      name: 'list_ordered_item_empty',
      desc: '',
      args: [],
    );
  }

  /// `Locking order actions`
  String get locking_order_action {
    return Intl.message(
      'Locking order actions',
      name: 'locking_order_action',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete the invoice?`
  String get confirm_delete_invoice {
    return Intl.message(
      'Do you want to delete the invoice?',
      name: 'confirm_delete_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Filter by brand`
  String get filter_by_brand {
    return Intl.message(
      'Filter by brand',
      name: 'filter_by_brand',
      desc: '',
      args: [],
    );
  }

  /// `Select restaurant`
  String get select_restaurant {
    return Intl.message(
      'Select restaurant',
      name: 'select_restaurant',
      desc: '',
      args: [],
    );
  }

  /// `Updated successfully`
  String get updated_success {
    return Intl.message(
      'Updated successfully',
      name: 'updated_success',
      desc: '',
      args: [],
    );
  }

  /// `Search restaurant`
  String get search_restaurant {
    return Intl.message(
      'Search restaurant',
      name: 'search_restaurant',
      desc: '',
      args: [],
    );
  }

  /// `Available online`
  String get available_online {
    return Intl.message(
      'Available online',
      name: 'available_online',
      desc: '',
      args: [],
    );
  }

  /// `NOT available online`
  String get not_available_online {
    return Intl.message(
      'NOT available online',
      name: 'not_available_online',
      desc: '',
      args: [],
    );
  }

  /// `Main server`
  String get main_server {
    return Intl.message(
      'Main server',
      name: 'main_server',
      desc: '',
      args: [],
    );
  }

  /// `Backup server`
  String get backup_server {
    return Intl.message(
      'Backup server',
      name: 'backup_server',
      desc: '',
      args: [],
    );
  }

  /// `items`
  String get food_item {
    return Intl.message(
      'items',
      name: 'food_item',
      desc: '',
      args: [],
    );
  }

  /// `Loading payment QR code`
  String get loading_payment_qr_code {
    return Intl.message(
      'Loading payment QR code',
      name: 'loading_payment_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `Updating reservation infomation`
  String get updating_reservation_info {
    return Intl.message(
      'Updating reservation infomation',
      name: 'updating_reservation_info',
      desc: '',
      args: [],
    );
  }

  /// `Updating the order's reservation`
  String get updating_order_reser {
    return Intl.message(
      'Updating the order\'s reservation',
      name: 'updating_order_reser',
      desc: '',
      args: [],
    );
  }

  /// `is merged with table`
  String get is_merged_with_table {
    return Intl.message(
      'is merged with table',
      name: 'is_merged_with_table',
      desc: '',
      args: [],
    );
  }

  /// `has been moved to table`
  String get has_been_transferred_to {
    return Intl.message(
      'has been moved to table',
      name: 'has_been_transferred_to',
      desc: '',
      args: [],
    );
  }

  /// `has removed table`
  String get has_removed_table {
    return Intl.message(
      'has removed table',
      name: 'has_removed_table',
      desc: '',
      args: [],
    );
  }

  /// `Waiter received the order`
  String get waiter_service {
    return Intl.message(
      'Waiter received the order',
      name: 'waiter_service',
      desc: '',
      args: [],
    );
  }

  /// `Not select`
  String get not_select {
    return Intl.message(
      'Not select',
      name: 'not_select',
      desc: '',
      args: [],
    );
  }

  /// `Search waiter`
  String get search_waiter {
    return Intl.message(
      'Search waiter',
      name: 'search_waiter',
      desc: '',
      args: [],
    );
  }

  /// `Select the table to transfer`
  String get select_table_to_transfer {
    return Intl.message(
      'Select the table to transfer',
      name: 'select_table_to_transfer',
      desc: '',
      args: [],
    );
  }

  /// `Transfer from table {fromTable} to {toTable}`
  String confirm_transfer_table(String fromTable, String toTable) {
    return Intl.message(
      'Transfer from table $fromTable to $toTable',
      name: 'confirm_transfer_table',
      desc: '',
      args: [fromTable, toTable],
    );
  }

  /// `Reservation`
  String get reservation {
    return Intl.message(
      'Reservation',
      name: 'reservation',
      desc: '',
      args: [],
    );
  }

  /// `Got it`
  String get got_it {
    return Intl.message(
      'Got it',
      name: 'got_it',
      desc: '',
      args: [],
    );
  }

  /// `Ignore this notification and similar reminders`
  String get ignore_reservation_notification {
    return Intl.message(
      'Ignore this notification and similar reminders',
      name: 'ignore_reservation_notification',
      desc: '',
      args: [],
    );
  }

  /// `There is/are {count} reservation(s) that has already been received by the receptionist for the selected tables.\nIf the customer has made a reservation in advance, please select the reservation before confirming!`
  String noti_has_reservation(String count) {
    return Intl.message(
      'There is/are $count reservation(s) that has already been received by the receptionist for the selected tables.\nIf the customer has made a reservation in advance, please select the reservation before confirming!',
      name: 'noti_has_reservation',
      desc: '',
      args: [count],
    );
  }

  /// `The reservation is currently assigned to the current table order.`
  String get reservation_assigned_order {
    return Intl.message(
      'The reservation is currently assigned to the current table order.',
      name: 'reservation_assigned_order',
      desc: '',
      args: [],
    );
  }

  /// `Update reservation`
  String get update_reservation {
    return Intl.message(
      'Update reservation',
      name: 'update_reservation',
      desc: '',
      args: [],
    );
  }

  /// `The table order is currently associated with a reservation.Canceling the table order will also change the reservation status to "Canceled".\nIf you do not want to cancel the reservation, please update the reservation before canceling the table.`
  String get confirm_cancel_order_has_reservation {
    return Intl.message(
      'The table order is currently associated with a reservation.Canceling the table order will also change the reservation status to "Canceled".\nIf you do not want to cancel the reservation, please update the reservation before canceling the table.',
      name: 'confirm_cancel_order_has_reservation',
      desc: '',
      args: [],
    );
  }

  /// `Discount codes have not been applied successfully.`
  String get failed_apply_coupons {
    return Intl.message(
      'Discount codes have not been applied successfully.',
      name: 'failed_apply_coupons',
      desc: '',
      args: [],
    );
  }

  /// `Please`
  String get please {
    return Intl.message(
      'Please',
      name: 'please',
      desc: '',
      args: [],
    );
  }

  /// `Remove the code and re-enter it`
  String get remove_coupon_and_reenter {
    return Intl.message(
      'Remove the code and re-enter it',
      name: 'remove_coupon_and_reenter',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter the code`
  String get reenter_coupon {
    return Intl.message(
      'Re-enter the code',
      name: 'reenter_coupon',
      desc: '',
      args: [],
    );
  }

  /// `The invoice information is incorrect because taxes have not been reallocated`
  String get error_price_because_tax_reallocated {
    return Intl.message(
      'The invoice information is incorrect because taxes have not been reallocated',
      name: 'error_price_because_tax_reallocated',
      desc: '',
      args: [],
    );
  }

  /// `PLEASE CHECK & ENSURE\n- The tablet and computer are connected to the Order network\n- The printer is powered on and not jammed\n- The network cable connected to the printer is active (indicator light is on)`
  String get action_when_ping_printer_error {
    return Intl.message(
      'PLEASE CHECK & ENSURE\n- The tablet and computer are connected to the Order network\n- The printer is powered on and not jammed\n- The network cable connected to the printer is active (indicator light is on)',
      name: 'action_when_ping_printer_error',
      desc: '',
      args: [],
    );
  }

  /// `Unable to connect to the printer`
  String get unable_connect_printer {
    return Intl.message(
      'Unable to connect to the printer',
      name: 'unable_connect_printer',
      desc: '',
      args: [],
    );
  }

  /// `Unable to print the kitchen bill`
  String get error_print_kitechen_bill {
    return Intl.message(
      'Unable to print the kitchen bill',
      name: 'error_print_kitechen_bill',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

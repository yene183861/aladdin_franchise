import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

/// [productMap]
/// key: productId
/// value: {
/// default_printers: Set<PrinterModel>
///     printers: Set<PrinterModel>
///     product_cancel: ProductCheckoutModel?,
/// default_tax: 5,
/// tax: 1,
/// }
@freezed
class CheckoutPageState with _$CheckoutPageState {
  const factory CheckoutPageState({
    // @Default({}) Map<int, Map<String, dynamic>> productMap,
    @Default([]) List<ProductCheckoutModel> productsCheckout,
    @Default('') String message,
    @Default({}) Set<PrinterModel> defaultPrinters,
    @Default({}) Set<PrinterModel> printerSelect,
    // @Default({}) Set<int> productIdSelect,
    @Default(false) bool useDefaultPrinters,
  }) = _CheckoutPageState;
}

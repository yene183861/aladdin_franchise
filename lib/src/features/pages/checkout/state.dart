import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/models/product_checkout.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class CheckoutPageState with _$CheckoutPageState {
  const factory CheckoutPageState({
    @Default([]) List<ProductCheckoutModel> productsCheckout,
    @Default('') String message,
    @Default({}) Set<PrinterModel> printerSelect,
    @Default(false) bool useDefaultPrinters,
  }) = _CheckoutPageState;
}

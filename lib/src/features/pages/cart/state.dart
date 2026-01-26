import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum CartPageEvent {
  normal,
  error,
  success,
  addItems,
}

/// [productMap]
/// key: productId
/// value: {
///     printers: List<PrinterModel>
///     product: ProductModel?,
/// }
@freezed
class CartPageState with _$CartPageState {
  const factory CartPageState({
    @Default([]) List<ProductModel> productsSelecting,
    // @Default(CartPageEvent.normal) CartPageEvent event,
    // @Default('') String message,
    // @Default({}) Map<int, Set<PrinterModel>> productIdWithPrinter,
    // @Default(false) bool showPrinterSetupPanel,
    // @Default({}) Set<int> productIdSelect,
    // @Default({}) Map<int, Map<String, dynamic>> productMap,
    // @Default({}) Set<PrinterModel> defaultPrinters,
    // @Default({}) Set<PrinterModel> printerSelect,
    @Default({}) Set<int> productIdSelect,
  }) = _CartPageState;
}

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

@freezed
class CartPageState with _$CartPageState {
  const factory CartPageState({
    @Default([]) List<ProductModel> productsSelecting,
    @Default(CartPageEvent.normal) CartPageEvent event,
    @Default('') String message,
    @Default({}) Map<PrinterModel?, List<ProductModel>> productWithPrinter,
  }) = _CartPageState;
}

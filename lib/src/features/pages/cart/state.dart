import 'package:aladdin_franchise/src/data/model/restaurant/printer.dart';
import 'package:aladdin_franchise/src/models/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum CartEvent {
  normal,
  addItems,
  sendPrintData,
}

@freezed
class CartPageState with _$CartPageState {
  const factory CartPageState({
    @Default(CartEvent.normal) CartEvent event,
    @Default('') String message,
    @Default([]) List<ProductModel> productsSelecting,
    @Default({}) Set<int> productIdSelect,
  }) = _CartPageState;
}

import 'package:aladdin_franchise/src/models/payment_method/payment_method.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

enum PaymentStatus {
  init,
  success,
}

@freezed
class CustomerPageState with _$CustomerPageState {
  const factory CustomerPageState({
    PaymentMethod? paymentMethodSelect,
    @Default('') String gatewayUrl,
    @Default(true) bool autoScrollProducts,

    /// id của sản phẩm được thay đổi gần nhất
    int? changedProductId,
  }) = _CustomerPageState;
}

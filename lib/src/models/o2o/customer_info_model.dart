import 'package:aladdin_franchise/src/models/o2o/o2o_order_model.dart';
import 'package:aladdin_franchise/src/models/order.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_info_model.freezed.dart';
part 'customer_info_model.g.dart';

@freezed
class O2oCustomerInfoModel with _$O2oCustomerInfoModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory O2oCustomerInfoModel({
    @Default('') String name,
    @Default('') String phone,
  }) = _O2oCustomerInfoModel;

  factory O2oCustomerInfoModel.fromJson(Map<String, dynamic> json) =>
      _$O2oCustomerInfoModelFromJson(json);
}

import 'package:aladdin_franchise/src/models/policy_result.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'apply_policy.freezed.dart';
part 'apply_policy.g.dart';

@freezed
class ApplyPolicyResponse with _$ApplyPolicyResponse {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ApplyPolicyResponse({
    required ApplyPolicyResponseData data,
  }) = _ApplyPolicyResponse;

  factory ApplyPolicyResponse.fromJson(Map<String, dynamic> json) =>
      _$ApplyPolicyResponseFromJson(json);

  static String getModelInterface() {
    return '''required ApplyPolicyResponseData data,
    ApplyPolicyResponseData{
      required int status,
      required List<PolicyResultModel> data,
      required dynamic dataCreateVouchers,
      ---
      PolicyResultModel{
        required String name,
        required double total,
      }
    }
    ''';
  }
}

@freezed
class ApplyPolicyResponseData with _$ApplyPolicyResponseData {
  @JsonSerializable(explicitToJson: true)
  const factory ApplyPolicyResponseData({
    required int status,
    required List<PolicyResultModel> data,
    required dynamic dataCreateVouchers,
  }) = _ApplyPolicyResponseData;

  factory ApplyPolicyResponseData.fromJson(Map<String, dynamic> json) =>
      _$ApplyPolicyResponseDataFromJson(json);
}

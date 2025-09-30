/// Author: sondv
/// Created 22/11/24 at 11:24

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_order.freezed.dart';
part 'image_order.g.dart';

@freezed
class ImageOrderLocal with _$ImageOrderLocal {
  const factory ImageOrderLocal({
    required int orderId,
    @Default([]) List<String> paths,
  }) = _ImageOrderLocal;

  const ImageOrderLocal._();

  factory ImageOrderLocal.fromJson(Map<String, dynamic> json) => _$ImageOrderLocalFromJson(json);
}

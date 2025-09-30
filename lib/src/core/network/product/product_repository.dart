import 'package:aladdin_franchise/src/core/network/responses/product.dart';

/// Author: sondv
/// Created 08/11/2023 at 08:54

abstract class ProductRepository {
  /// Success => ProductRepository
  ///
  /// Error => Exception
  ///
  /// categoryId == null, get all product
  Future<ProductResponse> getProductByCategory(
    int? categoryId, {
    int? typeOrder,
  });
}

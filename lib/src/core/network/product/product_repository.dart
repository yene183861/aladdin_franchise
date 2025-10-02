import 'package:aladdin_franchise/src/core/network/responses/product.dart';

abstract class ProductRepository {
  /// categoryId == null, get all product
  Future<ProductResponse> getProduct(
    int? categoryId, {
    int? typeOrder,
  });
}

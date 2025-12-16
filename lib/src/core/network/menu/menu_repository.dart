import 'package:aladdin_franchise/src/core/network/responses/category.dart';
import 'package:aladdin_franchise/src/core/network/responses/product.dart';

abstract class MenuRepository {
  Future<CategoryResponse> getCategory();

  /// categoryId == null, get all product
  Future<ProductResponse> getProduct(
    int? categoryId, {
    int? typeOrder,
  });
}

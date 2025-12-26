import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/category.dart';
import 'package:aladdin_franchise/src/models/product.dart';

abstract class MenuRepository {
  /// checked
  Future<ApiResult<CategoryResponseData>> getCategory();

  /// checked
  Future<ApiResult<List<ProductModel>>> getProduct(
    int? categoryId, {
    int? typeOrder,
  });
}

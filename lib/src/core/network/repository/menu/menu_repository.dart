import 'package:aladdin_franchise/src/core/network/repository/responses/category.dart';
import 'package:aladdin_franchise/src/models/product.dart';

abstract class MenuRepository {
  Future<CategoryResponseData> getCategory(int? typeOrder);

  Future<List<ProductModel>> getProduct(
    int? categoryId, {
    int? typeOrder,
  });
}

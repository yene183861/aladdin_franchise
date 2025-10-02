import 'package:aladdin_franchise/src/core/network/responses/category.dart';

abstract class CategoryRepository {
  Future<CategoryResponse> getCategory();
}

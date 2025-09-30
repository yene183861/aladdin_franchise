import 'package:aladdin_franchise/src/core/network/responses/category.dart';

abstract class CategoryRepository {
  /// Success => CategoryRepository
  ///
  /// Error => Exception
  Future<CategoryResponse> getCategory();
}

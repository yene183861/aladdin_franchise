import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/network/repository/responses/category.dart';
import 'package:aladdin_franchise/src/core/network/api/rest_client.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/product.dart';

import 'menu_repository.dart';

class MenuRepositoryImpl extends MenuRepository {
  final RestClient _client;

  MenuRepositoryImpl(this._client);

  @override
  Future<CategoryResponseData> getCategory(int? typeOrder) async {
    final apiUrl = "${ApiConfig.apiUrl}/api/v1/make-waiter-restaurant-category";
    var result = await safeCallApi(
      () {
        final url = Uri.parse(apiUrl);
        return _client.get(url, typeOrder: typeOrder);
      },
      wrapperResponse: true,
      parser: (json) => CategoryResponseData.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.getCategory,
        api: apiUrl,
      ),
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }

    return result.data ?? const CategoryResponseData(status: 200, data: []);
  }

  @override
  Future<List<ProductModel>> getProduct(
    int? categoryId, {
    int? typeOrder,
  }) async {
    final apiUrl = "${ApiConfig.apiUrl}/api/v1/make-menu-search?category=${categoryId ?? ''}";
    var result = await safeCallApiList(
      () {
        final url = Uri.parse(apiUrl);
        return _client.get(url, typeOrder: typeOrder);
      },
      dataKey: 'data',
      parser: (json) => ProductModel.fromJson(json),
      wrapperResponse: true,
      log: ErrorLogModel(
        action: AppLogAction.getProduct,
        api: apiUrl,
      ),
    );
    if (!result.isSuccess) {
      throw AppException(
        statusCode: result.statusCode,
        message: result.error,
      );
    }

    return result.data ?? [];
  }
}

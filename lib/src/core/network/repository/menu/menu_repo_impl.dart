import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
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
  Future<ApiResult<CategoryResponseData>> getCategory() {
    final uri = "${ApiConfig.apiUrl}/api/v1/make-waiter-restaurant-category";
    return safeCallApi(
      () {
        final url = Uri.parse(uri);
        return _client.get(url);
      },
      wrapperResponse: true,
      parser: (json) => CategoryResponseData.fromJson(json),
      log: ErrorLogModel(
        action: AppLogAction.getCategory,
        api: uri,
      ),
    );
  }

  @override
  Future<ApiResult<List<ProductModel>>> getProduct(
    int? categoryId, {
    int? typeOrder,
  }) {
    final uri = "${ApiConfig.apiUrl}/api/v1/make-menu-search?category=${categoryId ?? ''}";
    return safeCallApiList(
      () {
        final url = Uri.parse(uri);
        return _client.get(url);
      },
      dataKey: 'data',
      parser: (json) => ProductModel.fromJson(json),
      wrapperResponse: true,
      log: ErrorLogModel(
        action: AppLogAction.getProduct,
        api: uri,
      ),
    );
  }
}

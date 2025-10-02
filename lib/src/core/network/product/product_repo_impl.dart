import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/product/product_repository.dart';
import 'package:aladdin_franchise/src/core/network/responses/product.dart';
import 'package:aladdin_franchise/src/core/network/rest_client.dart';
import 'package:aladdin_franchise/src/core/services/send_log/log_service.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<ProductResponse> getProduct(
    int? categoryId, {
    int? typeOrder,
  }) async {
    var urlApi = "${ApiConfig.getProduct}?category=${categoryId ?? ''}";
    var log = ErrorLogModel(
      action: AppLogAction.getProduct,
      api: urlApi,
      modelInterface: ProductResponse.getModelInterface(),
    );
    try {
      var response = await restClient.get(Uri.parse(urlApi));
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );
      if (response.statusCode == NetworkCodeConfig.ok) {
        var json = jsonDecode(response.body);
        var result = ProductResponse.fromJson(json);
        return result;
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      showLogs(ex.toString(), flags: 'getProduct ex');
      LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));

      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }
}

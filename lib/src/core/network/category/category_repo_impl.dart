import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/data_fake.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/category/category_repository.dart';
import 'package:aladdin_franchise/src/core/network/responses/category.dart';
import 'package:aladdin_franchise/src/core/network/rest_client.dart';
import 'package:aladdin_franchise/src/core/services/send_log/log_service.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  @override
  Future<CategoryResponse> getCategory() async {
    var apiUrl = ApiConfig.getCategories;
    var log = ErrorLogModel(
      action: AppLogAction.getCategory,
      api: apiUrl,
      modelInterface: CategoryResponse.getModelInterface(),
    );
    try {
      if (useDataFake) {
        await delayFunc();
        return CategoryResponse(
          data: CategoryResponseData(
            status: 200,
            data: kCategories,
          ),
        );
      }
      var response = await restClient.get(
        Uri.parse(apiUrl),
      );
      log = log.copyWith(
        response: [response.statusCode, response.body],
      );

      if (response.statusCode == NetworkCodeConfig.ok) {
        var jsonRes = jsonDecode(response.body);
        var result = CategoryResponse.fromJson(jsonRes);
        return result;
      } else {
        throw AppException.fromStatusCode(response.statusCode);
      }
    } catch (ex) {
      LogService.sendLogs(
          log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));
      if (ex is AppException) rethrow;
      throw AppException(message: ex.toString());
    }
  }
}

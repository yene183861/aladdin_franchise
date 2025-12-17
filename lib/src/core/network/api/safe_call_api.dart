import 'dart:convert';

import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/services/send_log/log_service.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:http/http.dart' as http;

class ApiResult<T> {
  final T? data;
  final String error;
  final bool isSuccess;
  final int statusCode;

  ApiResult.success(this.statusCode, this.data)
      : error = '',
        isSuccess = true;

  ApiResult.failure(this.statusCode, this.error)
      : data = null,
        isSuccess = false;

  @override
  String toString() {
    return 'statusCode: $statusCode, isSuccess: $isSuccess, error: $error\ndata: $data';
  }
}

///
/// [wrapperResponse] - false - 2 cấp: data trong field 'data'
///
Future<ApiResult<T>> safeCallApi<T>(
  Future<http.Response> Function() request, {
  Future<T> Function(dynamic json)? parser,
  String? dataKey,
  bool wrapperResponse = false,
  ErrorLogModel? log,
}) async {
  ApiResult<T> result;

  ErrorLogModel? errorLog = log;
  try {
    final response = await request();
    errorLog = errorLog?.copyWith(
      response: [response.statusCode, response.body],
    );
    if (response.statusCode >= 200 && response.statusCode <= 226) {
      var jsonData = jsonDecode(response.body);
      jsonData = wrapperResponse ? jsonData['data'] : jsonData;
      final data = dataKey != null ? jsonData[dataKey] : jsonData;
      if (parser != null) {
        try {
          var result = await parser(data);
          return ApiResult.success(response.statusCode, result);
        } catch (ex) {
          if (ex is ApiResult) {
            result = ex as ApiResult<T>;
          } else {
            rethrow;
          }
        }
        // return ApiResult.success(response.statusCode, parser(data));
      }
      return ApiResult.success(response.statusCode, data as T);
    } else {
      result = ApiResult.failure(
        response.statusCode,
        AppException.fromHttpResponse(response).toString(),
      );
    }
  } on http.ClientException catch (e) {
    showLog(e, flags: 'safeCallApi ClientException');
    result = ApiResult.failure(
      999,
      'Lỗi kết nối: ${AppException(message: e.message).toString()}',
    );
  } catch (e) {
    showLog(e, flags: 'safeCallApi');
    result = ApiResult.failure(
      999,
      AppException(message: e.toString()).toString(),
    );
  }
  if (!result.isSuccess && errorLog != null) {
    LogService.sendLogs(errorLog.copyWith(
      createAt: DateTime.now(),
      errorMessage: result.error,
    ));
  }
  return result;
}

Future<ApiResult<List<T>>> safeCallApiList<T>(
  Future<http.Response> Function() request, {
  T Function(Map<String, dynamic> json)? parser,
  String? dataKey,
  bool wrapperResponse = false,
  ErrorLogModel? log,
  Future<ApiResult<List<T>>> Function(Map<String, dynamic> json)? checkBeforeParse,
}) async {
  ApiResult<List<T>> result;
  ErrorLogModel? errorLog = log;
  try {
    final response = await request();
    errorLog = errorLog?.copyWith(
      response: [response.statusCode, response.body],
    );
    if (response.statusCode >= 200 && response.statusCode <= 226) {
      var jsonData = jsonDecode(response.body);
      jsonData = wrapperResponse ? jsonData['data'] : jsonData;
      if (checkBeforeParse != null) {
        var check = await checkBeforeParse(jsonData);
        if (!check.isSuccess) {
          result = check;
        }
      }

      final list = (dataKey != null ? jsonData[dataKey] : jsonData) as List<dynamic>;
      if (parser != null) {
        return ApiResult.success(
          response.statusCode,
          list.map((item) => parser(item as Map<String, dynamic>)).toList(),
        );
      }
      return ApiResult.success(response.statusCode, list.cast<T>());
    } else {
      result = ApiResult.failure(
        response.statusCode,
        AppException.fromHttpResponse(response).toString(),
      );
    }
  } on http.ClientException catch (e) {
    showLog(e, flags: 'safeCallApiList ClientException');
    result = ApiResult.failure(444, 'Lỗi kết nối: ${AppException(message: e.message).toString()}');
  } on ApiResult catch (e) {
    result = e;
  } catch (e) {
    showLog(e, flags: 'safeCallApiList');
    result = ApiResult.failure(
      999,
      AppException(message: e.toString()).toString(),
    );
  }
  if (!result.isSuccess && errorLog != null) {
    LogService.sendLogs(errorLog.copyWith(
      createAt: DateTime.now(),
      errorMessage: result.error,
    ));
  }
  return result;
}

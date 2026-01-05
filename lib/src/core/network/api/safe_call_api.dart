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
/// [ignoreResponse] - false - bỏ qua parse response, chỉ cần statusCode = [200, 206]
Future<ApiResult<T>> safeCallApi<T>(
  Future<http.Response> Function() request, {
  T Function(dynamic json)? parser,
  String? dataKey,
  bool wrapperResponse = false,
  ErrorLogModel? log,
  bool ignoreCheckStatus = false,
  bool ignoreResponse = false,
}) async {
  ApiResult<T> result;

  ErrorLogModel? errorLog = log;
  try {
    final response = await request();
    errorLog = errorLog?.copyWith(
      response: [response.statusCode, response.body],
    );
    if (response.statusCode >= 200 && response.statusCode <= 226) {
      if (ignoreResponse) {
        result = ApiResult.success(response.statusCode, null);
        _pushLog(result, errorLog);
        return result;
      }
      var jsonData = jsonDecode(response.body);
      jsonData = wrapperResponse ? jsonData['data'] : jsonData;
      if (!ignoreCheckStatus && (jsonData is Map)) {
        dynamic status = jsonData['status'];
        var message = jsonData['message'] as String?;
        // dành cho case statusCode = 200 nhưng status != 200
        if (status != null) {
          switch (status.runtimeType) {
            case int:
              if (status != 200) {
                result = ApiResult.failure(
                  status,
                  message ?? AppException.fromHttpResponse(response).toString(),
                );
                _pushLog(result, errorLog);
                return result;
              }
              break;
            case String:
              if (status != 'success') {
                result = ApiResult.failure(
                  response.statusCode,
                  message ?? AppException.fromHttpResponse(response).toString(),
                );
                _pushLog(result, errorLog);
                return result;
              }
              break;

            case bool:
              if (!status) {
                result = ApiResult.failure(
                  response.statusCode,
                  message ?? AppException.fromHttpResponse(response).toString(),
                );
                _pushLog(result, errorLog);
                return result;
              }
              break;
            default:
          }
        }
      }
      final data = dataKey != null ? jsonData[dataKey] : jsonData;
      if (parser != null) {
        result = ApiResult.success(response.statusCode, parser(data));
        _pushLog(result, errorLog);
        return result;
      }
      result = ApiResult.success(response.statusCode, data as T);
      _pushLog(result, errorLog);
      return result;
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
  } on AppException catch (e) {
    result = ApiResult.failure(
      e.errorCode ?? 999,
      e.messageError,
    );
  } catch (e) {
    showLog(e, flags: 'safeCallApi');
    result = ApiResult.failure(
      999,
      AppException(message: e.toString()).toString(),
    );
  }
  _pushLog(result, errorLog);
  return result;
}

Future<ApiResult<List<T>>> safeCallApiList<T>(
  Future<http.Response> Function() request, {
  T Function(Map<String, dynamic> json)? parser,
  String? dataKey,
  bool wrapperResponse = false,
  ErrorLogModel? log,
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
      if (jsonData is Map) {
        dynamic status = jsonData['status'];
        var message = jsonData['message'] as String?;
        // dành cho case statusCode = 200 nhưng status != 200
        if (status != null) {
          switch (status.runtimeType) {
            case int:
              if (status != 200) {
                result = ApiResult.failure(
                  status,
                  message ?? AppException.fromHttpResponse(response).toString(),
                );
                _pushLog(result, errorLog);
                return result;
              }
              break;
            case String:
              if (status != 'success') {
                result = ApiResult.failure(
                  response.statusCode,
                  message ?? AppException.fromHttpResponse(response).toString(),
                );
                _pushLog(result, errorLog);
                return result;
              }
              break;

            case bool:
              if (!status) {
                result = ApiResult.failure(
                  response.statusCode,
                  message ?? AppException.fromHttpResponse(response).toString(),
                );
                _pushLog(result, errorLog);
                return result;
              }
              break;
            default:
          }
        }
      }
      final list = (dataKey != null ? jsonData[dataKey] : jsonData) as List<dynamic>;
      if (parser != null) {
        result = ApiResult.success(
          response.statusCode,
          list.map((item) => parser(item as Map<String, dynamic>)).toList(),
        );
        _pushLog(result, errorLog);
        return result;
      }
      result = ApiResult.success(response.statusCode, list.cast<T>());
      _pushLog(result, errorLog);
      return result;
    } else {
      result = ApiResult.failure(
        response.statusCode,
        AppException.fromHttpResponse(response).toString(),
      );
    }
  } on http.ClientException catch (e) {
    showLog(e, flags: 'safeCallApiList ClientException');
    result = ApiResult.failure(444, 'Lỗi kết nối: ${AppException(message: e.message).toString()}');
  } on AppException catch (e) {
    result = ApiResult.failure(
      e.errorCode ?? 999,
      e.messageError,
    );
  } catch (e) {
    showLog(e, flags: 'safeCallApiList');
    result = ApiResult.failure(
      999,
      AppException(message: e.toString()).toString(),
    );
  }
  _pushLog(result, errorLog);

  return result;
}

void _pushLog(ApiResult<dynamic> result, ErrorLogModel? errorLog) {
  if (!result.isSuccess && errorLog != null) {
    // return;
    LogService.sendLogs(errorLog.copyWith(
      createAt: DateTime.now(),
      errorMessage: result.error,
    ));
  }
}

import 'dart:convert';

import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:http/http.dart';

class AppException implements Exception {
  late String messageError;

  int? errorCode;
  String _getErrorFromStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Yêu cầu xấu.';
      case 401:
        return "Thời gian đăng nhập đã hết, vui lòng đăng xuất và đăng nhập lại.";
      case 403:
        return 'Người dùng không được phép truy cập.';
      case 404:
        return "Không có dữ liệu";
      case 408:
        return "Thời gian yêu cầu quá hạn";
      case 423:
        return "Tài nguyên đang được truy cập bị khóa.";
      case 429:
        return 'Quá nhiều yêu cầu.';
      case 500:
        return "Lỗi 500";
      //return "500 - Lỗi máy chủ nội bộ";
      case 502:
        return "Sự cố phía máy chủ";
      case 503:
        return "Yêu cầu không có sẵn";
      default:
        return "Có lỗi xảy ra, vui lòng thử lại!";
    }
  }

  String _getErrorFromMessage(String? message) {
    const String postFixNetwork = "VUI LÒNG KIỂM TRA & ĐẢM BẢO:\n"
        "- Thiết bị (Tablet) đã kết nối wifi Order";
    const String postFixNetworkAndServer = "$postFixNetwork\n"
        "- Máy chủ (Máy tính thu ngân) đã bật, có mạng & hoạt động bình thường";
    var messageResult = "Có lỗi không mong muốn xảy ra. Vui lòng thử lại!";
    if (message != null) {
      var messageCheck = message.toLowerCase();
      if (messageCheck.contains('is not a subtype of type')) {
        messageResult = "Lỗi định dạng dữ liệu";
      } else if (messageCheck.contains('network is unreachable')) {
        messageResult = "Mạng không thể truy cập được\n$postFixNetwork";
      } else if (messageCheck.contains('connection failed')) {
        messageResult = "Kết nối  thất bại\n$postFixNetworkAndServer";
      } else if (messageCheck.contains('connection refused')) {
        messageResult = "Kết nối bị từ chối\n$postFixNetworkAndServer";
      } else if (messageCheck.contains('connection timed out') ||
          messageCheck.contains('time out')) {
        messageResult = "Hết thời gian kết nối\n$postFixNetworkAndServer";
      } else if (messageCheck.contains('connection abort')) {
        messageResult = "Kết nối bị huỷ\n$postFixNetwork";
      } else if (messageCheck.contains('reset by peer')) {
        messageResult =
            "Có lỗi liên quan đến hệ điều hành, vui lòng thoát phần mềm và vào lại!";
      } else if (messageCheck.contains('no route to host')) {
        messageResult = "Kết nối máy chủ thất bại\n$postFixNetworkAndServer";
      }
    }
    return "$messageResult\nSự cố: $message";
  }

  AppException.fromStatusCode(int? statusCode) {
    messageError = _getErrorFromStatusCode(statusCode);
    errorCode = statusCode;
  }

  /// Lấy luôn nội dung đưa vào để thông báo lỗi cho người dùng
  AppException.fromMessage(String message) {
    messageError = message;
  }

  AppException({int? statusCode, String? message}) {
    errorCode = statusCode;
    showLog("\nStatus code: $statusCode\nMessage: $message",
        flags: "AppException");

    messageError = 'Có lỗi không mong muốn xảy ra\nVui lòng thử lại!';
    if (message != null) {
      messageError = _getErrorFromMessage(message);
    } else if (statusCode != null) {
      messageError = _getErrorFromStatusCode(statusCode);
    }
  }

  // AppException.fromDioException(DioException exception) {
  //   switch (exception.type) {
  //     case DioExceptionType.cancel:
  //       messageError = 'Yêu cầu đến máy chủ đã bị hủy';
  //       break;
  //     case DioExceptionType.connectionTimeout:
  //       messageError = 'Kết nối quá hạn';
  //       break;
  //     case DioExceptionType.connectionError:
  //       if (exception.error is SocketException) {
  //         messageError = 'Không có mạng';
  //       } else {
  //         messageError = 'Kết nối bị lỗi. ${exception.message ?? ''}';
  //       }
  //       break;
  //     case DioExceptionType.receiveTimeout:
  //       messageError = 'Thời gian máy chủ phản hồi quá hạn';
  //       break;
  //     case DioExceptionType.sendTimeout:
  //       messageError = 'Yêu cầu đến máy chủ quá hạn';
  //       break;
  //     case DioExceptionType.badResponse:
  //       messageError = _getErrorFromStatusCode(exception.response?.statusCode);
  //       break;
  //     default:
  //       messageError = 'Đã xảy ra lỗi.\n${_getErrorFromMessage(exception.message)}';
  //       break;
  //   }
  // }

  AppException.fromHttpResponse(Response response) {
    try {
      errorCode = response.statusCode;
      if (response.statusCode == NetworkCodeConfig.internalServerError) {
        messageError = "Lỗi 500";
        return;
      }
      final Map<String, dynamic> body = jsonDecode(response.body);
      final messageResponse = body['message'];
      if (messageResponse != null && messageResponse.toString().isNotEmpty) {
        messageError = messageResponse;
      } else {
        messageError = _getErrorFromStatusCode(response.statusCode);
      }
    } catch (ex) {
      messageError = _getErrorFromStatusCode(response.statusCode);
    }
  }

  @override
  String toString() {
    return messageError;
  }
}

void checkLockedOrder(Response response) {
  if (response.statusCode == NetworkCodeConfig.locked) {
    throw AppException(
      statusCode: response.statusCode,
      message: jsonDecode(response.body)['message'] ?? S.current.msg_locked_order,
    );
  }
}

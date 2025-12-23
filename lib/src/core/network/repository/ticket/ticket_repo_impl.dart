import 'dart:convert';

import 'package:aladdin_franchise/src/configs/api.dart';
import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/configs/enums/app_log_action.dart';
import 'package:aladdin_franchise/src/core/network/api/app_exception.dart';
import 'package:aladdin_franchise/src/core/network/api/rest_client.dart';
import 'package:aladdin_franchise/src/core/network/api/safe_call_api.dart';
import 'package:aladdin_franchise/src/core/network/repository/ticket/ticket_repository.dart';
import 'package:aladdin_franchise/src/core/services/send_log/log_service.dart';
import 'package:aladdin_franchise/src/core/storages/local.dart';
import 'package:aladdin_franchise/src/models/error_log.dart';
import 'package:aladdin_franchise/src/models/ticket.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';
import 'package:aladdin_franchise/src/utils/date_time.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class TicketRepositoryImpl extends TicketRepository {
  final RestClient _client;

  TicketRepositoryImpl(this._client);
  // @override
  // Future<ApiResult<List<TicketModel>>> getTickets() async {
  //   return ApiResult.success(200, []);
  // }

  // @override
  // Future<ApiResult<void>> createTicket({
  //   required String title,
  //   required String content,
  //   required List<String> imagePaths,
  //   DateTime? dateOfWish,
  // }) async {
  //   var log = ErrorLogModel(
  //     action: AppLogAction.createTicket,
  //     api: ApiConfig.createTicket,
  //   );
  //   try {
  //     final postUri = Uri.parse(ApiConfig.createTicket);
  //     MultipartRequest request = http.MultipartRequest("POST", postUri);
  //     final restaurant = LocalStorage.getDataLogin()?.restaurant?.id;
  //     request.headers.addAll({
  //       "Content-Type": "application/x-www-form-urlencoded",
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $kToken',
  //     });
  //     request.fields['name'] = title;
  //     request.fields['description'] = content;
  //     request.fields['dateofwish'] =
  //         dateOfWish == null ? "" : DateTimeUtils.instance.dateFormatYYYYMMDD.format(dateOfWish);
  //     request.fields['restaurant_id'] = "$restaurant";
  //     final images = <MultipartFile>[];
  //     for (var path in imagePaths) {
  //       final image = await http.MultipartFile.fromPath(
  //         'attachments[]',
  //         path,
  //       );
  //       images.add(image);
  //     }
  //     request.files.addAll(images);
  //     log = log.copyWith(request: request.fields);
  //     final sendRequest = await request.send();
  //     final response = await http.Response.fromStream(sendRequest);
  //     log = log.copyWith(response: [response.statusCode, response.body]);
  //     if (response.statusCode != 200) {
  //       throw AppException.fromHttpResponse(response);
  //     }
  //   } catch (ex) {
  //     showLog(ex.toString(), flags: 'createTicket ex');
  //     LogService.sendLogs(log.copyWith(errorMessage: ex.toString(), createAt: DateTime.now()));
  //     if (ex is AppException) rethrow;
  //     throw AppException(message: ex.toString());
  //   }
  // }
}

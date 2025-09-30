import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../create/view.dart';

Future<bool?> showCreateTicket(
  BuildContext context, {
  String? title,
  String? content,
  List<File>? attachFile,
}) async {
  final result = await showDialog<bool?>(
    context: context,
    builder: (context) {
      return TicketCreateWidget(
        title: title,
        content: content,
        attachFile: attachFile,
      );
    },
  );
  return result;
}

import 'dart:io';

import 'package:aladdin_franchise/src/core/network/provider.dart';
import 'package:aladdin_franchise/src/core/network/ticket/ticket_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/app_log.dart';
import 'state.dart';

final ticketCreatePageProvider = StateNotifierProvider.autoDispose<
    TicketCreatePageNotifier, TicketCreateState>((ref) {
  return TicketCreatePageNotifier(ref.read(ticketRepositoryProvider));
});

class TicketCreatePageNotifier extends StateNotifier<TicketCreateState> {
  TicketCreatePageNotifier(this._ticketRepository)
      : super(const TicketCreateState());

  final TicketRepository _ticketRepository;

  @override
  void dispose() {
    clearAttachFile();
    super.dispose();
  }

  void initialize({
    String? title,
    String? content,
    List<File>? attachFile,
  }) {
    state = state.copyWith(
      title: title ?? "",
      content: content ?? "",
      attachFile: attachFile ?? [],
    );
  }

  String getErrorMessage() => state.errorMessage;

  void changeForm({String? title, String? content}) {
    state = state.copyWith(
      title: title ?? state.title,
      content: content ?? state.content,
    );
  }

  void changeDateOfWish(DateTime? dateOfWish) {
    state = state.copyWith(dateOfWish: dateOfWish);
  }

  // update trùng sẽ xoá
  void updateAttachFile(File image) {
    var images = List<File>.from(state.attachFile);
    if (images.contains(image)) {
      images.remove(image);
      clearAttachFile(files: [image]);
    } else {
      images.add(image);
    }
    state = state.copyWith(attachFile: images);
  }

  void clearAttachFile({List<File>? files}) {
    try {
      final fileCheck = files ?? state.attachFile;
      for (final file in fileCheck) {
        File(file.path).deleteSync();
      }
      // xoá toàn bộ
      if (files == null) {
        state = state.copyWith(attachFile: []);
      }
      showLog("done", flags: 'clearImageBill');
    } catch (ex) {
      showLog("error $ex", flags: 'clearImageBill');
    }
  }

  Future<void> onSummit() async {
    try {
      state = state.copyWith(events: TicketCreateEvent.processing);
      await _ticketRepository.createTicket(
        title: state.title,
        content: state.content,
        imagePaths: state.attachFile.map((e) => e.path).toList(),
        dateOfWish: state.dateOfWish,
      );
      state = state.copyWith(events: TicketCreateEvent.success);
    } catch (ex) {
      state = state.copyWith(
        events: TicketCreateEvent.error,
        errorMessage: ex.toString(),
      );
    }
  }
}

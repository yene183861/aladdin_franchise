import 'package:aladdin_franchise/src/models/ticket.dart';

abstract class TicketRepository {
  Future<List<TicketModel>> getTickets();
  Future<void> createTicket({
    required String title,
    required String content,
    required List<String> imagePaths,
    DateTime? dateOfWish,
  });
}

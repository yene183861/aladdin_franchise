import 'package:flutter/material.dart';

enum TicketStatus {
  // Tạo mới
  newCreate,
  // Đang xử lý
  processing,
  // Đã xử lý
  processed,
  // Hoàn thành
  completed,
  // Hủy
  canceled,
}

extension TicketStatusEx on TicketStatus {
  String get title {
    switch (this) {
      case TicketStatus.newCreate:
        return 'Tạo mới';
      case TicketStatus.processing:
        return 'Đang xử lý';
      case TicketStatus.processed:
        return 'Đã xử lý';
      case TicketStatus.completed:
        return 'Hoàn thành';
      case TicketStatus.canceled:
        return 'Đã hủy';
    }
  }

  Color get color {
    switch (this) {
      case TicketStatus.newCreate:
        return Colors.amber;
      case TicketStatus.processing:
        return Colors.blue;
      case TicketStatus.processed:
        return Colors.blue;
      case TicketStatus.completed:
        return Colors.green;
      case TicketStatus.canceled:
        return Colors.grey;
    }
  }
}

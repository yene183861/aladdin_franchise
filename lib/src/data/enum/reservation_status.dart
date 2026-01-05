import 'package:aladdin_franchise/generated/l10n.dart';
import 'package:flutter/material.dart';

enum ReservationStatusEnum {
  pending,
  accept,

  process,

  complete,
  cancel,
  reject,
}

extension ReservationStatusEnumEx on ReservationStatusEnum {
  int get type {
    switch (this) {
      case ReservationStatusEnum.pending:
        return 1;
      case ReservationStatusEnum.accept:
        return 2;
      case ReservationStatusEnum.cancel:
        return 3;
      case ReservationStatusEnum.reject:
        return 4;
      case ReservationStatusEnum.complete:
        return 20;
      case ReservationStatusEnum.process:
        return 15;
      default:
        return 0;
    }
  }

  String get title {
    switch (this) {
      case ReservationStatusEnum.pending:
        return S.current.pending_reser;
      case ReservationStatusEnum.accept:
        return S.current.accepted_reser;
      case ReservationStatusEnum.cancel:
        return S.current.canceled_reser;
      case ReservationStatusEnum.reject:
        return S.current.rejected_reser;
      case ReservationStatusEnum.complete:
        return S.current.completed_reser;

      case ReservationStatusEnum.process:
        return S.current.processing_reser;
      default:
        return S.current.all;
    }
  }

  Color get color {
    switch (this) {
      case ReservationStatusEnum.pending:
        return const Color(0xFF0F87C7).withOpacity(0.7);
      case ReservationStatusEnum.accept:
        return const Color(0xFFF67F00).withOpacity(0.7);
      case ReservationStatusEnum.cancel:
        return Colors.grey.shade600;
      case ReservationStatusEnum.reject:
        return Colors.grey.shade800;
      case ReservationStatusEnum.complete:
        return const Color(0xFF2F9449);
      case ReservationStatusEnum.process:
        return const Color.fromARGB(255, 219, 56, 11);
      default:
        return Colors.grey;
    }
  }
}

ReservationStatusEnum convertToReservationStatusEnum(int type) {
  switch (type) {
    case 1:
      return ReservationStatusEnum.pending;
    case 2:
      return ReservationStatusEnum.accept;
    case 3:
      return ReservationStatusEnum.cancel;
    case 4:
      return ReservationStatusEnum.reject;
    case 20:
      return ReservationStatusEnum.complete;
    case 15:
    case 16:
      return ReservationStatusEnum.process;
    default:
      return ReservationStatusEnum.pending;
  }
}

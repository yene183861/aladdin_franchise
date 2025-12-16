enum PaymentStatusEnum {
  loading,
  success,
  fail,
  cancel,
  close,
}

// extension PaymentStatusEnumEx on PaymentStatusEnum {
//   int get type {
//     switch (this) {
//       case PaymentStatusEnum.loading:
//         return 1;
//       case PaymentStatusEnum.success:
//         return 2;
//       case PaymentStatusEnum.fail:
//         return 3;
//       case PaymentStatusEnum.cancel:
//         return 4;
//       case PaymentStatusEnum.close:
//         return 5;
//     }
//   }
// }

// PaymentStatusEnum convertPaymentStatusEnum(int type) {
//   switch (type) {
//     case 1:
//       return PaymentStatusEnum.loading;
//     case 2:
//       return PaymentStatusEnum.success;
//     case 3:
//       return PaymentStatusEnum.fail;
//     case 4:
//       return PaymentStatusEnum.cancel;
//     case 5:
//       return PaymentStatusEnum.close;
//     default:
//       return PaymentStatusEnum.close;
//   }
// }

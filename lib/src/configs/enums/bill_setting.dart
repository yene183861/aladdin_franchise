// import 'package:aladdin_franchise/generated/assets.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';

enum BillReturnItemTypeEnum { normal, uppercase, byHeight }

extension BillReturnItemTypeEnumEx on BillReturnItemTypeEnum {
  // String get image {
  //   switch (this) {
  //     case BillReturnItemTypeEnum.normal:
  //       return Assets.imagesBill1;
  //     case BillReturnItemTypeEnum.uppercase:
  //       return Assets.imagesBill2;
  //     case BillReturnItemTypeEnum.byHeight:
  //       return Assets.imagesBill3;
  //     default:
  //       return Assets.imagesBill1;
  //   }
  // }
}

enum ColorSettingTypeEnum { background, lineSelect }

enum AppPrinterSettingTypeEnum { normal, withHtml }

enum PaperSizeSettingEnum { mm58, mm80, mm72 }

extension PaperSizeSettingEnumEx on PaperSizeSettingEnum {
  PaperSize get paperSize {
    switch (this) {
      case PaperSizeSettingEnum.mm80:
        return PaperSize.mm80;
      case PaperSizeSettingEnum.mm72:
        return PaperSize.mm72;
      case PaperSizeSettingEnum.mm58:
        return PaperSize.mm58;
    }
  }
}

final List<int> fontSizeBillHtml = List.generate(20, (index) => 8 + index);

// enum EProductStatus { all, stocking, outOfStock }

// extension EProductStatusEx on EProductStatus {
//   String get textView => switch (this) {
//         EProductStatus.all => "Tất cả",
//         EProductStatus.stocking => "Món đang bán",
//         EProductStatus.outOfStock => "Món đang hết",
//       };
//   int get value => switch (this) {
//         EProductStatus.all => 1,
//         EProductStatus.stocking => 2,
//         EProductStatus.outOfStock => 3,
//       };
// }

enum TypePrinterBillEnum {
  noBillOddThenPrintReturn,
  billOddAndPrintReturn,
  noBillOddPrintReturn,
}

// class TypePrinterBill {
//   /// - Ko in lẻ -> nhảy trả đồ in
//   static const int noBillOddThenPrintReturn = 1;

//   /// - In bill lẻ -> nhảy trả đồ -> có thể in tiếp
//   static const int billOddAndPrintReturn = 2;

//   /// - Ko in lẻ -> in trả đồ luôn
//   static const int noBillOddPrintReturn = 3;
// }

// enum PageStateCommon { loading, success, error }

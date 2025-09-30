import 'package:aladdin_franchise/src/configs/app.dart';
import 'package:aladdin_franchise/src/models/id_card.dart';
import 'package:aladdin_franchise/src/utils/app_log.dart';

/// Author: sondv
/// Created 23/02/2023 at 10:05

class IDCardHelper {
  /// Convent sang IDCardModel với dữ liệu scan được từ mã QR ở CCCD gắn chíp
  ///
  /// success => IDCardModel?
  ///
  /// Check lỗi khi null thôi =))
  ///
  /// #Data ta mẫu
  ///
  /// 001098011212||Dương Văn Sơn|03011998|Nam|Phú Nghĩa, Phú Kim, Thạch Thất, Hà Nội|20072021
  static IDCardModel? getIdCardFromCCCD(String raw) {
    try {
      var data = raw.split('|');
      var id = data[0].trim();
      // name
      var fullName = data[2].trim();
      var firstName = fullName.split(' ').first;
      var lastName = fullName.replaceAll(firstName, '').trim();
      // dob
      var dobRaw = data[3].trim();
      var day = int.parse(dobRaw.substring(0, 2));
      var month = int.parse(dobRaw.substring(2, 4));
      var year = int.parse(dobRaw.substring(4));
      var dob = DateTime(year, month, day);
      // gender
      var gender = data[4].trim().toLowerCase() == "nam"
          ? appConfig.gender[0]
          : appConfig.gender[1];
      // address
      var address = data[5];
      var idCard = IDCardModel(
        id: id,
        firstName: firstName,
        lastName: lastName,
        dob: dob,
        gender: gender,
        address: address,
      );
      showLog(idCard);
      return idCard;
    } catch (ex) {
      return null;
    }
  }
}

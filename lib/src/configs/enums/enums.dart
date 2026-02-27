import 'package:aladdin_franchise/generated/l10n.dart';

enum ViewProductSelected { normal, orderHistory }

enum PageStateInitializeCommon { loading, success, error }

enum ConfigServerRestaurantData { firebase, aladdinWeb }

extension ExtConfigRestaurantData on ConfigServerRestaurantData {
  String getNameView() => switch (this) {
        ConfigServerRestaurantData.firebase => S.current.main_server,
        ConfigServerRestaurantData.aladdinWeb => S.current.backup_server,
      };
}

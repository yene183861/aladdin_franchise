enum ViewProductSelected { normal, orderHistory }

enum PageStateInitializeCommon { loading, success, error }

enum ConfigServerRestaurantData { firebase, aladdinWeb }

extension ExtConfigRestaurantData on ConfigServerRestaurantData {
  String getNameView() => switch (this) {
        ConfigServerRestaurantData.firebase => "Máy chủ chính",
        ConfigServerRestaurantData.aladdinWeb => "Máy chủ dự phòng",
      };
}

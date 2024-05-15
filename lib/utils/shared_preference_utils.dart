import 'package:get_storage/get_storage.dart';

class SharedPreferenceUtils {
  static GetStorage getStorage = GetStorage();

  static String isLogin = 'isLogin';
  static String userId = 'userId';
  static String editedSessionId = 'editedSessionId';
  static String isSubscription = 'isSubscription';
  static String latitude = 'latitude';
  static String longitude = 'longitude';
  static String currentDate = 'currentDate';
  static String userDetail = 'userDetail';

  /// is login
  static Future setIsLogin(bool value) async {
    await getStorage.write(isLogin, value);
  }

  static bool getIsLogin() {
    return getStorage.read(isLogin) ?? false;
  }

  ///userID
  static Future setUserId(String value) async {
    await getStorage.write(userId, value);
  }

  static String getUserId() {
    return getStorage.read(userId) ?? "";
  }

  ///session id
  static Future setSessionId(String value) async {
    await getStorage.write(editedSessionId, value);
  }

  static String getSessionId() {
    return getStorage.read(editedSessionId) ?? "";
  }

  static Future<void> clearPreference() async {
    await getStorage.erase();
  }

  ///USER DETAIL
  static setUserDetail(String value) async {
    await getStorage.write(userDetail, value);
  }

  static String getUserDetail() {
    return getStorage.read(userDetail) ?? "";
  }

  ///isSubscription
  static setIsSubscription(bool value) async {
    await getStorage.write(isSubscription, value);
  }

  static bool getIsSubscription() {
    return getStorage.read(isSubscription) ?? false;
  }

  ///LATITUDE
  static setLatitude(String value) async {
    await getStorage.write(latitude, value);
  }

  static String getLatitude() {
    return getStorage.read(latitude) ?? "0.0";
  }

  ///LONGITUDE
  static setLongitude(String value) async {
    await getStorage.write(longitude, value);
  }

  static String getLongitude() {
    return getStorage.read(longitude) ?? "0.0";
  }

  ///CURRENT DATE
  static setCurrentDate(String value) async {
    await getStorage.write(currentDate, value);
  }

  static String getCurrentDate() {
    return getStorage.read(currentDate) ?? "1970-01-01";
  }
}

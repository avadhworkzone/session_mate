<<<<<<< Updated upstream
import 'package:get_storage/get_storage.dart';

class SharedPreferenceUtils {
  static GetStorage getStorage = GetStorage();

  static String isLogin = 'isLogin';
  static String userId = 'userId';
  static String editedSessionId = 'editedSessionId';
  static String forTherapyPlanSessionId = 'forTherapyPlanSessionId';
  static String isSubscription = 'isSubscription';
  static String latitude = 'latitude';
  static String longitude = 'longitude';
  static String currentDate = 'currentDate';
  static String userDetail = 'userDetail';
  static String role = 'role';

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

  ///for Therapy Plan SessionId
  static Future setTherapyPlanSessionId(String value) async {
    await getStorage.write(forTherapyPlanSessionId, value);
  }

  static String getTherapyPlanSessionId() {
    return getStorage.read(forTherapyPlanSessionId) ?? "";
  }

  static Future<void> clearPreference() async {
    await getStorage.erase();
  }

  ///USER DETAIL
  static Future<void> setUserDetail(String value) async {
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

  /// ROLE
  static setRole(String value) async {
    await getStorage.write(role, value);
  }

  static String getRole() {
    return getStorage.read(role) ?? "";
  }
}
=======
import 'package:get_storage/get_storage.dart';

class SharedPreferenceUtils {
  static GetStorage getStorage = GetStorage();

  static String isLogin = 'isLogin';
  static String isHomeLogin = 'isHomeLogin';
  static String isAdminLogin = 'isAdminLogin';
  static String isUserRejectedLogin = 'isUserRejectedLogin';
  static String userId = 'userId';
  static String editedSessionId = 'editedSessionId';
  static String forTherapyPlanSessionId = 'forTherapyPlanSessionId';
  static String isSubscription = 'isSubscription';
  static String latitude = 'latitude';
  static String longitude = 'longitude';
  static String currentDate = 'currentDate';
  static String userDetail = 'userDetail';
  static String role = 'role';

  /// is User Therapist login
  static Future setIsLogin(bool value) async {
    await getStorage.write(isLogin, value);
  }

  static bool getIsLogin(){
    return getStorage.read(isLogin) ?? false;
  }

  /// Is Home Login
  static Future setIsHomeLogin(bool value) async {
    await getStorage.write(isHomeLogin, value);
  }

  static bool getIsHomeLogin(){
    return getStorage.read(isHomeLogin) ?? false;
  }


  /// is Admin login
  static Future setIsAdminLogin(bool value) async {
    await getStorage.write(isAdminLogin, value);
  }

  static bool getIsAdminLogin(){
    return getStorage.read(isAdminLogin) ?? false;
  }

  /// Is User Rejected Screen
  static Future setIsUserRejectedLogin(bool value) async {
    await getStorage.write(isUserRejectedLogin, value);
  }

  static bool getIsUserRejectedLogin(){
    return getStorage.read(isUserRejectedLogin) ?? false;
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

  ///for Therapy Plan SessionId
  static Future setTherapyPlanSessionId(String value) async {
    await getStorage.write(forTherapyPlanSessionId, value);
  }

  static String getTherapyPlanSessionId() {
    return getStorage.read(forTherapyPlanSessionId) ?? "";
  }

  static Future<void> clearPreference() async {
    await getStorage.erase();
  }

  ///USER DETAIL
  static Future<void> setUserDetail(String value) async {
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

  /// ROLE
  static setRole(String value) async {
    await getStorage.write(role, value);
  }

  static String getRole() {
    return getStorage.read(role) ?? "";
  }
}
>>>>>>> Stashed changes

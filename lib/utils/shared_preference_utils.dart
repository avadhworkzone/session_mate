import 'package:get_storage/get_storage.dart';

class SharedPreferenceUtils {
  static GetStorage getStorage = GetStorage();

  static String isLogin = 'isLogin';
  static String userId = 'userId';
  static String editedSessionId = 'editedSessionId';
  static String forTherapyPlanSessionId = 'forTherapyPlanSessionId';

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
}

import 'package:get_storage/get_storage.dart';

class SharedPreferenceUtils {
  static GetStorage getStorage = GetStorage();

  static String isLogin = 'isLogin';
  static String userId = 'userId';

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

  static Future<void> clearPreference() async {
    await getStorage.erase();
  }
}

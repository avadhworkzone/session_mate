import 'package:session_mate/modal/user_model.dart';
import 'package:session_mate/utils/collection_utils.dart';
import 'package:session_mate/utils/common_methods.dart';

class AuthService {
  static Future<bool> checkUserExist(String docId) async {
    return CollectionUtils.userCollection
        .doc(docId)
        .get()
        .then((value) => value.exists ? true : false)
        .catchError((e) {
      logs('CHECK USER EXIST ERROR:=>$e');
      return false;
    });
  }

  static Future<bool> signUp(UserModel model) async {
    return CollectionUtils.userCollection
        .doc(model.mobileNumber)
        .set(model.toJson())
        .then((value) => true)
        .catchError((e) {
      logs('SIGN UP ERROR :=>$e');
      return false;
    });
  }

  static Future<bool> checkLoginCredential(UserModel model) async {
    return CollectionUtils.userCollection
        .where('mobileNumber', isEqualTo: model.mobileNumber)
        .where('password', isEqualTo: model.password)
        .where('email', isEqualTo: model.email)
        .get()
        .then((value) => value.docs.isNotEmpty ? true : false)
        .catchError((e) {
      logs('CHECK USER EXIST ERROR:=>$e');
      return false;
    });
  }
}

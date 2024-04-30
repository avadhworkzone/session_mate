import 'package:session_mate/modal/user_model.dart';
import 'package:session_mate/utils/collection_utils.dart';

class AuthService {
  static Future<bool> checkUserExist(String docId) async {
    return CollectionUtils.userCollection
        .doc(docId)
        .get()
        .then((value) => value.exists ? true : false)
        .catchError((e) {
      print('CHECK USER EXIST ERROR:=>$e');
      return false;
    });
  }

  static Future<bool> signUp(UserModel model) async {
    return CollectionUtils.userCollection
        .doc(model.mobileNumber)
        .set(model.toJson())
        .then((value) => true)
        .catchError((e) {
      print('SIGN UP ERROR :=>$e');
      return false;
    });
  }
}

<<<<<<< Updated upstream
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
        .where('role', isEqualTo: model.role)
        .where('centerCode', isEqualTo: model.centerCode)
        .get()
        .then((value) => value.docs.isNotEmpty ? true : false)
        .catchError((e) {
      logs('CHECK USER EXIST ERROR:=>$e');
      return false;
    });
  }

  /// CHECK THERAPY CENTER CODE
  static Future<bool> checkTherapyCenterCode(
      {required String therapistCenterCode}) async {
    return CollectionUtils.therapyCenterCodeCollection
        .where('centerCode', isEqualTo: therapistCenterCode)
        .get()
        .then((value) => value.docs.isNotEmpty ? true : false)
        .catchError((e) {
      logs('CHECK THERAPY CENTER CODE ERROR:=>$e');
      return false;
    });
  }
}
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:session_mate/modal/user_model.dart';
import 'package:session_mate/utils/app_snackbar.dart';
import 'package:session_mate/utils/collection_utils.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/viewModel/user_verification_status_view_model.dart';

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

  static void addAdminComment(String mobileNumber, String adminComment,
      UserVerificationStatusViewModel userVerificationStatusViewModel) {
    userVerificationStatusViewModel.isCommentLoad.value = true;

    CollectionUtils.userCollection.doc(mobileNumber).update({
      "adminCommentOfUnVerifyUser": adminComment,
      "isVerify": "false"
    }).then((value) {
      userVerificationStatusViewModel.isCommentLoad.value = false;
      userVerificationStatusViewModel.verifyIndex.value = -1;
      userVerificationStatusViewModel.adminCommentController.clear();
      showErrorSnackBar("Comment Submitted Successfully", "");
    }).catchError((e) {
      userVerificationStatusViewModel.isCommentLoad.value = false;
      userVerificationStatusViewModel.adminCommentController.clear();
      userVerificationStatusViewModel.verifyIndex.value = -1;
      showErrorSnackBar("Something Went Wrong", "");
      print("Add Admin Comment Error :- $e");
    });
  }

  static void addIsVerifyStatus(String mobileNumber){
    CollectionUtils.userCollection.doc(mobileNumber).update({
      "isVerify": "true"
    }).then((value) {

      showErrorSnackBar("User Verified Successfully", "");
    }).catchError((e) {

      showErrorSnackBar("Something Went Wrong", "");
      print("Add Admin Comment Error :- $e");
    });
  }

  static Stream<DocumentSnapshot> getVerificationStaus(String mobileNumber){
   return CollectionUtils.userCollection.doc(mobileNumber).snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAuthUserData() {
    return CollectionUtils.userCollection
        .where("role", isNotEqualTo: "admin")
        .snapshots();
  }


  static Stream<QuerySnapshot<Map<String, dynamic>>> getAdminCommentData() {
     return CollectionUtils.userCollection.where("id",isEqualTo: SharedPreferenceUtils.getUserId()).snapshots();
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

  static Future<bool> checkLoginCredential(UserModel model) async {
    return CollectionUtils.userCollection
        .where('mobileNumber', isEqualTo: model.mobileNumber)
        // .where('password', isEqualTo: model.password)
        // .where('email', isEqualTo: model.email)
        // .where('role', isEqualTo: model.role)
        // .where('centerCode', isEqualTo: model.centerCode)
        .get()
        .then((value) {

          print("Store Value :- ${value.docs}");
          return value.docs.isNotEmpty ? true : false;
    })
        .catchError((e) {
      print('CHECK USER EXIST ERROR:=>$e');
      return false;
    });
  }

  static Query<Map<String, dynamic>> deleteCurrentUserAccount(){


   return   CollectionUtils.userCollection.where('mobileNumber', isEqualTo: SharedPreferenceUtils.getUserId());
  }

  /// CHECK THERAPY CENTER CODE
  static Future<bool> checkTherapyCenterCode(
      {required String therapistCenterCode}) async {
    return CollectionUtils.therapyCenterCodeCollection
        .where('centerCode', isEqualTo: therapistCenterCode)
        .get()
        .then((value) => value.docs.isNotEmpty ? true : false)
        .catchError((e) {
      print('CHECK THERAPY CENTER CODE ERROR:=>$e');
      return false;
    });
  }
}
>>>>>>> Stashed changes

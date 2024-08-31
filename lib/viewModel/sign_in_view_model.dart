<<<<<<< Updated upstream
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInViewModel extends GetxController {
  Rx<TextEditingController> signInEmailController = TextEditingController().obs;
  Rx<TextEditingController> therapyCenterCodeController =
      TextEditingController().obs;
  Rx<TextEditingController> signInPasswordController =
      TextEditingController().obs;
  Rx<TextEditingController> signInPhoneNoController =
      TextEditingController().obs;

  RxBool signInShowPass = false.obs;
  RxBool isRememberMeChecked = false.obs;
  RxBool signInPhoneIsValidate = false.obs;
  RxString signInCountryCode = '91'.obs;
  // RxBool isReadOnly = true.obs;
  RxString signInRoleVal = "".obs;

  void dropDownChange(val) {
    signInRoleVal.value = val ?? "";
    // isReadOnly.value = false;
  }
}
=======
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/common_snackbar.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/collection_utils.dart';
import 'package:session_mate/utils/loading_dialog.dart';

class SignInViewModel extends GetxController {
  Rx<TextEditingController> signInEmailController = TextEditingController().obs;
  Rx<TextEditingController> signInRoleController = TextEditingController().obs;
  Rx<TextEditingController> therapyCenterCodeController = TextEditingController().obs;
  Rx<TextEditingController> signInPasswordController = TextEditingController().obs;
  Rx<TextEditingController> signInPhoneNoController = TextEditingController().obs;

  RxBool signInShowPass = false.obs;
  RxBool isRememberMeChecked = false.obs;
  RxBool signInPhoneIsValidate = false.obs;
  RxString signInCountryCode = '91'.obs;
  // RxBool isReadOnly = true.obs;
  RxString signInRoleVal = "".obs;

/*
  void dropDownChange(val) {
    signInRoleVal.value = val ?? "";
    // isReadOnly.value = false;
  }
*/

  void phoneFieldOnChange(BuildContext context, val) {
    showLoadingDialog(context: context);
    bool isOldUser = false;
    CollectionUtils.userCollection.get().then((value) {

      for (var item in value.docs) {



        if (item['id'] == signInPhoneNoController.value.text) {
          signInRoleVal.value = item['role'];
          signInRoleController.value.text = signInRoleVal.value;
          print(signInRoleVal.value);
          isOldUser = true;
          break;
        }
      }
      hideLoadingDialog(context: context);
      if (!isOldUser) {
        signInRoleController.value.text = "";
        commonSnackBar(message: AppStrings.phoneNotFound);
      }
    });
  }
}
>>>>>>> Stashed changes

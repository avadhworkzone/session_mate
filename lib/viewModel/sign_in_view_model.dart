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

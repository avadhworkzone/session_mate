import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpViewModel extends GetxController {
  Rx<TextEditingController> signUpEmailController = TextEditingController().obs;
  Rx<TextEditingController> signUpPhoneNoController =
      TextEditingController().obs;
  Rx<TextEditingController> signUpPasswordController =
      TextEditingController().obs;
  Rx<TextEditingController> signUpConfirmPasswordController =
      TextEditingController().obs;
  final Rx<GlobalKey<FormState>> signUpFormKey = GlobalKey<FormState>().obs;
  RxBool signUpShowPass = false.obs;
  RxBool signUpShowConPass = false.obs;
  RxBool signUpPhoneIsValidate = false.obs;
  RxBool isPrivacyAndTermsChecked = false.obs;
}

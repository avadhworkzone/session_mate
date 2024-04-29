import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInViewModel extends GetxController {
  Rx<TextEditingController> signInEmailController = TextEditingController().obs;
  Rx<TextEditingController> signInPasswordController =
      TextEditingController().obs;

  RxBool signInShowPass = false.obs;
  RxBool isRememberMeChecked = false.obs;
}

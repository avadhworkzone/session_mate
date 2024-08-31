import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserVerificationStatusViewModel extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController adminCommentController = TextEditingController();
  RxBool isVerify = false.obs;
  RxInt verifyIndex = (-1).obs;
  String adminComment = "";
  RxBool isCommentLoad = false.obs;

  void setVerifyIndex(int index) {
    if (verifyIndex.value == index) {
      verifyIndex.value = -1; // Toggle off if the same index is tapped
    } else {
      verifyIndex.value = index;
    }
  }
}
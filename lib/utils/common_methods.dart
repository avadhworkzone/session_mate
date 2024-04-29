import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';

///SHOW SNACK BAR MESSAGES
// commonSnackBar({required String message, Color? snackBackgroundColor}) {
//   Get.closeAllSnackbars();
//   return Get.showSnackbar(GetSnackBar(
//     messageText: CustomText(
//       message,
//       color: AppColors.white,
//       fontSize: 15,
//       textAlign: TextAlign.center,
//     ),
//     backgroundColor: snackBackgroundColor ?? AppColors.purple,
//     duration: const Duration(seconds: 2),
//     snackPosition: SnackPosition.BOTTOM,
//   ));
// }

///ERROR SHOW SNACK BAR MESSAGES
commonErrorSnackBar({required String message, Color? snackBackgroundColor}) {
  Get.closeAllSnackbars();

  return Get.showSnackbar(GetSnackBar(
    messageText: CustomText(
      message,
      color: AppColors.white,
      fontSize: 15,
      textAlign: TextAlign.center,
    ),
    backgroundColor: snackBackgroundColor ?? AppColors.red1D.withOpacity(0.9),
    duration: const Duration(seconds: 5),
    snackPosition: SnackPosition.BOTTOM,
  ));
}

///SHOW APP LOGS
logs(String logMsg) {
  if (kDebugMode) {
    log(logMsg);
  }
}

///UN FOCUS KEYBOARD
unFocus() {
  FocusManager.instance.primaryFocus?.unfocus();
}

///CAPITALIZE TEXT
commonCapitalize(String value) {
  return value.capitalizeFirst;
}

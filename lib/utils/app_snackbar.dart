<<<<<<< Updated upstream
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';

void showErrorSnackBar(String title, String message) {
  Get.closeAllSnackbars();
  Get.showSnackbar(GetSnackBar(
    titleText: title.isNotEmpty
        ? CustomText(
            title,
            textAlign: TextAlign.center,
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          )
        : null,
    messageText: CustomText(
      message,
      textAlign: TextAlign.center,
      color: AppColors.white,
      fontWeight: FontWeight.w400,
    ),
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),

    margin: EdgeInsets.symmetric(
      horizontal: 15.w,
      vertical: 30.h,
    ),
    borderRadius: 5,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.primaryColor,
    duration: const Duration(seconds: 4),
  ));
}

  showSussesSnackBar(String title, String message)  {
  Get.closeAllSnackbars();
  Get.showSnackbar(GetSnackBar(
    titleText: title.isNotEmpty
        ? CustomText(
            title,
            textAlign: TextAlign.center,
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          )
        : null,
    messageText: CustomText(
      message,
      textAlign: TextAlign.center,
      color: AppColors.white,
      fontWeight: FontWeight.w400,
    ),
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
    margin: EdgeInsets.symmetric(
      horizontal: 15.w,
      vertical: 30.h,
    ),
    borderRadius: 5,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.primaryColor,
    duration: const Duration(seconds: 4),
  ));
}

void logs(String message) {
  if (kDebugMode) {
    log(message);
  }
}

unFocus() {
  FocusManager.instance.primaryFocus?.unfocus();
}
=======
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';

void showErrorSnackBar(String title, String message) {

  Get.closeAllSnackbars();
  Get.showSnackbar(GetSnackBar(
    titleText: title.isNotEmpty
        ? CustomText(
            title,
            textAlign: TextAlign.center,
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          )
        : null,
    messageText: CustomText(
      message,
      textAlign: TextAlign.center,
      color: AppColors.white,
      fontWeight: FontWeight.w400,
    ),
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),

    margin: EdgeInsets.symmetric(
      horizontal: 15.w,
      vertical: 30.h,
    ),
    borderRadius: 5,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.primaryColor,
    duration: const Duration(seconds: 4),
  ));
}

  showSussesSnackBar(String title, String message)  {
  Get.closeAllSnackbars();
  Get.showSnackbar(GetSnackBar(
    titleText: title.isNotEmpty
        ? CustomText(
            title,
            textAlign: TextAlign.center,
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          )
        : null,
    messageText: CustomText(
      message,
      textAlign: TextAlign.center,
      color: AppColors.white,
      fontWeight: FontWeight.w400,
    ),
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
    margin: EdgeInsets.symmetric(
      horizontal: 15.w,
      vertical: 30.h,
    ),
    borderRadius: 5,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.primaryColor,
    duration: const Duration(seconds: 4),
  ));
}

void logs(String message) {
  if (kDebugMode) {
    log(message);
  }
}

unFocus() {
  FocusManager.instance.primaryFocus?.unfocus();
}
>>>>>>> Stashed changes

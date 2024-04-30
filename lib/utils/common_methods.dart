import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';

import 'app_image_assets.dart';
import 'app_string.dart';
import 'local_assets.dart';

///SHOW SNACK BAR MESSAGES
commonSnackBar({required String message, Color? snackBackgroundColor}) {
  Get.closeAllSnackbars();
  return Get.showSnackbar(GetSnackBar(
    messageText: CustomText(
      message,
      color: AppColors.white,
      fontSize: 15,
      textAlign: TextAlign.center,
    ),
    backgroundColor: snackBackgroundColor ?? AppColors.primaryColor,
    duration: const Duration(seconds: 2),
    snackPosition: SnackPosition.BOTTOM,
  ));
}

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
///COMMON APPBAR
commonAppBar({required String title, Color? color}){
  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: 30.w,vertical: 35.w),
    child: Row(
      children: [
        Padding(
          padding:  EdgeInsets.only(right: 10.w),
          child: InkWell(
            onTap: (){Get.back();},

            child: LocalAssets(
              imagePath: AppImageAssets.backArrow,height: 23.h,width: 23.w,imgColor: AppColors.white,),
          ),
        ),

        Expanded(
          child: Center(
            child: CustomText(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              fontSize: 25.sp,
              color: color ?? AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );

}
///COMMON TEXTFIELD
commonAppTextField({required String text,required TextEditingController textEditingController}){
  return SizedBox(
    height: 44.h,
    width: 239.w,
    child: TextFormField(

      controller: textEditingController,
      decoration:  InputDecoration(

          enabledBorder:const OutlineInputBorder( //Outline border type for TextFeild
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color:AppColors.white,
                width: 1.5,
              )
          ),
          hintText:text,hintStyle: TextStyle(color: AppColors.white)
      ),

    ),
  );
}
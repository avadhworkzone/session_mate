<<<<<<< Updated upstream
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';

///COMMON APPBAR
commonAppBar({required String title, Color? textColor, Color? iconColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 35.w),
    child: Row(
      children: [
        InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: iconColor ?? AppColors.primaryColor,
              size: 23.w,
            )),
        Expanded(
          child: Center(
            child: CustomText(
              title,
              fontSize: 25.sp,
              color: textColor ?? AppColors.black1c,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}
=======
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';

///COMMON APPBAR
commonAppBar({required String title, Color? textColor, Color? iconColor,void Function()? onTap}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 35.w),
    child: Row(
      children: [
        InkWell(
            onTap:  onTap ?? () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: iconColor ?? AppColors.primaryColor,
              size: 23.w,
            )),
        Expanded(
          child: Center(
            child: CustomText(
              title,
              fontSize: 25.sp,
              color: textColor ?? AppColors.black1c,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}
>>>>>>> Stashed changes

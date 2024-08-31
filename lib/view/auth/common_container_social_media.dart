import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/local_assets.dart';

Container commonSocialMediaDesign({required String imagePath}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 17.w),
    decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.whiteF4)),
    child: LocalAssets(
      imagePath: imagePath,
      height: 25.w,
    ),
  );
}

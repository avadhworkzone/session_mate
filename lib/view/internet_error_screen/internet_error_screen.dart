import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/viewModel/internet_error_view_model.dart';

class InternetErrorScreen extends StatefulWidget {
  const InternetErrorScreen({super.key});

  @override
  State<InternetErrorScreen> createState() => _InternetErrorScreenState();
}

class _InternetErrorScreenState extends State<InternetErrorScreen> {

  InternetErrorViewModel internetErrorViewModel = Get.put(InternetErrorViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100.h,
            ),
            CustomText(AppStrings.whoops,fontSize: 36.sp,color: AppColors.blue5Ecc,fontWeight: FontWeight.w500,),
            SizedBox(
              height: 28.h,
            ),
            Image.asset(AppImageAssets.noInternetImage,height: 212.h,width: 224.w,),
            SizedBox(
              height: 50.h,
            ),
            CustomText(AppStrings.itSeemsLikeSomeText,color: AppColors.black1c,fontWeight: FontWeight.w400,fontSize: 16.sp,),
            CustomText(AppStrings.disconnectedYouFromTheInternetText,color: AppColors.black1c,fontWeight: FontWeight.w400,fontSize: 16.sp,),
            CustomText(AppStrings.pleaseCheckConnectionText,color: AppColors.black1c,fontWeight: FontWeight.w400,fontSize: 16.sp,),
            CustomText(AppStrings.restartAppText,color: AppColors.black1c,fontWeight: FontWeight.w400,fontSize: 16.sp,),
            SizedBox(
              height: 56.h,
            ),
            CustomBtn(onTap: ()=> internetErrorViewModel.goSettingBtnTap(), title: AppStrings.goToSettingText,width: 353.w,)
          ],
        ),
      ),
    );
  }
}

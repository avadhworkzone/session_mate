import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/viewModel/scan_card_screen_view_model.dart';

class ScanCardScreen extends StatefulWidget {
  const ScanCardScreen({super.key});

  @override
  State<ScanCardScreen> createState() => _ScanCardScreenState();
}

class _ScanCardScreenState extends State<ScanCardScreen> {

  ScanCardScreenViewModel scanCardScreenViewModel = Get.put(ScanCardScreenViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 87.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 27.w,
                ),
                LocalAssets(
                  imagePath: AppImageAssets.backArrow,
                  height: 16.h,
                  width: 16.w,
                ),
              ],
            ),
            SizedBox(
              height: 35.h,
            ),
            Image.asset(AppImageAssets.gPayImg,height: 28.h,width: 68.w,),
            SizedBox(
              height: 24.h,
            ),
            CustomText(AppStrings.addCard,fontSize: 20.sp,fontWeight: FontWeight.w400,color: AppColors.black,),
            SizedBox(
              height: 11.h,
            ),
            CustomText(AppStrings.lineItUpFrame,fontWeight: FontWeight.w400,fontSize: 16.sp,color: AppColors.black1c,),
            SizedBox(
              height: 64.h,
            ),
            Container(
              height: 204.h,
              width: 310.w,
              decoration: BoxDecoration(
                color: AppColors.colorF5,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: AppColors.colorA2
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

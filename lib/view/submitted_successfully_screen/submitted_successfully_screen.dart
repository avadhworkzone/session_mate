import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/viewModel/submitted_successfully_view_model.dart';

class SubmittedSuccessfully extends StatefulWidget {
  const SubmittedSuccessfully({super.key});

  @override
  State<SubmittedSuccessfully> createState() => _SubmittedSuccessfullyState();
}

class _SubmittedSuccessfullyState extends State<SubmittedSuccessfully> {
  SubmittedSuccessfullyViewModel submittedSuccessfullyViewModel =
      Get.put(SubmittedSuccessfullyViewModel());

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
              height: 99.h,
            ),
            Image.asset(
              AppImageAssets.submittedSuccessfullyImage,
              height: 248.h,
              width: 264.w,
            ),
            SizedBox(
              height: 75.h,
            ),
            CustomText(
              AppStrings.submittedSuccessfully,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
            ),
            SizedBox(
              height: 51.h,
            ),
            CustomBtn(
              onTap: () => submittedSuccessfullyViewModel.returnHomeBtnTap(),
              width: 252.w,
              title: AppStrings.returnHome,
            )
          ],
        ),
      ),
    );
  }
}

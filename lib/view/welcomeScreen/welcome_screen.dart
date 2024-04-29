import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/auth/sign_in_screen.dart';
import 'package:session_mate/view/auth/sign_up_screen.dart';
import 'package:session_mate/viewModel/sign_in_view_model.dart';
import 'package:session_mate/viewModel/sign_up_view_model.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  SignUpViewModel signUpViewModel = Get.put(SignUpViewModel());
  SignInViewModel signInViewModel = Get.put(SignInViewModel());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            LocalAssets(
              imagePath: AppImageAssets.welcomeImage,
              height: Get.height / 3,
            ),
            // SizeConfig.sH40,
            SizedBox(
              height: 55.w,
            ),
            CustomText(
              AppStrings.welcomeTxt,
              fontWeight: FontWeight.w500,
              color: AppColors.black1c,
              fontSize: 26.sp,
            ),
            SizeConfig.sH20,
            CustomText(
              textAlign: TextAlign.center,
              AppStrings.descriptionTxt,
              color: AppColors.black1c.withOpacity(0.6),
              fontSize: 12.sp,
            ),
            SizedBox(
              height: 55.w,
            ),
            CustomBtn(
              title: AppStrings.createAccount,
              fontSize: 18.sp,
              onTap: () {
                Get.to(() => const SignUpScreen());
              },
            ),
            SizeConfig.sH25,
            CustomBtn(
              title: AppStrings.login,
              bgColor: AppColors.whiteFF,
              borderColor: AppColors.primaryColor,
              fontSize: 18.sp,
              textColor: AppColors.primaryColor,
              onTap: () {
                Get.to(() => const SignInScreen());
              },
            ),
            SizeConfig.sH30,
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:session_mate/commonWidget/commom_textfield.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/regex.dart';
import 'package:session_mate/utils/size_config_utils.dart';

import '../../commonWidget/custom_btn.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              const LocalAssets(
                imagePath: AppImageAssets.signUpAppBarImage,
              ),
              Positioned(
                  child: CustomText(
                AppStrings.signUp,
                color: AppColors.white,
                fontSize: 34.sp,
              ))
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.0),
                  topLeft: Radius.circular(25.0),
                ),
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.black.withOpacity(0.3),
                      spreadRadius: 0.3,
                      blurRadius: 8)
                ]),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  CommonTextField(
                    title: 'Email',
                    regularExpression: RegularExpressionUtils.emailPattern,
                    textEditController: emailController,
                    contentPadding: EdgeInsets.only(top: 10.w),
                    hintText: 'demo@gmail.com',
                    preFixIconPath: AppImageAssets.emailIcon,
                  ),
                  SizeConfig.sH17,
                  CommonTextField(
                    title: 'Phone No',
                    regularExpression: RegularExpressionUtils.emailPattern,
                    textEditController: emailController,
                    contentPadding: EdgeInsets.only(top: 10.w),
                    hintText: 'demo@gmail.com',
                    preFixIconPath: AppImageAssets.emailIcon,
                  ),
                  SizeConfig.sH17,
                  CommonTextField(
                    title: 'Password',
                    regularExpression: RegularExpressionUtils.emailPattern,
                    textEditController: emailController,
                    contentPadding: EdgeInsets.only(top: 10.w),
                    hintText: 'demo@gmail.com',
                    preFixIconPath: AppImageAssets.emailIcon,
                  ),
                  SizeConfig.sH17,
                  CommonTextField(
                    title: 'Confirm Password',
                    regularExpression: RegularExpressionUtils.emailPattern,
                    textEditController: emailController,
                    contentPadding: EdgeInsets.only(top: 10.w),
                    hintText: 'demo@gmail.com',
                    preFixIconPath: AppImageAssets.emailIcon,
                  ),
                  // CustomBtn(
                  //   title: AppStrings.createAccount,
                  //   fontSize: 18.sp,
                  //   onTap: () {},
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

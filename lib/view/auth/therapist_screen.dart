import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/commom_textfield.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_enum.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/regex.dart';
import 'package:session_mate/utils/size_config_utils.dart';

class TherapistDetailScreen extends StatefulWidget {
  const TherapistDetailScreen({super.key});

  @override
  State<TherapistDetailScreen> createState() => _TherapistDetailScreenState();
}

class _TherapistDetailScreenState extends State<TherapistDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              const LocalAssets(
                imagePath: AppImageAssets.signUpAppBarImage,
              ),
              Positioned(
                  child: Padding(
                padding: EdgeInsets.only(bottom: 10.w),
                child: CustomText(
                  AppStrings.therapistDetail,
                  color: AppColors.white,
                  fontSize: 28.sp,
                ),
              ))
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  LocalAssets(
                    imagePath: AppImageAssets.therapistImage,
                    height: Get.width / 1.3,
                    width: Get.width / 1.3,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: Get.width / 7.5,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            topLeft: Radius.circular(25.0),
                          ),
                          color: AppColors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(0.3),
                              spreadRadius: 0.3,
                              blurRadius: 8,
                            )
                          ]),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 45.w),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Form(
                            child: Column(
                              children: [
                                CommonTextField(
                                  title: AppStrings.therapistName,
                                  regularExpression:
                                      RegularExpressionUtils.address,
                                  // textEditController:
                                  // signUpViewModel.signUpUserNameController.value,
                                  contentPadding:
                                      EdgeInsets.only(bottom: 9.w, top: 6.w),
                                  hintText: AppStrings.userNameHintTxt,
                                  preFixIconPath: AppImageAssets.profileIcon,
                                  validationType: ValidationTypeEnum.address,
                                  validationMessage: AppStrings.emailIsRequired,
                                ),
                                SizeConfig.sH25,
                                CommonTextField(
                                  // textEditController: signUpViewModel
                                  //     .therapyCenterCodeController.value,
                                  title: AppStrings.therapyCenterCode,
                                  // validationType: ValidationTypeEnum.password,
                                  // regularExpression:
                                  //     RegularExpressionUtils.therapyCenterCode,
                                  validationMessage:
                                      AppStrings.centerCodeIsRequired,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 7.w,
                                  ),
                                  hintText: AppStrings.centerCodeHintTxt,
                                  textInputAction: TextInputAction.done,
                                  obscureValue: false,
                                  preFixIconPath: AppImageAssets.passwordIcon,
                                  regularExpression: '',
                                ),
                                SizeConfig.sH45,
                                CustomBtn(
                                  title: AppStrings.submit,
                                  fontSize: 18.sp,
                                  textColor: AppColors.whiteFF,
                                  onTap: () {},
                                ),
                                SizeConfig.sH15,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

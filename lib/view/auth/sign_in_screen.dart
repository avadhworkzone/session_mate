import 'package:flutter/material.dart';
import 'package:session_mate/commonWidget/commom_textfield.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_enum.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:session_mate/utils/regex.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/auth/common_container_social_media.dart';
import 'package:session_mate/view/auth/sign_up_screen.dart';
import 'package:session_mate/view/bottomBar/bottom_bar_screen.dart';
import 'package:session_mate/view/welcomeScreen/welcome_screen.dart';
import 'package:session_mate/viewModel/sign_in_view_model.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  SignInViewModel signInViewModel = Get.find();
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    signInFormKey.currentState?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAll(() => WelcomeScreen());
        return Future.value(true);
      },
      child: Material(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                const LocalAssets(
                  imagePath: AppImageAssets.signInAppBarImage,
                ),
                Positioned(
                    child: CustomText(
                  AppStrings.login,
                  color: AppColors.black1c,
                  fontSize: 34.sp,
                ))
              ],
            ),
            Obx(() {
              return Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: Get.width / 2.8,
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
                                  blurRadius: 8)
                            ]),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 30.w),
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Form(
                              key: signInFormKey,
                              child: Column(
                                children: [
                                  CommonTextField(
                                    title: AppStrings.email,
                                    regularExpression:
                                        RegularExpressionUtils.emailPattern,
                                    textEditController: signInViewModel
                                        .signInEmailController.value,
                                    keyBoardType: TextInputType.emailAddress,
                                    contentPadding:
                                        EdgeInsets.only(bottom: 9.w, top: 6.w),
                                    hintText: AppStrings.emailHintTxt,
                                    preFixIconPath: AppImageAssets.emailIcon,
                                    isValidate: true,
                                    validationType: ValidationTypeEnum.email,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizeConfig.sH20,
                                  CommonTextField(
                                    title: AppStrings.password,
                                    regularExpression:
                                        RegularExpressionUtils.passwordPattern,
                                    textEditController: signInViewModel
                                        .signInPasswordController.value,
                                    keyBoardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 7.w,
                                    ),
                                    hintText: AppStrings.passwordHintTxt,
                                    preFixIconPath: AppImageAssets.passwordIcon,
                                    validationType: ValidationTypeEnum.password,
                                    obscureValue:
                                        signInViewModel.signInShowPass.value ==
                                                true
                                            ? false
                                            : true,
                                    sIcon: InkWell(
                                      onTap: () {
                                        signInViewModel.signInShowPass.value =
                                            !signInViewModel
                                                .signInShowPass.value;
                                      },
                                      child: LocalAssets(
                                        imagePath: signInViewModel
                                                    .signInShowPass.value ==
                                                true
                                            ? AppImageAssets.eyeIcon
                                            : AppImageAssets.passwordViewIcon,
                                        height: 22.w,
                                      ),
                                    ),
                                    isValidate: true,
                                  ),

                                  SizeConfig.sH15,
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.w),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: Transform.scale(
                                            scale: 1.1,
                                            child: Checkbox(
                                              activeColor:
                                                  AppColors.primaryColor,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              side: BorderSide(
                                                  width: 1,
                                                  color: AppColors.black1c
                                                      .withOpacity(0.8)),
                                              value: signInViewModel
                                                  .isRememberMeChecked.value,
                                              onChanged: (value) {
                                                signInViewModel
                                                    .isRememberMeChecked
                                                    .value = value!;
                                              },
                                            ),
                                          ),
                                        ),
                                        SizeConfig.sW10,
                                        CustomText(
                                          AppStrings.rememberMe,
                                        ),
                                        const Spacer(),
                                        CustomText(
                                          AppStrings.forgotPassword,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizeConfig.sH35,
                                  CustomBtn(
                                    title: AppStrings.login,
                                    fontSize: 18.sp,
                                    textColor: AppColors.whiteFF,
                                    onTap: () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      if (signInFormKey.currentState!
                                          .validate()) {
                                        Get.to(() => const BottomBar());
                                      }
                                    },
                                  ),
                                  SizeConfig.sH20,
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Expanded(
                                        child: Divider(
                                          color: AppColors.whiteF4,
                                          endIndent: 10,
                                          thickness: 1.5,
                                        ),
                                      ),
                                      CustomText(AppStrings.loginWith,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.white7C),
                                      const Expanded(
                                        child: Divider(
                                          color: AppColors.whiteF4,
                                          indent: 10,
                                          thickness: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizeConfig.sH22,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      commonSocialMediaDesign(
                                          imagePath:
                                              AppImageAssets.facebookImage),
                                      commonSocialMediaDesign(
                                          imagePath:
                                              AppImageAssets.googleImage),
                                      commonSocialMediaDesign(
                                          imagePath: AppImageAssets.appleImage)
                                    ],
                                  ),
                                  SizeConfig.sH15,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(AppStrings.doNotHaveAccountTxt,
                                          fontSize: 15.sp,
                                          color: AppColors.black1c),
                                      InkWell(
                                        onTap: () {
                                          signInViewModel
                                              .signInEmailController.value
                                              .clear();
                                          signInViewModel
                                              .signInPasswordController.value
                                              .clear();
                                          Get.to(() => const SignUpScreen());
                                        },
                                        child: CustomText(AppStrings.signUp,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.sp,
                                            color: AppColors.primaryColor),
                                      )
                                    ],
                                  ),

                                  // SizedBox(
                                  //   height: MediaQuery.of(context).viewInsets.bottom,
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          right: 20.w,
                          child: LocalAssets(
                            imagePath: AppImageAssets.signInManImage,
                            height: Get.width * 0.5,
                            width: Get.width * 0.5,
                          ))
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:session_mate/commonWidget/commom_textfield.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_constant.dart';
import 'package:session_mate/utils/app_enum.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/regex.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/auth/sign_in_screen.dart';
import 'package:session_mate/view/services/webview_widget.dart';
import 'package:session_mate/view/welcomeScreen/welcome_screen.dart';
import 'package:session_mate/viewModel/sign_up_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpViewModel signUpViewModel = Get.find();

  @override
  void dispose() {
    signUpViewModel.signUpFormKey.value.currentState?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        signUpViewModel.signUpPhoneIsValidate.value = false;
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
            Obx(() {
              return Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: Get.width / 2.4,
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
                              horizontal: 20.w, vertical: 35.w),
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Form(
                              key: signUpViewModel.signUpFormKey.value,
                              child: Column(
                                children: [
                                  CommonTextField(
                                    title: AppStrings.email,
                                    regularExpression:
                                        RegularExpressionUtils.emailPattern,
                                    textEditController: signUpViewModel
                                        .signUpEmailController.value,
                                    keyBoardType: TextInputType.emailAddress,
                                    contentPadding:
                                        EdgeInsets.only(bottom: 9.w, top: 6.w),
                                    hintText: AppStrings.emailHintTxt,
                                    preFixIconPath: AppImageAssets.emailIcon,
                                    isValidate: true,
                                    validationType: ValidationTypeEnum.email,
                                    textInputAction: TextInputAction.next,
                                    validationMessage:
                                        AppStrings.emailIsRequired,
                                  ),
                                  SizeConfig.sH20,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomText(
                                        AppStrings.phoneNo,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            AppColors.black1c.withOpacity(0.8),
                                      ),
                                      SizedBox(
                                        height: 60.w,
                                        child: IntlPhoneField(
                                          showDropdownIcon: false,
                                          textAlignVertical:
                                              TextAlignVertical.bottom,
                                          textInputAction: TextInputAction.done,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          controller: signUpViewModel
                                              .signUpPhoneNoController.value,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType: TextInputType.number,
                                          initialCountryCode: 'IN',
                                          onChanged: (val) {
                                            if (val.toString().isNotEmpty) {
                                              signUpViewModel
                                                  .signUpPhoneIsValidate
                                                  .value = false;
                                            }
                                          },
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: AppColors.black,
                                              fontFamily: AppConstants.inter,
                                              fontWeight: FontWeight.w400),
                                          decoration: InputDecoration(
                                            isDense: true,
                                            fillColor: Colors.transparent,
                                            filled: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10.h),
                                            hintText: AppStrings.phoneNoHintTxt,
                                            hintStyle: TextStyle(
                                              color: AppColors.black1c
                                                  .withOpacity(0.5),
                                              fontSize: 14.sp,
                                              fontFamily: AppConstants.inter,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            // contentPadding: EdgeInsets.zero,
                                            errorText: (signUpViewModel
                                                            .signUpPhoneIsValidate
                                                            .value ==
                                                        true &&
                                                    signUpViewModel
                                                        .signUpPhoneNoController
                                                        .value
                                                        .text
                                                        .isEmpty)
                                                ? AppStrings
                                                    .phoneNumberIsRequired
                                                : null,
                                            errorBorder: (signUpViewModel
                                                            .signUpPhoneIsValidate
                                                            .value ==
                                                        true &&
                                                    signUpViewModel
                                                        .signUpPhoneNoController
                                                        .value
                                                        .text
                                                        .isEmpty)
                                                ? const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: AppColors.red1D),
                                                  )
                                                : UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: AppColors.black1c
                                                            .withOpacity(0.4))),
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors.black1c
                                                        .withOpacity(0.4))),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors.black1c
                                                        .withOpacity(0.4))),
                                            disabledBorder:
                                                UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: AppColors.black1c
                                                            .withOpacity(0.4))),
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors.black1c
                                                        .withOpacity(0.4))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizeConfig.sH20,
                                  CommonTextField(
                                    title: AppStrings.password,
                                    regularExpression:
                                        RegularExpressionUtils.passwordPattern,
                                    textEditController: signUpViewModel
                                        .signUpPasswordController.value,
                                    keyBoardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 7.w,
                                    ),
                                    hintText: AppStrings.passwordHintTxt,
                                    preFixIconPath: AppImageAssets.passwordIcon,
                                    validationType: ValidationTypeEnum.password,
                                    validationMessage:
                                        AppStrings.passwordIsRequired,
                                    obscureValue:
                                        signUpViewModel.signUpShowPass.value ==
                                                true
                                            ? false
                                            : true,
                                    sIcon: InkWell(
                                      onTap: () {
                                        signUpViewModel.signUpShowPass.value =
                                            !signUpViewModel
                                                .signUpShowPass.value;
                                      },
                                      child: LocalAssets(
                                        imagePath: signUpViewModel
                                                    .signUpShowPass.value ==
                                                true
                                            ? AppImageAssets.eyeIcon
                                            : AppImageAssets.passwordViewIcon,
                                        height: 22.w,
                                      ),
                                    ),
                                    isValidate: true,
                                  ),
                                  SizeConfig.sH20,
                                  CommonTextField(
                                    textEditController: signUpViewModel
                                        .signUpConfirmPasswordController.value,
                                    title: AppStrings.confirmPassword,
                                    regularExpression:
                                        RegularExpressionUtils.passwordPattern,
                                    keyBoardType: TextInputType.text,
                                    validationMessage:
                                        AppStrings.confirmPasswordIsRequired,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 7.w,
                                    ),
                                    hintText: AppStrings.passwordHintTxt,
                                    textInputAction: TextInputAction.done,
                                    obscureValue: signUpViewModel
                                                .signUpShowConPass.value ==
                                            true
                                        ? false
                                        : true,
                                    preFixIconPath: AppImageAssets.passwordIcon,
                                    sIcon: InkWell(
                                      onTap: () {
                                        signUpViewModel
                                                .signUpShowConPass.value =
                                            !signUpViewModel
                                                .signUpShowConPass.value;
                                      },
                                      child: LocalAssets(
                                        imagePath: signUpViewModel
                                                    .signUpShowConPass.value ==
                                                true
                                            ? AppImageAssets.eyeIcon
                                            : AppImageAssets.passwordViewIcon,
                                        height: 22.w,
                                      ),
                                    ),
                                  ),
                                  SizeConfig.sH20,
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Transform.scale(
                                          scale: 1.1,
                                          child: Checkbox(
                                            activeColor: AppColors.primaryColor,
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
                                            value: signUpViewModel
                                                .isPrivacyAndTermsChecked.value,
                                            onChanged: (value) {
                                              signUpViewModel
                                                  .isPrivacyAndTermsChecked
                                                  .value = value!;
                                            },
                                          ),
                                        ),
                                      ),
                                      SizeConfig.sW20,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            AppStrings.privacyAndTermsCheckTxt,
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Get.to(const WebViewExample(
                                                    url: AppStrings
                                                        .privacyPolicyUrl,
                                                  ));
                                                },
                                                child: CustomText(
                                                  AppStrings.termsConditionTxt,
                                                  fontWeight: FontWeight.w600,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: AppColors.black1c,
                                                ),
                                              ),
                                              SizeConfig.sW5,
                                              CustomText(
                                                AppStrings.and,
                                              ),
                                              SizeConfig.sW5,
                                              InkWell(
                                                onTap: () {
                                                  Get.to(const WebViewExample(
                                                    url: AppStrings
                                                        .privacyPolicyUrl,
                                                  ));
                                                },
                                                child: CustomText(
                                                  AppStrings.privacyPoliceTxt,
                                                  fontWeight: FontWeight.w600,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: AppColors.black1c,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                      // Expanded(
                                      //   child: CustomText(
                                      //     AppStrings.privacyAndTermsCheckTxt,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  SizeConfig.sH30,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(AppStrings.alreadyHaveAccount,
                                          fontSize: 15.sp,
                                          color: AppColors.black1c),
                                      InkWell(
                                        onTap: () {
                                          signUpViewModel
                                              .signUpEmailController.value
                                              .clear();
                                          signUpViewModel
                                              .signUpPhoneNoController.value
                                              .clear();
                                          signUpViewModel
                                              .signUpPasswordController.value
                                              .clear();
                                          signUpViewModel
                                              .signUpConfirmPasswordController
                                              .value
                                              .clear();
                                          signUpViewModel.signUpPhoneIsValidate
                                              .value = false;
                                          Get.off(() => const SignInScreen());
                                        },
                                        child: CustomText(AppStrings.login,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.sp,
                                            color: AppColors.primaryColor),
                                      )
                                    ],
                                  ),
                                  SizeConfig.sH10,
                                  CustomBtn(
                                    title: AppStrings.createAccount,
                                    fontSize: 18.sp,
                                    textColor: AppColors.whiteFF,
                                    onTap: () {
                                      signUpViewModel
                                          .signUpPhoneIsValidate.value = true;
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      if (signUpViewModel
                                              .signUpFormKey.value.currentState!
                                              .validate() &&
                                          signUpViewModel
                                              .signUpPhoneNoController
                                              .value
                                              .text
                                              .isNotEmpty) {
                                        if (signUpViewModel
                                                .signUpPasswordController
                                                .value
                                                .text !=
                                            signUpViewModel
                                                .signUpConfirmPasswordController
                                                .value
                                                .text) {
                                          commonErrorSnackBar(
                                              message:
                                                  AppStrings.passValidation);
                                        }
                                      }
                                    },
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
                            imagePath: AppImageAssets.signUpManImage,
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

<<<<<<< Updated upstream
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:session_mate/commonWidget/commom_textfield.dart';
import 'package:session_mate/commonWidget/common_snackbar.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_constant.dart';
import 'package:session_mate/utils/app_enum.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/regex.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/auth/send_otp_method.dart';
import 'package:session_mate/view/auth/sign_in_screen.dart';
import 'package:session_mate/view/auth/therapist_screen.dart';
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
        Get.offAll(() => const WelcomeScreen());
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
                              horizontal: 20.w, vertical: 55.w),
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Form(
                              key: signUpViewModel.signUpFormKey.value,
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      CommonDropdownField(
                                          onChanged: (val) => signUpViewModel
                                              .dropDownChange(val)),
                                      SizeConfig.sH20,
                                      signUpViewModel.roleVal.value ==
                                              AppStrings.therapist
                                          ? const SizedBox()
                                          : CommonTextField(
                                              title: AppStrings.childName,
                                              regularExpression:
                                                  RegularExpressionUtils
                                                      .address,
                                              textEditController:
                                                  signUpViewModel
                                                      .signUpUserNameController
                                                      .value,
                                              contentPadding: EdgeInsets.only(
                                                  bottom: 9.w, top: 6.w),
                                              hintText:
                                                  AppStrings.userNameHintTxt,
                                              preFixIconPath:
                                                  AppImageAssets.profileIcon,
                                              validationType:
                                                  ValidationTypeEnum.address,
                                              validationMessage: AppStrings
                                                  .childNameIsRequired,
                                            ),
                                      signUpViewModel.roleVal.value ==
                                              AppStrings.therapist
                                          ? const SizedBox()
                                          : SizeConfig.sH20,
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: CustomText(
                                          AppStrings.dateOfBirth,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black1c
                                              .withOpacity(0.8),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: signUpViewModel
                                            .dateOfBirthController.value,
                                        onTap: () =>
                                            signUpViewModel.selectDate(context),
                                        readOnly: true,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.black,
                                            fontFamily: AppConstants.inter,
                                            fontWeight: FontWeight.w400),
                                        keyboardType: TextInputType.text,
                                        maxLines: 1,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(
                                                  RegularExpressionUtils.text)),
                                          NoLeadingSpaceFormatter(),
                                          TextFormatter(),
                                        ],
                                        validator: (value) {
                                          return ValidationMethod.validateDate(
                                              value);
                                        },
                                        textInputAction: TextInputAction.next,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        cursorColor: AppColors.black1c,
                                        cursorWidth: 1.5,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          fillColor: Colors.transparent,
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 15.w, vertical: 10.h),
                                          hintText: AppStrings.dateFormat,
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.black1c
                                                      .withOpacity(0.4))),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.black1c
                                                      .withOpacity(0.4))),
                                          disabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.black1c
                                                      .withOpacity(0.4))),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.black1c
                                                      .withOpacity(0.4))),
                                          prefixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const LocalAssets(
                                                imagePath:
                                                    AppImageAssets.calenderIcn,
                                              ),
                                              SizeConfig.sW8,
                                              Container(
                                                color: AppColors.black1c
                                                    .withOpacity(0.3),
                                                height: 17,
                                                width: 1,
                                              ),
                                              SizeConfig.sW8,
                                            ],
                                          ),
                                          prefixIconConstraints:
                                              BoxConstraints(maxWidth: 50.w),
                                          suffixIconConstraints:
                                              BoxConstraints(maxWidth: 50.w),
                                          counterText: ''.tr,
                                          // filled: true,
                                          // fillColor: ColorUtils.greyE7,
                                          labelStyle: TextStyle(
                                              fontSize: 14.sp,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w600),
                                          hintStyle: TextStyle(
                                            color: AppColors.black1c
                                                .withOpacity(0.5),
                                            fontSize: 14.sp,
                                            fontFamily: AppConstants.inter,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          errorMaxLines: 2,
                                        ),
                                      ),
                                      // CommonTextField(
                                      //   onTap: () {
                                      //     print('jndjewdfhewfbg');
                                      //   },
                                      //   readOnly: true,
                                      //   title: AppStrings.dateOfBirth,
                                      //   regularExpression:
                                      //       RegularExpressionUtils.text,
                                      //   textEditController: signUpViewModel
                                      //       .dateOfBirthController.value,
                                      //   contentPadding: EdgeInsets.only(
                                      //       bottom: 9.w, top: 6.w),
                                      //   hintText: AppStrings.dateFormat,
                                      //   preFixIconPath:
                                      //       AppImageAssets.calenderIcn,
                                      //   validationMessage:
                                      //       AppStrings.selectDate,
                                      // ),
                                      // Align(
                                      //   alignment: Alignment.centerLeft,
                                      //   child: CustomText(
                                      //     AppStrings.dateOfBirth,
                                      //     fontSize: 15.sp,
                                      //     fontWeight: FontWeight.w500,
                                      //     color: AppColors.black1c
                                      //         .withOpacity(0.8),
                                      //   ),
                                      // ),

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
                                            color: AppColors.black1c
                                                .withOpacity(0.8),
                                          ),
                                          SizedBox(
                                            height: 60.w,
                                            child: IntlPhoneField(
                                              // readOnly: signUpViewModel
                                              //     .isReadOnly.value,
                                              showDropdownIcon: false,
                                              textAlignVertical:
                                                  TextAlignVertical.bottom,
                                              textInputAction:
                                                  TextInputAction.done,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              controller: signUpViewModel
                                                  .signUpPhoneNoController
                                                  .value,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              keyboardType:
                                                  TextInputType.number,
                                              initialCountryCode: 'IN',
                                              onChanged: (val) {
                                                if (val.toString().isNotEmpty) {
                                                  signUpViewModel
                                                      .signUpPhoneIsValidate
                                                      .value = false;
                                                }
                                              },
                                              onCountryChanged: (val) {
                                                signUpViewModel
                                                    .signUpCountryCode
                                                    .value = val.dialCode;
                                              },
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: AppColors.black,
                                                  fontFamily:
                                                      AppConstants.inter,
                                                  fontWeight: FontWeight.w400),
                                              decoration: InputDecoration(
                                                isDense: true,
                                                fillColor: Colors.transparent,
                                                filled: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10.h),
                                                hintText:
                                                    AppStrings.phoneNoHintTxt,
                                                hintStyle: TextStyle(
                                                  color: AppColors.black1c
                                                      .withOpacity(0.5),
                                                  fontSize: 14.sp,
                                                  fontFamily:
                                                      AppConstants.inter,
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
                                                            color: AppColors
                                                                .red1D),
                                                      )
                                                    : UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: AppColors
                                                                .black1c
                                                                .withOpacity(
                                                                    0.4))),
                                                border: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: AppColors.black1c
                                                            .withOpacity(0.4))),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: AppColors
                                                                .black1c
                                                                .withOpacity(
                                                                    0.4))),
                                                disabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: AppColors
                                                                .black1c
                                                                .withOpacity(
                                                                    0.4))),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: AppColors
                                                                .black1c
                                                                .withOpacity(
                                                                    0.4))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizeConfig.sH20,
                                      CommonTextField(
                                        // readOnly:
                                        //     signUpViewModel.isReadOnly.value,
                                        title: AppStrings.email,
                                        regularExpression:
                                            RegularExpressionUtils.emailPattern,
                                        textEditController: signUpViewModel
                                            .signUpEmailController.value,
                                        keyBoardType:
                                            TextInputType.emailAddress,
                                        contentPadding: EdgeInsets.only(
                                            bottom: 9.w, top: 6.w),
                                        hintText: AppStrings.emailHintTxt,
                                        preFixIconPath:
                                            AppImageAssets.emailIcon,
                                        isValidate: true,
                                        validationType:
                                            ValidationTypeEnum.email,
                                        textInputAction: TextInputAction.next,
                                        validationMessage:
                                            AppStrings.emailIsRequired,
                                      ),
                                      SizeConfig.sH20,
                                      CommonTextField(
                                        // readOnly:
                                        //     signUpViewModel.isReadOnly.value,
                                        title: AppStrings.password,
                                        regularExpression:
                                            RegularExpressionUtils
                                                .passwordPattern,
                                        textEditController: signUpViewModel
                                            .signUpPasswordController.value,
                                        keyBoardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 7.w,
                                        ),
                                        hintText: AppStrings.passwordHintTxt,
                                        preFixIconPath:
                                            AppImageAssets.passwordIcon,
                                        validationType:
                                            ValidationTypeEnum.password,
                                        validationMessage:
                                            AppStrings.passwordIsRequired,
                                        obscureValue: signUpViewModel
                                                    .signUpShowPass.value ==
                                                true
                                            ? false
                                            : true,
                                        sIcon: InkWell(
                                          onTap: () {
                                            signUpViewModel
                                                    .signUpShowPass.value =
                                                !signUpViewModel
                                                    .signUpShowPass.value;
                                          },
                                          child: LocalAssets(
                                            imagePath: signUpViewModel
                                                        .signUpShowPass.value ==
                                                    true
                                                ? AppImageAssets.eyeIcon
                                                : AppImageAssets
                                                    .passwordViewIcon,
                                            height: 22.w,
                                          ),
                                        ),
                                        isValidate: true,
                                      ),
                                      SizeConfig.sH20,
                                      CommonTextField(
                                        // readOnly:
                                        //     signUpViewModel.isReadOnly.value,
                                        textEditController: signUpViewModel
                                            .signUpConfirmPasswordController
                                            .value,
                                        title: AppStrings.confirmPassword,
                                        validationType:
                                            ValidationTypeEnum.password,
                                        regularExpression:
                                            RegularExpressionUtils
                                                .passwordPattern,
                                        keyBoardType: TextInputType.text,
                                        validationMessage: AppStrings
                                            .confirmPasswordIsRequired,
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
                                        preFixIconPath:
                                            AppImageAssets.passwordIcon,
                                        sIcon: InkWell(
                                          onTap: () {
                                            signUpViewModel
                                                    .signUpShowConPass.value =
                                                !signUpViewModel
                                                    .signUpShowConPass.value;
                                          },
                                          child: LocalAssets(
                                            imagePath: signUpViewModel
                                                        .signUpShowConPass
                                                        .value ==
                                                    true
                                                ? AppImageAssets.eyeIcon
                                                : AppImageAssets
                                                    .passwordViewIcon,
                                            height: 22.w,
                                          ),
                                        ),
                                      ),
                                      SizeConfig.sH20,
                                      // CommonTextField(
                                      //   readOnly:
                                      //       signUpViewModel.isReadOnly.value,
                                      //   textEditController: signUpViewModel
                                      //       .therapyCenterCodeController
                                      //       .value,
                                      //   title: AppStrings.therapyCenterCode,
                                      //   validationType:
                                      //       ValidationTypeEnum.password,
                                      //   regularExpression:
                                      //       RegularExpressionUtils
                                      //           .therapyCenterCode,
                                      //   validationMessage:
                                      //       AppStrings.centerCodeIsRequired,
                                      //   contentPadding: EdgeInsets.symmetric(
                                      //     vertical: 7.w,
                                      //   ),
                                      //   hintText:
                                      //       AppStrings.centerCodeHintTxt,
                                      //   textInputAction: TextInputAction.done,
                                      //   obscureValue: false,
                                      //   preFixIconPath:
                                      //       AppImageAssets.passwordIcon,
                                      // ),
                                    ],
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
                                                  // navigate(view: const WebViewExample(
                                                  //   url: AppStrings
                                                  //       .privacyPolicyUrl,
                                                  // ));
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
                                                  /*navigate(view: const WebViewExample(
                                                    url: AppStrings
                                                        .privacyPolicyUrl,
                                                  ));*/
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
                                        } else if (signUpViewModel
                                                .roleVal.value ==
                                            "") {
                                          commonSnackBar(
                                              message:
                                                  AppStrings.pleaseSelectRole);
                                        } else if (!signUpViewModel
                                            .isPrivacyAndTermsChecked.value) {
                                          commonSnackBar(
                                              message: AppStrings
                                                  .agreeTermsCondition);
                                        } else {
                                          if (signUpViewModel.roleVal.value ==
                                              AppStrings.therapist) {
                                            Get.to(() =>
                                                const TherapistDetailScreen());
                                          } else {
                                            sendOtp(
                                                phoneNumber: signUpViewModel
                                                    .signUpPhoneNoController
                                                    .value
                                                    .text,
                                                countryCode: signUpViewModel
                                                    .signUpCountryCode.value,
                                                context: context,
                                                isLoginScreen: false);
                                          }
                                        }
                                      }
                                    },
                                  ),
                                  SizeConfig.sH15,
                                  // Row(
                                  //   mainAxisSize: MainAxisSize.min,
                                  //   children: [
                                  //     const Expanded(
                                  //       child: Divider(
                                  //         color: AppColors.whiteF4,
                                  //         endIndent: 10,
                                  //         thickness: 1.5,
                                  //       ),
                                  //     ),
                                  //     CustomText(AppStrings.registerWith,
                                  //         fontSize: 15.sp, color: AppColors.black1c),
                                  //     const Expanded(
                                  //       child: Divider(
                                  //         color: AppColors.whiteF4,
                                  //         indent: 10,
                                  //         thickness: 1.5,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizeConfig.sH22,
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     commonSocialMediaDesign(
                                  //         imagePath: AppImageAssets.facebookImage),
                                  //     commonSocialMediaDesign(
                                  //         imagePath: AppImageAssets.googleImage),
                                  //     commonSocialMediaDesign(imagePath: AppImageAssets.appleImage)
                                  //   ],
                                  // ),
                                  // SizeConfig.sH15,
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
                            height: Get.width / 3,
                            width: Get.width / 3,
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

class CommonDropdownField extends StatelessWidget {
  final void Function(String?)? onChanged;
  const CommonDropdownField({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          AppStrings.role,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black1c.withOpacity(0.8),
        ),
        SizedBox(
          width: Get.width,
          child: DropdownButtonFormField(
            items: [
              DropdownMenuItem(
                value: AppStrings.therapist,
                child: CustomText(AppStrings.therapist),
              ),
              DropdownMenuItem(
                value: AppStrings.caregiver,
                child: CustomText(AppStrings.caregiver),
              ),
            ],
            onChanged: onChanged,
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
                  EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              hintText: AppStrings.selectRole.tr,
              hintStyle: TextStyle(
                color: AppColors.black1c.withOpacity(0.5),
                fontSize: 14.sp,
                fontFamily: AppConstants.inter,
                fontWeight: FontWeight.normal,
              ),
              border: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.black1c.withOpacity(0.4))),
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.black1c.withOpacity(0.4))),
              disabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.black1c.withOpacity(0.4))),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.black1c.withOpacity(0.4))),
            ),
          ),
        ),
      ],
    );
  }
}

///COMMON ROUNDED TEXTFIELD
commonRoundedTextField(
    {required String text,
    required TextEditingController textEditingController,
    void Function(String)? onChanged}) {
  return SizedBox(
    width: Get.width / 1.5,
    child: TextFormField(
      onChanged: onChanged,
      controller: textEditingController,
      cursorColor: AppColors.white,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 15.w),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: AppColors.white,
                width: 1.5,
              )),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: AppColors.white,
                width: 1.5,
              )),
          hintText: text,
          hintStyle: TextStyle(color: AppColors.white)),
    ),
  );
}
=======
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:session_mate/commonWidget/commom_textfield.dart';
import 'package:session_mate/commonWidget/common_snackbar.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_constant.dart';
import 'package:session_mate/utils/app_enum.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/regex.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/auth/send_otp_method.dart';
import 'package:session_mate/view/auth/sign_in_screen.dart';
import 'package:session_mate/view/auth/therapist_screen.dart';
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
      onWillPop: (){
        signUpViewModel.signUpPhoneIsValidate.value = false;
        Get.offAll(() => const WelcomeScreen());
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
                              horizontal: 20.w, vertical: 55.w),
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Form(
                              key: signUpViewModel.signUpFormKey.value,
                              child: Column(
                                children: [
                                  Column(
                                    children: [

                                      CommonDropdownField(
                                          onChanged: (val) => signUpViewModel
                                              .dropDownChange(val)),
                                      SizeConfig.sH20,
                                      signUpViewModel.roleVal.value ==
                                              AppStrings.therapist
                                          ? const SizedBox()
                                          : CommonTextField(
                                              title: AppStrings.childName,
                                              regularExpression:
                                                  RegularExpressionUtils
                                                      .address,
                                              textEditController:
                                                  signUpViewModel.signUpUserNameController.value,
                                              contentPadding: EdgeInsets.only(
                                                  bottom: 9.w, top: 6.w),
                                              hintText:
                                                  AppStrings.userNameHintTxt,
                                              preFixIconPath:
                                                  AppImageAssets.profileIcon,
                                              validationType:
                                                  ValidationTypeEnum.address,
                                              validationMessage: AppStrings
                                                  .childNameIsRequired,
                                            ),
                                      signUpViewModel.roleVal.value ==
                                              AppStrings.therapist
                                          ? const SizedBox()
                                          : SizeConfig.sH20,
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: CustomText(
                                          AppStrings.dateOfBirth,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black1c
                                              .withOpacity(0.8),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: signUpViewModel
                                            .dateOfBirthController.value,
                                        onTap: () =>
                                            signUpViewModel.selectDate(context),
                                        readOnly: true,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: AppColors.black,
                                            fontFamily: AppConstants.inter,
                                            fontWeight: FontWeight.w400),
                                        keyboardType: TextInputType.text,
                                        maxLines: 1,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(
                                                  RegularExpressionUtils.text)),
                                          NoLeadingSpaceFormatter(),
                                          TextFormatter(),
                                        ],
                                        validator: (value) {
                                          return ValidationMethod.validateDate(
                                              value);
                                        },
                                        textInputAction: TextInputAction.next,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        cursorColor: AppColors.black1c,
                                        cursorWidth: 1.5,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          fillColor: Colors.transparent,
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 15.w, vertical: 10.h),
                                          hintText: AppStrings.dateFormat,
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.black1c
                                                      .withOpacity(0.4))),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.black1c
                                                      .withOpacity(0.4))),
                                          disabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.black1c
                                                      .withOpacity(0.4))),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors.black1c
                                                      .withOpacity(0.4))),
                                          prefixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const LocalAssets(
                                                imagePath:
                                                    AppImageAssets.calenderIcn,
                                              ),
                                              SizeConfig.sW8,
                                              Container(
                                                color: AppColors.black1c
                                                    .withOpacity(0.3),
                                                height: 17,
                                                width: 1,
                                              ),
                                              SizeConfig.sW8,
                                            ],
                                          ),
                                          prefixIconConstraints:
                                              BoxConstraints(maxWidth: 50.w),
                                          suffixIconConstraints:
                                              BoxConstraints(maxWidth: 50.w),
                                          counterText: ''.tr,
                                          // filled: true,
                                          // fillColor: ColorUtils.greyE7,
                                          labelStyle: TextStyle(
                                              fontSize: 14.sp,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w600),
                                          hintStyle: TextStyle(
                                            color: AppColors.black1c
                                                .withOpacity(0.5),
                                            fontSize: 14.sp,
                                            fontFamily: AppConstants.inter,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          errorMaxLines: 2,
                                        ),
                                      ),
                                      // CommonTextField(
                                      //   onTap: () {
                                      //     print('jndjewdfhewfbg');
                                      //   },
                                      //   readOnly: true,
                                      //   title: AppStrings.dateOfBirth,
                                      //   regularExpression:
                                      //       RegularExpressionUtils.text,
                                      //   textEditController: signUpViewModel
                                      //       .dateOfBirthController.value,
                                      //   contentPadding: EdgeInsets.only(
                                      //       bottom: 9.w, top: 6.w),
                                      //   hintText: AppStrings.dateFormat,
                                      //   preFixIconPath:
                                      //       AppImageAssets.calenderIcn,
                                      //   validationMessage:
                                      //       AppStrings.selectDate,
                                      // ),
                                      // Align(
                                      //   alignment: Alignment.centerLeft,
                                      //   child: CustomText(
                                      //     AppStrings.dateOfBirth,
                                      //     fontSize: 15.sp,
                                      //     fontWeight: FontWeight.w500,
                                      //     color: AppColors.black1c
                                      //         .withOpacity(0.8),
                                      //   ),
                                      // ),

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
                                            color: AppColors.black1c
                                                .withOpacity(0.8),
                                          ),
                                          SizedBox(
                                            height: 60.w,
                                            child: IntlPhoneField(
                                              // readOnly: signUpViewModel
                                              //     .isReadOnly.value,
                                              showDropdownIcon: false,
                                              textAlignVertical:
                                                  TextAlignVertical.bottom,
                                              textInputAction:
                                                  TextInputAction.done,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              controller: signUpViewModel
                                                  .signUpPhoneNoController
                                                  .value,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              keyboardType:
                                                  TextInputType.number,
                                              initialCountryCode: 'IN',
                                              onChanged: (val) {
                                                if (val.toString().isNotEmpty) {
                                                  signUpViewModel
                                                      .signUpPhoneIsValidate
                                                      .value = false;
                                                }
                                              },
                                              onCountryChanged: (val) {
                                                signUpViewModel
                                                    .signUpCountryCode
                                                    .value = val.dialCode;
                                              },
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: AppColors.black,
                                                  fontFamily:
                                                      AppConstants.inter,
                                                  fontWeight: FontWeight.w400),
                                              decoration: InputDecoration(
                                                isDense: true,
                                                fillColor: Colors.transparent,
                                                filled: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10.h),
                                                hintText:
                                                    AppStrings.phoneNoHintTxt,
                                                hintStyle: TextStyle(
                                                  color: AppColors.black1c
                                                      .withOpacity(0.5),
                                                  fontSize: 14.sp,
                                                  fontFamily:
                                                      AppConstants.inter,
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
                                                            color: AppColors
                                                                .red1D),
                                                      )
                                                    : UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: AppColors
                                                                .black1c
                                                                .withOpacity(
                                                                    0.4))),
                                                border: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: AppColors.black1c
                                                            .withOpacity(0.4))),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: AppColors
                                                                .black1c
                                                                .withOpacity(
                                                                    0.4))),
                                                disabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: AppColors
                                                                .black1c
                                                                .withOpacity(
                                                                    0.4))),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: AppColors
                                                                .black1c
                                                                .withOpacity(
                                                                    0.4))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizeConfig.sH20,
                                      CommonTextField(
                                        // readOnly:
                                        //     signUpViewModel.isReadOnly.value,
                                        title: AppStrings.email,
                                        regularExpression:
                                            RegularExpressionUtils.emailPattern,
                                        textEditController: signUpViewModel
                                            .signUpEmailController.value,
                                        keyBoardType:
                                            TextInputType.emailAddress,
                                        contentPadding: EdgeInsets.only(
                                            bottom: 9.w, top: 6.w),
                                        hintText: AppStrings.emailHintTxt,
                                        preFixIconPath:
                                            AppImageAssets.emailIcon,
                                        isValidate: true,
                                        validationType:
                                            ValidationTypeEnum.email,
                                        textInputAction: TextInputAction.next,
                                        validationMessage:
                                            AppStrings.emailIsRequired,
                                      ),
                                      SizeConfig.sH20,
                                      CommonTextField(
                                        // readOnly:
                                        //     signUpViewModel.isReadOnly.value,
                                        title: AppStrings.password,
                                        regularExpression:
                                            RegularExpressionUtils
                                                .passwordPattern,
                                        textEditController: signUpViewModel
                                            .signUpPasswordController.value,
                                        keyBoardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 7.w,
                                        ),
                                        hintText: AppStrings.passwordHintTxt,
                                        preFixIconPath:
                                            AppImageAssets.passwordIcon,
                                        validationType:
                                            ValidationTypeEnum.password,
                                        validationMessage:
                                            AppStrings.passwordIsRequired,
                                        obscureValue: signUpViewModel
                                                    .signUpShowPass.value ==
                                                true
                                            ? false
                                            : true,
                                        sIcon: InkWell(
                                          onTap: () {
                                            signUpViewModel
                                                    .signUpShowPass.value =
                                                !signUpViewModel
                                                    .signUpShowPass.value;
                                          },
                                          child: LocalAssets(
                                            imagePath: signUpViewModel
                                                        .signUpShowPass.value ==
                                                    true
                                                ? AppImageAssets.eyeIcon
                                                : AppImageAssets
                                                    .passwordViewIcon,
                                            height: 22.w,
                                          ),
                                        ),
                                        isValidate: true,
                                      ),
                                      SizeConfig.sH20,
                                      CommonTextField(
                                        // readOnly:
                                        //     signUpViewModel.isReadOnly.value,
                                        textEditController: signUpViewModel
                                            .signUpConfirmPasswordController
                                            .value,
                                        title: AppStrings.confirmPassword,
                                        validationType:
                                            ValidationTypeEnum.password,
                                        regularExpression:
                                            RegularExpressionUtils
                                                .passwordPattern,
                                        keyBoardType: TextInputType.text,
                                        validationMessage: AppStrings
                                            .confirmPasswordIsRequired,
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
                                        preFixIconPath:
                                            AppImageAssets.passwordIcon,
                                        sIcon: InkWell(
                                          onTap: () {
                                            signUpViewModel
                                                    .signUpShowConPass.value =
                                                !signUpViewModel
                                                    .signUpShowConPass.value;
                                          },
                                          child: LocalAssets(
                                            imagePath: signUpViewModel
                                                        .signUpShowConPass
                                                        .value ==
                                                    true
                                                ? AppImageAssets.eyeIcon
                                                : AppImageAssets
                                                    .passwordViewIcon,
                                            height: 22.w,
                                          ),
                                        ),
                                      ),
                                      SizeConfig.sH20,
                                      // CommonTextField(
                                      //   readOnly:
                                      //       signUpViewModel.isReadOnly.value,
                                      //   textEditController: signUpViewModel
                                      //       .therapyCenterCodeController
                                      //       .value,
                                      //   title: AppStrings.therapyCenterCode,
                                      //   validationType:
                                      //       ValidationTypeEnum.password,
                                      //   regularExpression:
                                      //       RegularExpressionUtils
                                      //           .therapyCenterCode,
                                      //   validationMessage:
                                      //       AppStrings.centerCodeIsRequired,
                                      //   contentPadding: EdgeInsets.symmetric(
                                      //     vertical: 7.w,
                                      //   ),
                                      //   hintText:
                                      //       AppStrings.centerCodeHintTxt,
                                      //   textInputAction: TextInputAction.done,
                                      //   obscureValue: false,
                                      //   preFixIconPath:
                                      //       AppImageAssets.passwordIcon,
                                      // ),
                                    ],
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
                                                  // navigate(view: const WebViewExample(
                                                  //   url: AppStrings
                                                  //       .privacyPolicyUrl,
                                                  // ));
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
                                                  /*navigate(view: const WebViewExample(
                                                    url: AppStrings
                                                        .privacyPolicyUrl,
                                                  ));*/
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
                                        } else if (signUpViewModel
                                                .roleVal.value ==
                                            "") {
                                          commonSnackBar(
                                              message:
                                                  AppStrings.pleaseSelectRole);
                                        } else if (!signUpViewModel
                                            .isPrivacyAndTermsChecked.value) {
                                          commonSnackBar(
                                              message: AppStrings
                                                  .agreeTermsCondition);
                                        } else {
                                          if (signUpViewModel.roleVal.value ==
                                              AppStrings.therapist) {
                                            Get.to(() => const TherapistDetailScreen());
                                          } else {
                                            sendOtp(
                                                phoneNumber: signUpViewModel
                                                    .signUpPhoneNoController
                                                    .value
                                                    .text,
                                                countryCode: signUpViewModel
                                                    .signUpCountryCode.value,
                                                context: context,
                                                isLoginScreen: false);
                                          }
                                        }
                                      }
                                    },
                                  ),

                                  SizeConfig.sH15,
                                  // Row(
                                  //   mainAxisSize: MainAxisSize.min,
                                  //   children: [
                                  //     const Expanded(
                                  //       child: Divider(
                                  //         color: AppColors.whiteF4,
                                  //         endIndent: 10,
                                  //         thickness: 1.5,
                                  //       ),
                                  //     ),
                                  //     CustomText(AppStrings.registerWith,
                                  //         fontSize: 15.sp, color: AppColors.black1c),
                                  //     const Expanded(
                                  //       child: Divider(
                                  //         color: AppColors.whiteF4,
                                  //         indent: 10,
                                  //         thickness: 1.5,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizeConfig.sH22,
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     commonSocialMediaDesign(
                                  //         imagePath: AppImageAssets.facebookImage),
                                  //     commonSocialMediaDesign(
                                  //         imagePath: AppImageAssets.googleImage),
                                  //     commonSocialMediaDesign(imagePath: AppImageAssets.appleImage)
                                  //   ],
                                  // ),
                                  // SizeConfig.sH15,
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
                            height: Get.width / 3,
                            width: Get.width / 3,
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

class CommonDropdownField extends StatelessWidget {
  final void Function(String?)? onChanged;
  const CommonDropdownField({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          AppStrings.role,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black1c.withOpacity(0.8),
        ),
        SizedBox(
          width: Get.width,
          child: DropdownButtonFormField(
            items: [
              DropdownMenuItem(
                value: AppStrings.therapist,
                child: CustomText(AppStrings.therapist),
              ),
              DropdownMenuItem(
                value: AppStrings.caregiver,
                child: CustomText(AppStrings.caregiver),
              ),
            ],
            onChanged: onChanged,
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
                  EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
              hintText: AppStrings.selectRole.tr,
              hintStyle: TextStyle(
                color: AppColors.black1c.withOpacity(0.5),
                fontSize: 14.sp,
                fontFamily: AppConstants.inter,
                fontWeight: FontWeight.normal,
              ),
              border: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.black1c.withOpacity(0.4))),
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.black1c.withOpacity(0.4))),
              disabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.black1c.withOpacity(0.4))),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.black1c.withOpacity(0.4))),
            ),
          ),
        ),
      ],
    );
  }
}

///COMMON ROUNDED TEXTFIELD
commonRoundedTextField(
    {required String text,
    required TextEditingController textEditingController,
    void Function(String)? onChanged}) {
  return SizedBox(
    width: Get.width / 1.5,
    child: TextFormField(
      onChanged: onChanged,
      controller: textEditingController,
      cursorColor: AppColors.white,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 15.w),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: AppColors.white,
                width: 1.5,
              )),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: AppColors.white,
                width: 1.5,
              )),
          hintText: text,
          hintStyle: TextStyle(color: AppColors.white)),
    ),
  );
}
>>>>>>> Stashed changes

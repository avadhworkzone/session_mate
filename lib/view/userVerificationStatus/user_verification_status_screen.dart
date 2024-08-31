import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/commonWidget/no_data_found_widget.dart';
import 'package:session_mate/service/auth_service.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_constant.dart';

import 'package:session_mate/utils/app_string.dart';

import 'package:session_mate/utils/shared_preference_utils.dart';

import 'package:session_mate/viewModel/user_verification_status_view_model.dart';

class UserVerificationStatusScreen extends StatefulWidget {
  const UserVerificationStatusScreen({
    super.key,
  });

  @override
  State<UserVerificationStatusScreen> createState() =>
      _UserVerificationStatusScreenState();
}

class _UserVerificationStatusScreenState
    extends State<UserVerificationStatusScreen> {
  final UserVerificationStatusViewModel userVerificationStatusViewModel =
      Get.put(UserVerificationStatusViewModel());

  @override
  void initState() {
    SharedPreferenceUtils.setIsAdminLogin(true);
    super.initState();
  }

  var isVerify = "Pending";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 29.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  height: Get.height / 1.7,
                  child: StreamBuilder(
                    stream: AuthService.getAuthUserData(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return noDataFound();
                      }

                      if (snapshot.data == null) {
                        return noDataFound();
                      } else {
                        return ListView.separated(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var userDoc = snapshot.data!.docs[index];

                            var userName = userDoc.data().containsKey("userName")
                                ? userDoc['userName']
                                : 'Unknown';
                            var dateOfBirth =
                                userDoc.data().containsKey('dateOfBirth')
                                    ? userDoc['dateOfBirth']
                                    : '';
                            var emailId = userDoc.data().containsKey("email")
                                ? userDoc['email']
                                : '';
                            var mobileNumber =
                                userDoc.data().containsKey("mobileNumber")
                                    ? userDoc['mobileNumber']
                                    : '';

                            isVerify = userDoc.data().containsKey("isVerify")
                                ? userDoc['isVerify']
                                : '';

                            print("isVerify Status in Admin :- $isVerify");

                            return Column(
                              children: [
                                if (isVerify == 'Pending')
                                  Container(
                                    width: Get.width,
                                    height: 117.h,
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 25.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20.h,
                                          ),

                                          /// UserName Row
                                          Row(
                                            children: [
                                              CustomText(
                                                userName,
                                                fontSize: 18.sp,
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: AppConstants.poppins,
                                                color: AppColors.black,
                                              ),
                                              const Spacer(),
                                              CustomText(
                                                dateOfBirth,
                                                fontSize: 14.sp,
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: AppConstants.inter,
                                                color: AppColors.black1c,
                                              ),
                                              SizedBox(
                                                width: 30.w,
                                              )
                                            ],
                                          ),

                                          SizedBox(
                                            height: 6.h,
                                          ),

                                          CustomText(
                                            emailId,
                                            fontSize: 14.sp,
                                            textAlign: TextAlign.center,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: AppConstants.poppins,
                                            color: AppColors.color97,
                                          ),

                                          SizedBox(
                                            height: 6.h,
                                          ),

                                          /// Mobile Number Row
                                          Row(
                                            children: [
                                              CustomText(
                                                mobileNumber,
                                                fontSize: 14.sp,
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: AppConstants.poppins,
                                                color: AppColors.color97,
                                              ),
                                              const Spacer(),

                                              /// Verify Button
                                              InkWell(
                                                onTap: () {
                                                  AuthService.addIsVerifyStatus(
                                                      mobileNumber ?? '');
                                                },
                                                child: Container(
                                                  height: 20.h,
                                                  width: 20.h,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.r)),
                                                  child: Icon(
                                                    size: 17.sp,
                                                    Icons.check_sharp,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),

                                              /// InVerify Button
                                              InkWell(
                                                onTap: () {
                                                  userVerificationStatusViewModel
                                                      .setVerifyIndex(index);
                                                },
                                                child: Container(
                                                  height: 20.h,
                                                  width: 20.h,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.red1D,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.r)),
                                                  child: Icon(
                                                    size: 17.sp,
                                                    Icons.close,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 30.w,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                /// Comment Box
                                Obx(() {
                                  if (userVerificationStatusViewModel
                                          .verifyIndex.value ==
                                      index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: Get.width / 4.2, top: 8.h),
                                      child: Container(
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                            color: AppColors.white,
                                            borderRadius:
                                                BorderRadius.circular(15.r)),
                                        child: Form(
                                          key: userVerificationStatusViewModel
                                              .formKey,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15.w),
                                                child: TextFormField(
                                                  onChanged: (value) {
                                                    userVerificationStatusViewModel
                                                        .adminComment = value;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: AppStrings
                                                        .writeCommentTxt,
                                                    border: InputBorder.none,
                                                  ),
                                                  controller:
                                                      userVerificationStatusViewModel
                                                          .adminCommentController,
                                                  maxLines: 3,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return AppStrings
                                                          .commentIsRequired;
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                height: 0.h,
                                              ),

                                              /// Submit button
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      if (userVerificationStatusViewModel
                                                          .formKey.currentState!
                                                          .validate()) {
                                                        AuthService.addAdminComment(
                                                            mobileNumber ?? '',
                                                            userVerificationStatusViewModel
                                                                .adminComment,
                                                            userVerificationStatusViewModel);
                                                      }
                                                    },
                                                    child: userVerificationStatusViewModel
                                                                .isCommentLoad
                                                                .value ==
                                                            true
                                                        ? const CircularProgressIndicator(
                                                            color: AppColors.blue,
                                                          )
                                                        : Container(
                                                            height: 31.h,
                                                            width: 80.w,
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6.r)),
                                                            child: Center(
                                                              child: CustomText(
                                                                  AppStrings
                                                                      .submit,
                                                                  fontSize: 14.sp,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontFamily:
                                                                      AppConstants
                                                                          .inter,
                                                                  color: AppColors
                                                                      .white),
                                                            ),
                                                          ),
                                                  ),
                                                  SizedBox(
                                                    width: 15.w,
                                                  ),
                                                ],
                                              ),

                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                }),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            if (isVerify == 'Pending') {
                              return SizedBox(
                                height: 27.h,
                              );
                            }
                            return const SizedBox();
                          },
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    CustomText(AppStrings.unVerifiedTxt,
                        fontSize: 20.sp,
                        textAlign: TextAlign.left,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppConstants.inter,
                        color: AppColors.white),
                  ],
                ),

                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: Get.height / 4,

                  child: StreamBuilder(
                    stream: AuthService.getAuthUserData(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return noDataFound();
                      }

                      if (snapshot.data == null) {
                        return noDataFound();
                      } else {
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var userDoc = snapshot.data!.docs[index];

                            var userName = userDoc.data().containsKey("userName")
                                ? userDoc['userName']
                                : 'Unknown';

                            var mobileNumber =
                                userDoc.data().containsKey("mobileNumber")
                                    ? userDoc['mobileNumber']
                                    : '';

                            isVerify = userDoc.data().containsKey("isVerify")
                                ? userDoc['isVerify']
                                : '';

                            print("isVerify Status in Admin :- $isVerify");

                            return Column(
                              children: [
                                if (isVerify == 'false')
                                  Container(
                                    width: Get.width,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 25.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),

                                          /// Mobile Number Row
                                          Row(
                                            children: [
                                              CustomText(
                                                userName,
                                                fontSize: 18.sp,
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: AppConstants.poppins,
                                                color: AppColors.black,
                                              ),
                                              const Spacer(),
                                              CustomText(
                                                mobileNumber,
                                                fontSize: 14.sp,
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: AppConstants.poppins,
                                                color: AppColors.color97,
                                              ),
                                              SizedBox(
                                                width: 30.w,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            if (isVerify == 'false') {
                              return SizedBox(
                                height: 20.h,
                              );
                            }
                            return const SizedBox();
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

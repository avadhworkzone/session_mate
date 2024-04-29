import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/viewModel/otp_view_model.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  OtpViewModel otpViewModel = Get.find();

  @override
  void initState() {
    otpViewModel.startTimer();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    otpViewModel.stopTimer();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
          child: Obx(() {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.arrow_back_ios),
                      CustomText(
                        AppStrings.verification,
                        fontWeight: FontWeight.w500,
                        fontSize: 26.sp,
                      ),
                      SizedBox(
                        width: 20.w,
                      )
                    ],
                  ),
                ),
                SizeConfig.sH20,
                LocalAssets(
                  imagePath: AppImageAssets.otpVerificationImage,
                  height: Get.width / 1.5,
                  width: Get.width / 1.5,
                ),
                CustomText(
                  AppStrings.otpVerificationTxt,
                  fontSize: 16.sp,
                  textAlign: TextAlign.center,
                ),
                SizeConfig.sH10,
                CustomText('+91 - 1245363644',
                    fontWeight: FontWeight.w600, fontSize: 15.sp),
                SizeConfig.sH50,
                Pinput(
                  // validator: (val) => ValidationMethod.validateOtp(val),
                  // controller: otpViewModel.pinPutController.value,
                  length: 6,
                  showCursor: true,
                  keyboardType: TextInputType.number,
                  defaultPinTheme: PinTheme(
                      height: 45.h,
                      width: 45.w,
                      textStyle: TextStyle(fontSize: 15.sp),
                      decoration: BoxDecoration(
                          color: AppColors.whiteF6,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(color: AppColors.primaryColor))),
                  onChanged: (val) {},
                ),
                SizeConfig.sH35,
                if (int.parse(otpViewModel
                        .strDigits(otpViewModel.myDuration.value.inSeconds
                            .remainder(60))
                        .value) >
                    0)
                  CustomText(
                    '${otpViewModel.strDigits(otpViewModel.myDuration.value.inMinutes.remainder(60))}:${otpViewModel.strDigits(otpViewModel.myDuration.value.inSeconds.remainder(60))}',
                    fontWeight: FontWeight.w600,
                    color: AppColors.black1c,
                  ),
                SizeConfig.sH15,
                CustomText(
                  AppStrings.otpNotReceivedTxt,
                  color: AppColors.black.withOpacity(0.30),
                  fontSize: 16.sp,
                ),
                SizeConfig.sH5,
                int.parse(otpViewModel
                            .strDigits(otpViewModel.myDuration.value.inSeconds
                                .remainder(60))
                            .value) >
                        0
                    ? CustomText(
                        AppStrings.sendAgainTxt,
                        color: AppColors.primaryColor.withOpacity(0.30),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      )
                    : InkWell(
                        onTap: () {
                          otpViewModel.resetTimer();
                        },
                        child: CustomText(
                          AppStrings.sendAgainTxt,
                          color: AppColors.primaryColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                SizeConfig.sH10,
                CustomBtn(onTap: () {}, title: AppStrings.submit)
              ],
            );
          }),
        ),
      ),
    );
  }
}

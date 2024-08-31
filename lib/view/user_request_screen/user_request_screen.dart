import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/common_snackbar.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/commonWidget/network_assets.dart';
import 'package:session_mate/service/auth_service.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_constant.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/bottomBar/bottom_bar_screen.dart';
import 'package:session_mate/view/userRejectedScreen/user_rejected_screen.dart';

class UserRequestScreen extends StatefulWidget {
  const UserRequestScreen({
    super.key,
  });

  @override
  State<UserRequestScreen> createState() => _UserRequestScreenState();
}

class _UserRequestScreenState extends State<UserRequestScreen> {
  final List<Map<String, String>> imageSpeechData = [
    {
      'imageUrl': AppImageAssets.speechImage,
      // 'title': 'Speech',
    },
    {
      'imageUrl': AppImageAssets.therapyImg,
      // 'title': 'Special Education',
    },
    {
      'imageUrl': AppImageAssets.specialEducationImg,
      // 'title': 'Sports',
    },
    {
      'imageUrl': AppImageAssets.musicImg,
      // 'title': 'Occupational Therapy',
    },
    {
      'imageUrl': AppImageAssets.sportImg,
      // 'title': 'Music',
    },
  ];

  late StreamSubscription streamSubscription;

  @override
  void initState() {
    listenVerifyStaus();
    super.initState();
  }

  void listenVerifyStaus() {
    streamSubscription =
        AuthService.getVerificationStaus(SharedPreferenceUtils.getUserId())
            .listen((event) {
      final mapData = event.data() as Map<String, dynamic>;
      if (mapData.containsKey("isVerify")) {
        if (mapData['isVerify'] == "true") {
          streamSubscription.cancel();
          Get.offAll(const BottomBar());
        } else if (mapData['isVerify'] == "false") {
          streamSubscription.cancel();
          Get.offAll(const UserRejectedScreen());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizeConfig.sH35,
            SizedBox(
                height: 100.w,
                child: Image.asset(
                  AppImageAssets.successIcon,
                  fit: BoxFit.fill,
                )),
            SizedBox(
              height: 30.h,
            ),
            RichText(
              text: TextSpan(
                  text: AppStrings.thankYouFor,
                  style: TextStyle(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppConstants.inter,
                    color: AppColors.black,
                  ),
                  children: [
                    TextSpan(
                      text: AppStrings.submission,
                      style: TextStyle(
                        fontSize: 23.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppConstants.inter,
                        color: AppColors.primaryColor,
                      ),
                    )
                  ]),
            ),
            CustomText(
              " ",
              fontSize: 23.sp,
              fontWeight: FontWeight.w500,
              fontFamily: AppConstants.inter,
              color: AppColors.black,
            ),
            CustomText(
              AppStrings.yourDetailAreBeingVerified,
              fontSize: 23.sp,
              fontWeight: FontWeight.w500,
              fontFamily: AppConstants.inter,
              color: AppColors.black,
            ),
            RichText(
              text: TextSpan(
                  text: AppStrings.andAccountWillBe,
                  style: TextStyle(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppConstants.inter,
                    color: AppColors.black,
                  ),
                  children: [
                    TextSpan(
                      text: AppStrings.activated,
                      style: TextStyle(
                        fontSize: 23.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppConstants.inter,
                        color: AppColors.primaryColor,
                      ),
                    )
                  ]),
            ),
            CustomText(
              AppStrings.shortly,
              fontSize: 23.sp,
              fontWeight: FontWeight.w500,
              fontFamily: AppConstants.inter,
              color: AppColors.primaryColor,
            ),
            CustomText(
              " ",
              fontSize: 23.sp,
              fontWeight: FontWeight.w500,
              fontFamily: AppConstants.inter,
              color: AppColors.black,
            ),
            CustomText(
              AppStrings.weLookForwardToSeeing,
              fontSize: 23.sp,
              fontWeight: FontWeight.w500,
              fontFamily: AppConstants.inter,
              color: AppColors.primaryColor,
            ),
            CustomText(
              AppStrings.youOnTheOtherSide,
              fontSize: 23.sp,
              fontWeight: FontWeight.w500,
              fontFamily: AppConstants.inter,
              color: AppColors.primaryColor,
            ),
            SizedBox(
              height: 92.h,
            ),
            // Container(
            //   width: 230.w,
            //   height: 148.h,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15.r),
            //   ),
            //   child: Image.asset(
            //     AppImageAssets.speechImage,
            //     fit: BoxFit.fill,
            //   ),
            // )

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  imageSpeechData.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 240.w,
                      child: Image.asset(
                        imageSpeechData[index]['imageUrl'] ?? '',
                        // imgUrl: imageSpeechData[index]['imageUrl'] ?? '',
                        // height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            )

            // ListView.builder(
            //   itemCount: 5,
            //   itemBuilder: (context, index) {
            //
            //     return  Container(
            //       height: 148.h,
            //       width: Get.width/3,
            //     );
            // },)
          ],
        ),
      ),
    );
  }
}

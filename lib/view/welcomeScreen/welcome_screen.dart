import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/auth/sign_in_screen.dart';
import 'package:session_mate/view/auth/sign_up_screen.dart';
import 'package:session_mate/view/manageTherapyCenters/location_screen.dart';
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

  Future<void> requestLocationPermission({Widget? screen}) async {
    final permissionStatus = await Permission.location.status;
    if (await Permission.location.request().isGranted ||
        await Permission.locationWhenInUse.request().isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        double latitude = position.latitude;

        SharedPreferenceUtils.setLatitude(latitude.toString());
        double longitude = position.longitude;

        SharedPreferenceUtils.setLongitude(longitude.toString());
        if (screen != null) {
          Get.to(() => screen);
        }
      } on Exception catch (e) {
        log('LOCATION ERROR :=>$e');
      }
    } else if (await Permission.location.status.isDenied) {
      if (Platform.isAndroid) {
        await Get.to(() => const LocationSettingScreen());
      } else {
        requestLocationPermission();
      }
    } else if (await Permission.location.status.isPermanentlyDenied) {
    } else {
      if (Platform.isAndroid) {
        await Get.to(() => const LocationSettingScreen());
      } else {
        requestLocationPermission();
      }
    }
  }

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
                // navigate(view: SignUpScreen());
                requestLocationPermission(screen: const SignUpScreen());
                // Get.to(() => const SignUpScreen());
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
                // navigate(view: SignInScreen());
                requestLocationPermission(screen: const SignInScreen());
                // Get.to(() => const SignInScreen());
              },
            ),
            SizeConfig.sH30,
          ],
        ),
      ),
    );
  }
}

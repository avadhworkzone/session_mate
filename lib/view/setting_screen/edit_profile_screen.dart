import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/commom_textfield.dart';
import 'package:session_mate/commonWidget/common_appbar.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_enum.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/regex.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/viewModel/edit_profile_view_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileViewModel editProfileViewModel = Get.put(EditProfileViewModel());
  Map<String, dynamic> userDetail = {};

  @override
  void initState() {
    userDetail = jsonDecode(SharedPreferenceUtils.getUserDetail());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Obx(
        () =>  Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizeConfig.sH10,
            commonAppBar(
                title: AppStrings.editProfile,
                textColor: AppColors.black,
                iconColor: AppColors.black),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 171.47.w,
                  height: 175.97.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primaryColor)),
                ),
                const Positioned(
                    bottom: 20,
                    child: LocalAssets(
                        imagePath: AppImageAssets.editProfileCameraIcon)),
              ],
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: CommonTextField(
                regularExpression: RegularExpressionUtils.text,
                title: AppStrings.name,
                borderColor: AppColors.color54,
                isCapitalize: false,
                obscureValue: false,
                textEditController: editProfileViewModel.editProfileNameController.value,
                keyBoardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validationType: ValidationTypeEnum.name,
                hintText: userDetail['userName'] ?? '',
                preFixIconPath:
                AppImageAssets.profileIcon,
              ),
            ),
            SizeConfig.sH15,
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: CommonTextField(
                regularExpression: RegularExpressionUtils.emailPattern,
                title: AppStrings.email,
                borderColor: AppColors.color54,
                isCapitalize: false,
                obscureValue: false,
                textEditController: editProfileViewModel.editProfileNameController.value,
                keyBoardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validationType: ValidationTypeEnum.email,
                hintText: userDetail['email'] ?? '',
                preFixIconPath: AppImageAssets.emailIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

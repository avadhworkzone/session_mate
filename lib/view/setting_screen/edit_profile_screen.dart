<<<<<<< Updated upstream
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
=======
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/commom_textfield.dart';
import 'package:session_mate/commonWidget/common_appbar.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/commonWidget/network_assets.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_enum.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/regex.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/bottomBar/bottom_bar_screen.dart';
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
    editProfileViewModel.editProfileNameController.value.text =
       userDetail['userName'];
    editProfileViewModel.editProfileEmailController.value.text =
       userDetail['email'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizeConfig.sH10,
            commonAppBar(
                title: AppStrings.editProfile,
                textColor: AppColors.black,
                iconColor: AppColors.black),
            GestureDetector(
              onTap: (){
                showBottomSheet(context);
              },
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 171.47.w,
                    height: 175.97.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primaryColor),
                    image: DecorationImage(image: (editProfileViewModel
                        .imgFile.value.path.isNotEmpty)
                        ? FileImage(editProfileViewModel
                        .imgFile.value) as ImageProvider
                        : const NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKD2iakBaqd_uVemFSejI9HjWh0hBKItR70w&s'),)
                    ),
                  ),
                  const Positioned(
                      bottom: 20,
                      child: LocalAssets(
                          imagePath: AppImageAssets.editProfileCameraIcon)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CommonTextField(
                regularExpression: RegularExpressionUtils.text,
                title: AppStrings.name,
                borderColor: AppColors.color54,
                isCapitalize: false,
                obscureValue: false,
                textEditController:
                    editProfileViewModel.editProfileNameController.value,
                keyBoardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validationType: ValidationTypeEnum.name,
                hintText: '',
                isOutlineInputBorder: true,
                isNotShowPreIcon: true,
                hintTextColor: AppColors.color54,
                // preFixIconPath: AppImageAssets.profileIcon,
              ),
            ),
            SizeConfig.sH15,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CommonTextField(
                regularExpression: RegularExpressionUtils.emailPattern,
                title: AppStrings.email,
                borderColor: AppColors.color54,
                isCapitalize: false,
                obscureValue: false,
                textEditController:
                    editProfileViewModel.editProfileEmailController.value,
                keyBoardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validationType: ValidationTypeEnum.email,
                hintText: '',
                isOutlineInputBorder: true,
                isNotShowPreIcon: true,
                hintTextColor: AppColors.color54,
                // preFixIconPath: AppImageAssets.emailIcon,
              ),
            ),
           const Spacer(),
            Padding(
              padding:  EdgeInsets.only(left: 70.w,right: 70.w,bottom: 80.h),
              child: CustomBtn(onTap: (){
                Get.to(const BottomBar());
              }, title: AppStrings.saveChanges),
            )
          ],
        ),
      ),
    );
  }

  /// bottom sheet for picking a profile picture for user

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
                top: Get.height * .03, bottom: Get.height * .05),
            children: [
              /// pick profile picture label
              const Text('Pick Profile Picture',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              SizedBox(height: Get.height * .02),

              /// Buttons
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.camera_alt_outlined,
                          size: 30,
                        ),
                        SizeConfig.sW10,
                        InkWell(
                          onTap: () =>
                              editProfileViewModel.pickImageFromGallery(),
                          child: CustomText(
                            AppStrings.pickFromGallery,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                    SizeConfig.sH20,
                    Row(
                      children: [
                        LocalAssets(
                          imagePath: AppImageAssets.galleryImg,
                          height: 30.h,
                          width: 30.w,
                        ),
                        SizeConfig.sW15,
                        InkWell(
                          onTap: () =>
                              editProfileViewModel.pickImageFromCamera(),
                          child: CustomText(
                            AppStrings.pickFromCamera,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
>>>>>>> Stashed changes

<<<<<<< Updated upstream
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:session_mate/commonWidget/common_appbar.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/utils/size_config_utils.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({super.key, this.isDrawerScreen});
  bool? isDrawerScreen;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Map<String, dynamic> userDetail = {};
  List<Map<String, dynamic>> settingOptionData = [
    {'icon': AppImageAssets.accountIcon, 'title': AppStrings.account},
    {'icon': AppImageAssets.editProfileIcon, 'title': AppStrings.editProfile},
    {
      'icon': AppImageAssets.notificationIcon,
      'title': AppStrings.notifications
    },
  ];

  @override
  void initState() {
    userDetail = jsonDecode(SharedPreferenceUtils.getUserDetail());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor),
        leading: const SizedBox(),
        leadingWidth: 0,
      ),
      body: Column(
        children: [
          commonAppBar(
              title: widget.isDrawerScreen == true
                  ? AppStrings.setting
                  : AppStrings.profile,
              textColor: AppColors.white,
              iconColor: widget.isDrawerScreen == true
                  ? AppColors.white
                  : Colors.transparent),
          const Divider(
            color: AppColors.whiteFF,
          ),
          SizeConfig.sH10,
          ListTile(
            leading: CircleAvatar(
              radius: 50.r,
              child: CustomText(
                userDetail["userName"].toString().split("").first.toUpperCase(),
                color: AppColors.black,
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            title: userDetail["userName"] == ""
                ? const SizedBox()
                : CustomText(
                    userDetail["userName"].toString(),
                    color: AppColors.colorF8,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
            subtitle: userDetail["email"] == ""
                ? const SizedBox()
                : CustomText(
                    userDetail["email"].toString(),
                    color: AppColors.colorF8,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
          ),
          SizeConfig.sH10,
          const Divider(
            color: AppColors.whiteFF,
          ),
          SizeConfig.sH20,
          Expanded(
            child: ListView.builder(
              itemCount: settingOptionData.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                child: InkWell(
                  onTap: () {
                    // Get.to(const EditProfileScreen());
                  },
                  child: Row(
                    children: [
                      LocalAssets(imagePath: settingOptionData[index]['icon']),
                      SizeConfig.sW20,
                      CustomText(
                        settingOptionData[index]['title'],
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.colorF8,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
=======
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/common_appbar.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/setting_screen/edit_profile_screen.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({super.key, this.isDrawerScreen});
  bool? isDrawerScreen;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Map<String, dynamic> userDetail = {};
  List<Map<String, dynamic>> settingOptionData = [
    // {'icon': AppImageAssets.accountIcon, 'title': AppStrings.account},
    // {'icon': AppImageAssets.editProfileIcon, 'title': AppStrings.editProfile},
    {
      'icon': AppImageAssets.notificationIcon,
      'title': AppStrings.notifications
    },
  ];

  @override
  void initState() {
    userDetail = jsonDecode(SharedPreferenceUtils.getUserDetail());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor),
        leading: const SizedBox(),
        leadingWidth: 0,
      ),
      body: Column(
        children: [
          commonAppBar(
              title: widget.isDrawerScreen == true
                  ? AppStrings.setting
                  : AppStrings.profile,
              textColor: AppColors.white,
              iconColor: widget.isDrawerScreen == true
                  ? AppColors.white
                  : Colors.transparent),
          const Divider(
            color: AppColors.whiteFF,
          ),
          SizeConfig.sH10,
          ListTile(
            leading: CircleAvatar(
              radius: 50.r,
              child: CustomText(
                userDetail["userName"].toString().split("").first.toUpperCase(),
                color: AppColors.black,
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            title: userDetail["userName"] == ""
                ? const SizedBox()
                : CustomText(
                    userDetail["userName"].toString(),
                    color: AppColors.colorF8,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
            subtitle: userDetail["email"] == ""
                ? const SizedBox()
                : CustomText(
                    userDetail["email"].toString(),
                    color: AppColors.colorF8,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
          ),
          SizeConfig.sH10,
          const Divider(
            color: AppColors.whiteFF,
          ),
          SizeConfig.sH20,
          Expanded(
            child: ListView.builder(
              itemCount: settingOptionData.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                child: InkWell(
                  onTap: () {
                    Get.to(const EditProfileScreen());
                  },
                  child: Row(
                    children: [
                      LocalAssets(imagePath: settingOptionData[index]['icon']),
                      SizeConfig.sW20,
                      CustomText(
                        settingOptionData[index]['title'],
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.colorF8,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
>>>>>>> Stashed changes

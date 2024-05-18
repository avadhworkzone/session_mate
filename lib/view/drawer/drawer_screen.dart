import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/manageSession/manage_sessions.dart';
import 'package:session_mate/view/manageTherapyCenters/manage_therapy_centers.dart';
import 'package:session_mate/view/welcomeScreen/welcome_screen.dart';

Drawer buildDrawer({required String userName}) {
  return Drawer(
    width: Get.width / 1.5,
    backgroundColor: AppColors.primaryColor.withOpacity(0.8),
    child: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 25.h),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30.w,
                          backgroundColor: AppColors.grey,
                          child: Center(
                            child: CustomText(
                              userName.split("").first.toUpperCase(),
                              color: AppColors.black,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // backgroundImage: const AssetImage(AppImageAssets.profile),
                        ),
                        SizeConfig.sH12,
                        CustomText(
                          userName,
                          color: AppColors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        SizeConfig.sH6,
                        CustomText(
                          SharedPreferenceUtils.getUserId(),
                          color: AppColors.white,
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
                SizeConfig.sH10,
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: 25.w, right: 20.w),
                      child: Column(
                        children: [
                          commonDrawerBtn(
                            image: AppImageAssets.person,
                            title: AppStrings.manageSessions,
                            ontap: () {
                              Get.to(() => const ManageSessions());
                            },
                          ),
                          const Divider(
                            color: AppColors.white,
                          ),
                          commonDrawerBtn(
                              image: AppImageAssets.person,
                              title: AppStrings.therapyCentres,
                              ontap: () {
                                Get.to(() => const ManageTherapyCenters());
                              }),
                          const Divider(
                            color: AppColors.white,
                          ),
                          commonDrawerBtn(
                              image: AppImageAssets.setting,
                              title: AppStrings.settings,
                              ontap: () {}),
                          const Divider(
                            color: AppColors.white,
                          ),
                          commonDrawerBtn(
                              image: AppImageAssets.person, title: AppStrings.myPlan, ontap: () {}),
                          const Divider(
                            color: AppColors.white,
                          ),
                          commonDrawerBtn(
                              image: AppImageAssets.deleteIcnDrawer,
                              title: AppStrings.delete,
                              ontap: () {}),
                          const Divider(
                            color: AppColors.white,
                          ),
                          commonDrawerBtn(
                              image: AppImageAssets.exit,
                              title: AppStrings.logOut,
                              ontap: () async {
                                await SharedPreferenceUtils.clearPreference();
                                Get.offAll(() => const WelcomeScreen());
                              }),
                          const Divider(
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

InkWell commonDrawerBtn({
  required String image,
  required String title,
  required Function ontap,
}) {
  return InkWell(
    borderRadius: const BorderRadius.all(
      Radius.circular(20),
    ),
    focusColor: Colors.cyan,
    onTap: () {
      ontap();
    },
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.w),
      child: Row(
        children: [
          LocalAssets(
            imagePath: image,
            width: 25.w,
            height: 25.w,
          ),
          SizeConfig.sW8,
          Expanded(
            child: CustomText(
              title,
              fontWeight: FontWeight.bold,
              fontSize: 17.sp,
              color: AppColors.white,
            ),
          ),
          LocalAssets(
            imagePath: AppImageAssets.arrow,
            width: 30.w,
            height: 30.w,
          ),
        ],
      ),
    ),
    // ListTile(
    //     contentPadding: EdgeInsets.zero,
    //     leading: LocalAssets(
    //       imagePath: image,
    //       width: 30.w,
    //       height: 30.w,
    //     ),
    //     title: CustomText(
    //       title,
    //       fontWeight: FontWeight.bold,
    //       fontSize: 17.sp,
    //       color: AppColors.white,
    //     ),
    //     trailing: LocalAssets(
    //       imagePath: AppImageAssets.arrow,
    //       width: 30.w,
    //       height: 30.w,
    //     )),
  );
}

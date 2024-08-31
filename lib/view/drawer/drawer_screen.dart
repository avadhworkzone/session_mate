<<<<<<< Updated upstream
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
import 'package:session_mate/view/setting_screen/setting_screen.dart';
import 'package:session_mate/view/subScriptionScreen/subScription_screen.dart';
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 28.w, vertical: 25.h),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        userName == ""
                            ? SizedBox()
                            : CircleAvatar(
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
                        userName == ''
                            ? SizedBox()
                            : CustomText(
                                userName.toString().capitalizeFirst!,
                                color: AppColors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                        SizeConfig.sH6,
                        CustomText(
                          'User   ${SharedPreferenceUtils.getUserId()}',
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
                          SharedPreferenceUtils.getRole() ==
                                  AppStrings.therapist
                              ? commonDrawerBtn(
                                  image: AppImageAssets.person,
                                  title: AppStrings.therapyCentres,
                                  ontap: () {
                                    Get.to(() => const ManageTherapyCenters());
                                  })
                              : SizedBox(),
                          SharedPreferenceUtils.getRole() ==
                                  AppStrings.therapist
                              ? const Divider(
                                  color: AppColors.white,
                                )
                              : SizedBox(),
                          commonDrawerBtn(
                              image: AppImageAssets.setting,
                              title: AppStrings.settings,
                              ontap: () {
                                Get.to(() => SettingScreen(
                                      isDrawerScreen: true,
                                    ));
                              }),
                          const Divider(
                            color: AppColors.white,
                          ),
                          commonDrawerBtn(
                              image: AppImageAssets.person,
                              title: AppStrings.myPlan,
                              ontap: () {
                                Get.to(
                                    () => SubscriptionsScreen(isDrawer: true));
                              }),
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
=======
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/common_snackbar.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_snackbar.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/collection_utils.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/manageSession/manage_sessions.dart';
import 'package:session_mate/view/manageTherapyCenters/manage_therapy_centers.dart';
import 'package:session_mate/view/setting_screen/my_plan_screen.dart';
import 'package:session_mate/view/setting_screen/setting_screen.dart';
import 'package:session_mate/view/subScriptionScreen/subScription_screen.dart';
import 'package:session_mate/view/welcomeScreen/welcome_screen.dart';

bool getRefundTap() {
  var user = jsonDecode(SharedPreferenceUtils.getUserDetail());
  DateTime subscriptionStartDate =
      DateTime.parse(user["subscriptionStartDate"]);
  print(subscriptionStartDate);

  if (user["subscriptionType"] == AppStrings.monthlySubscription) {
    if (DateTime.now().difference(subscriptionStartDate).inHours <= 24) {
      return true;
    } else {
      commonSnackBar(message: AppStrings.youCanNotGetRefundMonthly);
      return false;
    }
  } else if (user["subscriptionType"] == AppStrings.yearlySubscription) {
    if (DateTime.now().difference(subscriptionStartDate).inDays <= 14) {
      return true;
    } else {
      commonSnackBar(message: AppStrings.youCanNotGetRefundYearly);
      return false;
    }
  } else {
    commonSnackBar(message: AppStrings.youNotHaveSubscription);
    return false;
  }
}

Drawer buildDrawer({required String userName}) {
  print("Curent Mobile Number :- ${SharedPreferenceUtils.getUserId()}");

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
                    padding:
                        EdgeInsets.symmetric(horizontal: 28.w, vertical: 25.h),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        userName == ""
                            ? const SizedBox()
                            : CircleAvatar(
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
                        userName == ''
                            ? const SizedBox()
                            : CustomText(
                                userName.toString().capitalizeFirst!,
                                color: AppColors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                        SizeConfig.sH6,
                        CustomText(
                          'User   ${SharedPreferenceUtils.getUserId()}',
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
                          SharedPreferenceUtils.getRole() ==
                                  AppStrings.therapist
                              ? commonDrawerBtn(
                                  image: AppImageAssets.person,
                                  title: AppStrings.therapyCentres,
                                  ontap: () {
                                    Get.to(() => const ManageTherapyCenters());
                                  })
                              : const SizedBox(),
                          SharedPreferenceUtils.getRole() ==
                                  AppStrings.therapist
                              ? const Divider(
                                  color: AppColors.white,
                                )
                              : const SizedBox(),
                          commonDrawerBtn(
                              image: AppImageAssets.setting,
                              title: AppStrings.settings,
                              ontap: () {
                                Get.to(() => SettingScreen(
                                      isDrawerScreen: true,
                                    ));
                              }),
                          const Divider(
                            color: AppColors.white,
                          ),
                          commonDrawerBtn(
                              image: AppImageAssets.person,
                              title: AppStrings.myPlan,
                              ontap: () {
                                var map = jsonDecode(
                                    SharedPreferenceUtils.getUserDetail());
                                print(map);
                                if (map["isSubscription"] == true) {
                                  Get.to(() => MyPlanScreen(
                                        userDetail: map,
                                      ));
                                } else {
                                  Get.to(() => SubscriptionsScreen());
                                }
                              }),
                          const Divider(
                            color: AppColors.white,
                          ),
                          commonDrawerBtn(
                            image: AppImageAssets.person,
                            title: AppStrings.getRefund,
                            ontap: () {
                              print(getRefundTap());
                            },
                          ),
                          const Divider(
                            color: AppColors.white,
                          ),

                          /// Delete Current User Account
                          commonDrawerBtn(
                              image: AppImageAssets.deleteIcnDrawer,
                              title: AppStrings.delete,
                              ontap: () {
                                showDeleteDialog();
                              }),

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

void showDeleteDialog(){

  showDialog(


      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation',
              style: TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
          content: const Text(
            'Are you sure you want to delete this Account?',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel',
                  style: TextStyle(color: AppColors.primaryColor)),
              onPressed: () {
                Get.back();
              },
            ),
            ElevatedButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: AppColors.primaryColor),
              ),
              onPressed: () {
                // Get.offAll(const WelcomeScreen());

                CollectionUtils.userCollection
                    .doc(SharedPreferenceUtils.getUserId())
                    .delete()
                    .then((value) {
                  SharedPreferenceUtils.setUserDetail("");
                  SharedPreferenceUtils.setUserId("");
                  Get.offAll(const WelcomeScreen());
                  showErrorSnackBar("Your Account Deleted Successfully", "");
                }).onError((error, stackTrace) {
                  showErrorSnackBar("Something Went Wrong", "");
                });
              },
            ),
          ],
        );
      });
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
>>>>>>> Stashed changes

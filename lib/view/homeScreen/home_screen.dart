import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/common_snackbar.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_constant.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/bottomBar/bottom_bar_screen.dart';
import 'package:session_mate/view/drawer/drawer_screen.dart';
import 'package:session_mate/view/retrieve_count_screen/retrieve_counts_screen.dart';
import 'package:session_mate/view/therapyPlanScreen/assessment_plan_screen.dart';
import 'package:session_mate/viewModel/bottom_bar_view_model.dart';
import 'package:session_mate/viewModel/home_view_model.dart';
import 'package:session_mate/viewModel/session_view_model.dart';
import '../../utils/app_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel = Get.put(HomeViewModel());
  SessionViewModel sessionViewModel = Get.put(SessionViewModel());
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  Map<String, dynamic> userDetail = {};

  @override
  void initState() {
    userDetail = jsonDecode(SharedPreferenceUtils.getUserDetail());

    homeViewModel.checkSubscription(context);
    // TODO: implement initState
    //bottomBarViewModel.checkIsFreeTrial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: buildDrawer(),
      body: Column(
        children: [
          Stack(children: [
            const LocalAssets(imagePath: AppImageAssets.signInAppBarImage),
            Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _key.currentState?.openDrawer();
                    },
                    child: const LocalAssets(
                      imagePath: AppImageAssets.menuIcn,
                      imgColor: AppColors.primaryColor,
                    ),
                  ),
                  SizeConfig.sW40,
                  CustomText(
                    '${AppStrings.hi} ${userDetail["userName"]}',
                    color: AppColors.black1c,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w400,
                  )
                ],
              ),
            )
          ]),
          SizeConfig.sH45,
          Obx(() {
            return homeViewModel.checkSubscriptionLoader.value == true
                ? Expanded(
                    child: Center(child: const CircularProgressIndicator()))
                : Expanded(
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 10.h),
                        child: GestureDetector(
                          onTap: () async {
                            if (index == 0) {
                              Get.find<BottomBarViewModel>()
                                  .selectedBottomIndex
                                  .value = 1;
                              await SharedPreferenceUtils.setSessionId('');
                              Get.to(() => const BottomBar());
                            } else if (index == 1) {
                              sessionViewModel.retrieveCountMonthIs.value = '';
                              Get.to(() => const RetrieveCounts());
                            } else {
                              if (homeViewModel.isFreeTrial.value) {
                                Get.to(() => const AssessmentAndPlanScreen());
                              } else {
                                commonSnackBar(
                                    message: AppStrings.yourFreeTrialEnd);
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: index == 2
                                  ? !homeViewModel.isFreeTrial.value
                                      ? AppColors.black1c.withOpacity(0.1)
                                      : AppColors.white
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: [
                                BoxShadow(
                                    color: index == 2
                                        ? !homeViewModel.isFreeTrial.value
                                            ? Colors.transparent
                                            : AppColors.black.withOpacity(0.20)
                                        : AppColors.black.withOpacity(0.20),
                                    blurRadius: 10,
                                    spreadRadius: 1)
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 25.w,
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        homeTitle[index],
                                        fontWeight: FontWeight.w600,
                                        color: index == 2
                                            ? !homeViewModel.isFreeTrial.value
                                                ? AppColors.grey88
                                                : AppColors.black34
                                            : AppColors.black34,
                                        fontSize: 16.sp,
                                      ),
                                      SizeConfig.sH8,
                                      CustomText(
                                        homeSubtitle[index],
                                        fontWeight: FontWeight.w500,
                                        color: index == 2
                                            ? !homeViewModel.isFreeTrial.value
                                                ? AppColors.grey88
                                                : AppColors.black34
                                            : AppColors.black34,
                                        fontSize: 12.sp,
                                      ),
                                    ],
                                  ),
                                  SizeConfig.sW60,
                                  LocalAssets(
                                    imagePath: homeImageList[index],
                                    height: 115.w,
                                    width: 93.w,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
          })
        ],
      ),
    );
  }
}

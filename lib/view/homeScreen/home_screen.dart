import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/general/connectivity_wrapper.dart';
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
import 'package:session_mate/view/therapyPlanScreen/therapy_plan_screen.dart';
import 'package:session_mate/viewModel/bottom_bar_view_model.dart';
import 'package:session_mate/viewModel/session_view_model.dart';
import '../../utils/app_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SessionViewModel sessionViewModel = Get.put(SessionViewModel());
  BottomBarViewModel bottomBarViewModel = Get.find<BottomBarViewModel>();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
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
                    '${AppStrings.hi} Nitin',
                    color: AppColors.black1c,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w400,
                  )
                ],
              ),
            )
          ]),
          SizeConfig.sH45,
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                child: GestureDetector(
                  onTap: () async {
                    if (index == 0) {
                      Get.find<BottomBarViewModel>().selectedBottomIndex.value = 1;
                      await SharedPreferenceUtils.setSessionId('');
                      Get.to(() => const BottomBar());
                    } else if (index == 1) {
                      sessionViewModel.retrieveCountMonthIs.value = '';
                      Get.to(() => const RetrieveCounts());
                    } else {
                      if (bottomBarViewModel.isFreeTrial) {
                        Get.to(() => const AssessmentAndPlanScreen());
                      } else {
                        Get.snackbar("Message", AppStrings.yourFreeTrialEnd);
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: index == 2
                          ? !bottomBarViewModel.isFreeTrial
                              ? AppColors.black.withOpacity(0.1)
                              : AppColors.white
                          : AppColors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.black.withOpacity(0.20),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                homeTitle[index],
                                fontWeight: FontWeight.w600,
                                color: AppColors.black34,
                                fontSize: 16.sp,
                              ),
                              SizeConfig.sH8,
                              CustomText(
                                homeSubtitle[index],
                                fontWeight: FontWeight.w500,
                                color: AppColors.black34,
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
          )
        ],
      ),
    );
  }
}

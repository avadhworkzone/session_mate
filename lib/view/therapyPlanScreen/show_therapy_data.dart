<<<<<<< Updated upstream
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/common_appbar.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/view/therapyPlanScreen/user_therapy_plan_screen.dart';
import 'package:session_mate/viewModel/home_view_model.dart';

class ShowTherapyData extends StatefulWidget {
  const ShowTherapyData({super.key});

  @override
  State<ShowTherapyData> createState() => _ShowTherapyDataState();
}

class _ShowTherapyDataState extends State<ShowTherapyData> {
  HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            commonAppBar(
              title: AppStrings.yourTherapyPlan,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: homeViewModel.currentTherapyPlanData.length,
                itemBuilder: (context, index) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      onTap: () {
                        Get.to(() => UserTherapyPlanScreen(
                              therapyPlan:
                                  homeViewModel.currentTherapyPlanData[index],
                            ));
                      },
                      title: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, spreadRadius: 1)
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText('Therapist :',
                                fontWeight: FontWeight.w600, fontSize: 15.w),
                            CustomText(
                                homeViewModel.currentTherapyPlanData[index]
                                    ['therapistName']),
                            CustomText(homeViewModel
                                .currentTherapyPlanData[index]['userId']),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/common_appbar.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/view/therapyPlanScreen/user_therapy_plan_screen.dart';
import 'package:session_mate/viewModel/home_view_model.dart';

class ShowTherapyData extends StatefulWidget {
  const ShowTherapyData({super.key});

  @override
  State<ShowTherapyData> createState() => _ShowTherapyDataState();
}

class _ShowTherapyDataState extends State<ShowTherapyData> {
  HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            commonAppBar(
              title: AppStrings.yourTherapyPlan,
            ),
            (homeViewModel.currentTherapyPlanData.isNotEmpty)
                ? Expanded(
                    child: ListView.builder(
                      itemCount: homeViewModel.currentTherapyPlanData.length,
                      itemBuilder: (context, index) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListTile(
                            onTap: () {
                              Get.to(() => UserTherapyPlanScreen(
                                    therapyPlan: homeViewModel
                                        .currentTherapyPlanData[index],
                                  ));
                            },
                            title: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.w),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12, spreadRadius: 1)
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText('Therapist :',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.w),
                                  CustomText(homeViewModel
                                          .currentTherapyPlanData[index]
                                      ['therapistName']),
                                  CustomText(homeViewModel
                                      .currentTherapyPlanData[index]['userId']),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                  child: Center(
                    child: Padding(
                      padding:  EdgeInsets.only(bottom: 60.h),
                      child: CustomText(
                        AppStrings.noTherapyPlanAvailable,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                )
          ],
        ),
      ),
    );
  }
}
>>>>>>> Stashed changes

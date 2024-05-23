import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/common_appbar.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/viewModel/assessment_plan_view_model.dart';
import 'package:session_mate/viewModel/therapy_plan_view_model.dart';

class TherapyPlan extends StatefulWidget {
  const TherapyPlan({super.key});

  @override
  State<TherapyPlan> createState() => _TherapyPlanState();
}

class _TherapyPlanState extends State<TherapyPlan> {
  TherapyPlanViewModel therapyPlanViewModel = Get.put(TherapyPlanViewModel());
  AssessmentAndPlanViewModel assessmentAndPlanViewModel = Get.find();
  Map<String, dynamic> userDetail = {};

  @override
  void initState() {
    userDetail = jsonDecode(SharedPreferenceUtils.getUserDetail());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Obx(
          () => Column(
            children: [
              commonAppBar(
                  title: AppStrings.therepyPlan,
                  textColor: AppColors.white,
                  iconColor: AppColors.white),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Center(
                        //   child: commonRoundedTextField(
                        //     onChanged: (val) {
                        //       therapyPlanViewModel.childNameText = val;
                        //     },
                        //     text: AppStrings.childName,
                        //     textEditingController: therapyPlanViewModel.childNameController.value,
                        //   ),
                        // ),
                        // SizeConfig.sH10,
                        // Center(
                        //     child: commonRoundedTextField(
                        //         onChanged: (val) {
                        //           therapyPlanViewModel.childAgeText = val;
                        //         },
                        //         text: AppStrings.childAge,
                        //         textEditingController:
                        //             therapyPlanViewModel.ageNameController.value)),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.w),
                            child: CustomText(
                                assessmentAndPlanViewModel
                                        .ageGroupData.value!.level ??
                                    "",
                                color: AppColors.black1c),
                          ),
                        ),
                        SizeConfig.sH20,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              AppStrings.childName,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.w,
                            ),
                            SizeConfig.sH5,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  assessmentAndPlanViewModel
                                      .childNameSelectedList.length,
                                  (index) => CustomText(
                                        assessmentAndPlanViewModel
                                                .childNameSelectedList[index]
                                            ['name'],
                                        color: AppColors.white,
                                      )),
                            ),
                            SizeConfig.sH20,
                            CustomText(
                              AppStrings.category,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.w,
                            ),
                            SizeConfig.sH5,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  assessmentAndPlanViewModel
                                      .goalSelectedList.length,
                                  (index) => CustomText(
                                        assessmentAndPlanViewModel
                                            .goalSelectedList[index]['name'],
                                        color: AppColors.white,
                                      )),
                            ),
                            SizeConfig.sH20,
                            CustomText(
                              AppStrings.subCategory,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.w,
                            ),
                            SizeConfig.sH5,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  assessmentAndPlanViewModel
                                      .subGoalSelectedList.length,
                                  (index) => CustomText(
                                        assessmentAndPlanViewModel
                                            .subGoalSelectedList[index]['name'],
                                        color: AppColors.white,
                                      )),
                            ),
                            SizeConfig.sH20,
                            CustomText(
                              AppStrings.currentLeval,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.w,
                            ),
                            SizeConfig.sH5,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  assessmentAndPlanViewModel
                                      .currentLevelSelectedList.length,
                                  (index) => CustomText(
                                        assessmentAndPlanViewModel
                                                .currentLevelSelectedList[index]
                                            ['name'],
                                        color: AppColors.white,
                                      )),
                            ),
                            SizeConfig.sH20,
                            CustomText(
                              AppStrings.strategies,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.w,
                            ),
                            SizeConfig.sH5,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  assessmentAndPlanViewModel
                                      .strategiesSelectedList.length,
                                  (index) => CustomText(
                                        assessmentAndPlanViewModel
                                                .strategiesSelectedList[index]
                                            ['name'],
                                        color: AppColors.white,
                                      )),
                            )
                          ],
                        ),
                        // Container(
                        //   // height: 499.78.h,
                        //   // width: 367.w,
                        //   decoration: BoxDecoration(
                        //       color: AppColors.white,
                        //       borderRadius: BorderRadius.circular(10)),
                        //   child: Column(
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.only(top: 15),
                        //         child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceAround,
                        //           children: [
                        //             CustomText(
                        //               AppStrings.category,
                        //               fontWeight: FontWeight.w700,
                        //               color: AppColors.color59,
                        //               fontSize: 14,
                        //             ),
                        //             CustomText(AppStrings.subCategory,
                        //                 fontWeight: FontWeight.w700,
                        //                 color: AppColors.color59,
                        //                 fontSize: 14),
                        //             CustomText(
                        //               AppStrings.currentLeval,
                        //               fontWeight: FontWeight.w700,
                        //               color: AppColors.color5B,
                        //               fontSize: 14,
                        //               textAlign: TextAlign.center,
                        //             ),
                        //             CustomText(
                        //               AppStrings.strategies,
                        //               fontWeight: FontWeight.w700,
                        //               color: AppColors.color59,
                        //               fontSize: 14,
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Container(
                        //         height: 66.h,
                        //         color: AppColors.grey,
                        //       ),
                        //       SizeConfig.sH66,
                        //       Container(
                        //         height: 66.h,
                        //         color: AppColors.grey,
                        //       ),
                        //       SizeConfig.sH66,
                        //       Container(
                        //         height: 66.h,
                        //         color: AppColors.grey,
                        //       ),
                        //       SizeConfig.sH66,
                        //     ],
                        //   ),
                        // ),
                        SizeConfig.sH35,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomBtn(
                              onTap: () {
                                Get.back();
                              },
                              height: 55.h,
                              width: 144.w,
                              bgColor: AppColors.whiteF5,
                              title: AppStrings.back,
                              textColor: AppColors.colorA2,
                            ),
                            CustomBtn(
                              onTap: () {
                                therapyPlanViewModel.setTherapyData(
                                    therapistName: userDetail["userName"]);
                                therapyPlanViewModel.generateAndSendPDFOnEmail(
                                    userEmailId: userDetail["email"]);
                              },
                              height: 55.h,
                              width: 144.w,
                              bgColor: AppColors.whiteF5,
                              title: AppStrings.submit,
                              textColor: AppColors.colorA2,
                            )
                          ],
                        ),
                        SizeConfig.sH15,
                        const Divider(
                          color: AppColors.whiteFF,
                        ),
                        // Row(
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(
                        //         left: 43,
                        //       ),
                        //       child: Center(
                        //         child: Container(
                        //             height: 56.h,
                        //             width: 65.w,
                        //             decoration: BoxDecoration(
                        //               color: AppColors.white,
                        //               borderRadius: BorderRadius.circular(10),
                        //             ),
                        //             child: const LocalAssets(
                        //                 imagePath: AppImageAssets.download)),
                        //       ),
                        //     ),
                        //     SizeConfig.sW15,
                        //     CustomText(
                        //       AppStrings.downloadPlan,
                        //       color: AppColors.white,
                        //       fontWeight: FontWeight.w700,
                        //       fontSize: 20,
                        //     )
                        //   ],
                        // ),
                        SizeConfig.sH15,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Icon(
                            //   Icons.share_outlined,
                            //   color: AppColors.whiteFF,
                            //   size: 30.w,
                            // ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(20),
                            //       color: AppColors.primaryColor,
                            //       border: Border.all(
                            //           width: 2, color: AppColors.white)),
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(10),
                            //     child: CustomText(
                            //       AppStrings.share,
                            //       color: AppColors.white,
                            //       fontSize: 20.sp,
                            //       fontWeight: FontWeight.w700,
                            //     ),
                            //   ),
                            // ),
                            GestureDetector(
                              onTap: () {
                                therapyPlanViewModel
                                    .generateAndSendPdfOnWhatsApp();
                              },
                              child: LocalAssets(
                                imagePath: AppImageAssets.whatsapp,
                                height: 80.h,
                                width: 80.w,
                              ),
                            ),
                            // Container(
                            //     height: 56.h,
                            //     width: 65.w,
                            //     decoration: BoxDecoration(
                            //       color: AppColors.white,
                            //       borderRadius: BorderRadius.circular(10),
                            //       // image: DecorationImage(image: LocalAssets(imagePath: AppImageAssets.download,boxFix: BoxFit.fill,imgColor: AppColors.primaryColor,)
                            //     ),
                            //     child: const Center(
                            //         child: LocalAssets(
                            //       imagePath: AppImageAssets.messageBox,
                            //     ))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/common_methods.dart';

import '../../../commonWidget/custom_btn.dart';
import '../../../commonWidget/custom_text.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_image_assets.dart';
import '../../../utils/local_assets.dart';
import '../../../utils/size_config_utils.dart';

class AssessMentPlanScreen extends StatefulWidget {
  const AssessMentPlanScreen({super.key});

  @override
  State<AssessMentPlanScreen> createState() => _AssessMentPlanScreenState();
}

class _AssessMentPlanScreenState extends State<AssessMentPlanScreen> {
bool _approved  = false;
bool _disapproved  = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          commonAppBar(
            localAssets: LocalAssets(
              imagePath: AppImageAssets.backArrow,
              height: 23.h,
              width: 23.w,
              imgColor: AppColors.white,
            ),
            title: AppStrings.assessmentPlan,
            color: AppColors.white,
          ),

          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: 499.78.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomText(
                              AppStrings.category,
                              fontWeight: FontWeight.w700,
                              color: AppColors.color59,
                              fontSize: 14,
                            ),
                            CustomText(AppStrings.subCategory,
                                fontWeight: FontWeight.w700,
                                color: AppColors.color59,
                                fontSize: 14),
                            CustomText(
                              AppStrings.currentLeval,
                              fontWeight: FontWeight.w700,
                              color: AppColors.color5B,
                              fontSize: 14,
                              textAlign: TextAlign.center,
                            ),
                            CustomText(
                              AppStrings.strategies,
                              fontWeight: FontWeight.w700,
                              color: AppColors.color59,
                              fontSize: 14,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 66.h,
                        width: Get.width,
                        color: AppColors.grey,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child:  commonCheckBox(
                              value: _approved,
                              onChanged: (value) {
                                setState(() {
                                  _approved = value!;
                                });
                              }
                          ),
                        )

                      ),
                      Container(
                        height: 66.h,
                        child:Align(
                            alignment: Alignment.centerRight,
                          child:  commonCheckBox(
                              value: _disapproved,
                              onChanged: (value) {
                                setState(() {
                                  _disapproved = value!;
                                });
                              }
                          ),
                        )
                      ),
                      Container(
                        height: 66.h,
                        width: Get.width,
                        color: AppColors.grey,
                      ),
                      Container(
                        height: 66.h,
                      ),
                      Container(
                        height: 66.h,
                        width: Get.width,
                        color: AppColors.grey,
                      ),
                      Container(
                        height: 66.h,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          SizeConfig.sH35,
          CustomBtn(
            onTap: () {},
            height: 55.h,
            width: 144.w,
            bgColor: AppColors.white,
            title: AppStrings.submit,
            textColor: AppColors.colorA2,
          )
        ],
      ),
    ));
  }
}

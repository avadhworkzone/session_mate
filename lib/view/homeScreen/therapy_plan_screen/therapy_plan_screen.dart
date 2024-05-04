import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/general/connectivity_wrapper.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/homeScreen/therapy_plan_screen/assessment_plan_screen.dart';

import '../../../utils/common_methods.dart';

class TherapyPlan extends StatefulWidget {
  const TherapyPlan({super.key});

  @override
  State<TherapyPlan> createState() => _TherapyPlanState();
}

class _TherapyPlanState extends State<TherapyPlan> {
  TextEditingController childNameController = TextEditingController();
  TextEditingController ageNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Column(
          children: [
            commonAppBar(localAssets: LocalAssets(imagePath: AppImageAssets.backArrow,height: 23.h,width: 23.w,imgColor: AppColors.white,),
              title: AppStrings.therepyPlan, color: AppColors.white,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    commonAppTextField(
                        text: AppStrings.childName,

                        textEditingController: childNameController),
                    SizeConfig.sH10,
                    commonAppTextField(
                        text: AppStrings.childAge,
                        textEditingController: ageNameController),
                    SizeConfig.sH10,
                    Stack(
                      children: [
                        Container(
                          height: 499.78.h,
                          width: 367.w,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                    CustomText(AppStrings.currentLeval,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.color5B,
                                        fontSize: 14,textAlign: TextAlign.center,),
                                    CustomText(AppStrings.strategies,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.color59,
                                        fontSize: 14,textAlign: TextAlign.center,),
                                  ],
                                ),
                              ),
                              Container(
                                height: 66.h,
                                width: 367.w,
                                color: AppColors.grey,
                              ),
                              SizeConfig.sH66,
                              Container(
                                height: 66.h,
                                width: 367.w,
                                color: AppColors.grey,
                              ),
                              SizeConfig.sH66,
                              Container(
                                height: 66.h,
                                width: 367.w,
                                color: AppColors.grey,
                              ),
                              SizeConfig.sH66,
                            ],
                          ),
                        )
                      ],
                    ),
                    SizeConfig.sH15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomBtn(
                          onTap: () {
                            navigate(view: AssessMentPlanScreen());
                            // Get.to(()=>AssessMentPlanScreen());
                          },
                          height: 55.h,
                          width: 144.w,
                          bgColor: AppColors.white,
                          title: AppStrings.back,
                          textColor: AppColors.colorA2,
                        ),
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
                    SizeConfig.sH15,
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 43,
                          ),
                          child: Center(
                            child: Container(
                                height: 56.h,
                                width: 65.w,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: LocalAssets(
                                    imagePath: AppImageAssets.download)),
                          ),
                        ),
                        SizeConfig.sW15,
                        CustomText(
                          AppStrings.downloadPlan,
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        )
                      ],
                    ),
                    SizeConfig.sH15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.primaryColor,
                              border:
                                  Border.all(width: 2, color: AppColors.white)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: CustomText(
                              AppStrings.share,
                              color: AppColors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        LocalAssets(
                          imagePath: AppImageAssets.whatsapp,
                          height: 80.h,
                          width: 80.w,
                        ),
                        Container(
                            height: 56.h,
                            width: 65.w,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),

                              // image: DecorationImage(image: LocalAssets(imagePath: AppImageAssets.download,boxFix: BoxFit.fill,imgColor: AppColors.primaryColor,)
                            ),
                            child: Center(
                                child: LocalAssets(
                              imagePath: AppImageAssets.messageBox,
                            ))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

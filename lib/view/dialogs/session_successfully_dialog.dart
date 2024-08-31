import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/bottomBar/bottom_bar_screen.dart';
import 'package:session_mate/viewModel/bottom_bar_view_model.dart';
import 'package:session_mate/viewModel/session_view_model.dart';

sessionSuccessfullyDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizeConfig.sH20,
                    CustomText(
                      AppStrings.sessionCaptured,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                      color: AppColors.black,
                    ),
                    SizeConfig.sH10,
                    CustomText(
                      AppStrings.sessionSuccessfully,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColors.black,
                      textAlign: TextAlign.center,
                    ),
                    SizeConfig.sH15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomBtn(
                          onTap: () {
                            Get.find<SessionViewModel>()
                                .selectedSession
                                .clear();
                            Get.find<SessionViewModel>().sessionDate.value = '';
                            // Get.find<SessionViewModel>().sessionName.value = '';
                            Get.back();
                          },
                          height: 33.h,
                          width: 70.w,
                          radius: 13.r,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(0.5),
                              blurRadius: 2,
                            )
                          ],
                          title: AppStrings.yes,
                        ),
                        CustomBtn(
                            onTap: () {
                              Get.find<BottomBarViewModel>()
                                  .selectedBottomIndex
                                  .value = 0;
                              Get.offAll(() => const BottomBar());
                              // Get.find<SessionViewModel>().sessionName.value =
                              //     '';
                              // Get.back();
                            },
                            height: 33.h,
                            width: 70.w,
                            radius: 13.r,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.5),
                                blurRadius: 2,
                              )
                            ],
                            title: AppStrings.no),
                      ],
                    ),
                    SizeConfig.sH10,
                  ],
                ),
              )
            ],
          ));
}

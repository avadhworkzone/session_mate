import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/common_appbar.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_constant.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/viewModel/my_plan_view_model.dart';

class MyPlanScreen extends StatefulWidget {
  final Map<String, dynamic> userDetail;

  const MyPlanScreen({super.key, required this.userDetail});

  @override
  State<MyPlanScreen> createState() => _MyPlanScreenState();
}

class _MyPlanScreenState extends State<MyPlanScreen> {
  MyPlanViewModel myPlanViewModel = MyPlanViewModel();

  @override
  Widget build(BuildContext context) {
    DateTime subStartDate =
        DateTime.parse(widget.userDetail["subscriptionStartDate"]);
    DateTime subEndDate =
        DateTime.parse(widget.userDetail["subscriptionEndDate"]);

    String getMonthName(int month) {
      switch (month) {
        case 1:
          return "Jan";
        case 2:
          return "Feb";
        case 3:
          return "Mar";
        case 4:
          return "Apr";
        case 5:
          return "May";
        case 6:
          return "June";
        case 7:
          return "July";
        case 8:
          return "Aug";
        case 9:
          return "Sep";
        case 10:
          return "Oct";
        case 11:
          return "Nov";
        case 12:
          return "Dec";
        default:
          return "";
      }
    }

    return Material(
      child: Column(
        children: [
          SizeConfig.sH10,
          commonAppBar(
              title: AppStrings.myPlan,
              textColor: AppColors.black,
              iconColor: AppColors.black),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: Container(
              height: Get.width,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12.r)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomText(
                      (widget.userDetail["subscriptionType"] == "monthly")
                          ? AppStrings.monthly
                          : AppStrings.yearly,
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                    ),
                    CustomText(
                      (widget.userDetail["subscriptionType"] == "monthly")
                          ? AppStrings.inrTenMonth
                          : AppStrings.inr100Year,
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 17.w,
                        ),
                        Image.asset(
                          AppImageAssets.tikMarkIcon,
                          color: AppColors.white,
                          height: 12.h,
                          width: 12.w,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(
                          AppStrings.sessionTracking,
                          color: AppColors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppConstants.openSans,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 17.w,
                        ),
                        Image.asset(
                          AppImageAssets.tikMarkIcon,
                          color: AppColors.white,
                          height: 12.h,
                          width: 12.w,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(
                          AppStrings.therapyPlanDownload,
                          color: AppColors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppConstants.openSans,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 17.w,
                        ),
                        Image.asset(
                          AppImageAssets.tikMarkIcon,
                          color: AppColors.white,
                          height: 12.h,
                          width: 12.w,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(
                          AppStrings.twoFreeSession,
                          color: AppColors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppConstants.openSans,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 17.w,
                        ),
                        Image.asset(
                          AppImageAssets.tikMarkIcon,
                          color: AppColors.white,
                          //subscriptionViewModel.carouselItem[index]["fourthColor"],
                          height: 12.h,
                          width: 12.w,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(
                          AppStrings.freeGuideOnGutHealth,
                          color: AppColors.white,
                          //subscriptionViewModel.carouselItem[index]["fourthColor"],
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppConstants.openSans,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 17.w,
                        ),
                        Image.asset(
                          AppImageAssets.tikMarkIcon,
                          color: AppColors.white,
                          //subscriptionViewModel.carouselItem[index]["fifthColor"],
                          height: 12.h,
                          width: 12.w,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(
                          AppStrings.freeGuideOnAlternativeTherapy,
                          color: AppColors.white,
                          //subscriptionViewModel.carouselItem[index]["fifthColor"],
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppConstants.openSans,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizeConfig.sH50,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      AppStrings.createdOn,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: AppColors.primaryColor,
                    ),
                    SizeConfig.sH10,
                    Container(
                      height: 29.07.h,
                      width: 135.w,
                      margin: EdgeInsets.only(left: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.sp),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: Center(
                          child: CustomText(
                        "${getMonthName(subStartDate.month)} ${subStartDate.year}",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: AppColors.color54,
                      )),
                    )
                  ],
                ),
                SizeConfig.sW20,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                      AppStrings.expired,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: AppColors.primaryColor,
                    ),
                    SizeConfig.sH10,
                    Container(
                      height: 29.07.h,
                      width: 135.w,
                      margin: EdgeInsets.only(left: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.sp),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: Center(
                          child: CustomText(
                        "${getMonthName(subEndDate.month)} ${subEndDate.year}",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: AppColors.color54,
                      )),
                    )
                  ],
                )
              ],
            ),
          ),
          SizeConfig.sH40,
          CustomBtn(
            onTap: () {
              myPlanViewModel.razorPayRefundApi(
                  amount: (myPlanViewModel.userDetail["subscriptionType"] == "monthly")
                      ? 49 : 499);
            },
            title: AppStrings.cancelPlan,
            width: 221.w,
          )
        ],
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_constant.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/view/subScriptionScreen/common_subscription_textfield.dart';
import 'package:session_mate/viewModel/subScription_view_model.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  SubscriptionViewModel subscriptionViewModel = Get.put(SubscriptionViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),

            ///TITLE ROW
            Row(
              children: [
                SizedBox(
                  width: 29.w,
                ),
                LocalAssets(
                  width: 8.65.w,
                  height: 16.9.h,
                  imagePath: AppImageAssets.backArrow,
                ),
                SizedBox(
                  width: 22.w,
                ),
                CustomText(
                  AppStrings.buySubscription,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black1c,
                )
              ],
            ),
            SizedBox(
              height: 23.14.h,
            ),
            CommonSubscriptionTextField(hintText: AppStrings.name),
            SizedBox(
              height: 23.27.h,
            ),
            CommonSubscriptionTextField(hintText: AppStrings.emailAddress),
            SizedBox(
              height: 23.27.h,
            ),
            CommonSubscriptionTextField(hintText: AppStrings.phoneNumber),
            SizedBox(
              height: 58.66.h,
            ),
            CarouselSlider(
              items: List.generate(
                subscriptionViewModel.carouselItem.length,
                (index) => Container(
                  height: 340.h,
                  width: 261.w,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor, borderRadius: BorderRadius.circular(12.r)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomText(
                        subscriptionViewModel.carouselItem[index]["title"],
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp,
                      ),
                      if (index != 0)
                        CustomText(
                          subscriptionViewModel.carouselItem[index]["title2"],
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
                            color: subscriptionViewModel.carouselItem[index]["firstColor"],
                            height: 12.h,
                            width: 12.w,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomText(
                            AppStrings.sessionTracking,
                            color: subscriptionViewModel.carouselItem[index]["firstColor"],
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
                            color: subscriptionViewModel.carouselItem[index]["secondColor"],
                            height: 12.h,
                            width: 12.w,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomText(
                            AppStrings.therapyPlanDownload,
                            color: subscriptionViewModel.carouselItem[index]["secondColor"],
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
                            color: subscriptionViewModel.carouselItem[index]["thirdColor"],
                            height: 12.h,
                            width: 12.w,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomText(
                            AppStrings.twoFreeSession,
                            color: subscriptionViewModel.carouselItem[index]["thirdColor"],
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
                            color: subscriptionViewModel.carouselItem[index]["fourthColor"],
                            height: 12.h,
                            width: 12.w,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomText(
                            AppStrings.freeGuideOnGutHealth,
                            color: subscriptionViewModel.carouselItem[index]["fourthColor"],
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
                            color: subscriptionViewModel.carouselItem[index]["fifthColor"],
                            height: 12.h,
                            width: 12.w,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          CustomText(
                            AppStrings.freeGuideOnAlternativeTherapy,
                            color: subscriptionViewModel.carouselItem[index]["fifthColor"],
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppConstants.openSans,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 27.h,
                      ),
                      InkWell(
                        onTap: () => subscriptionViewModel.buyBtnTap(index),
                        borderRadius: BorderRadius.circular(15.r),
                        child: Container(
                          height: 44.h,
                          width: 111.w,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Center(
                            child: CustomText(
                              AppStrings.buy,
                              color: AppColors.colorA2,
                              fontFamily: AppConstants.poppins,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              options: CarouselOptions(height: 340.h, viewportFraction: 0.7),
            ),
            SizedBox(
              height: 29.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  AppStrings.fourteenDayAsked,
                  fontSize: 16.sp,
                  color: AppColors.black1c,
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  AppStrings.moneyBackGuarantee,
                  fontSize: 16.sp,
                  color: AppColors.black1c,
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

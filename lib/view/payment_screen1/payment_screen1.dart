import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_constant.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/viewModel/payment_screen1_view_model.dart';

class PaymentScreen1 extends StatefulWidget {
  const PaymentScreen1({super.key});

  @override
  State<PaymentScreen1> createState() => _PaymentScreen1State();
}

class _PaymentScreen1State extends State<PaymentScreen1> {
  PaymentScreen1ViewModel paymentScreen1ViewModel = Get.put(PaymentScreen1ViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 45.w,
                ),
                GestureDetector(onTap: () => paymentScreen1ViewModel.closeBtnTap(),
                    child: Icon(Icons.close, color: AppColors.closeIconColor, size: 16.sp,)),
              ],
            ),
            SizedBox(
                height: 89.h,
            ),
            Image.asset(AppImageAssets.paymentImage, height: 254.h, width: 315.w,),
            SizedBox(
              height: 91.h,
            ),
            RichText(text: TextSpan(
                text: AppStrings.only,
                style: TextStyle(
                  color: AppColors.blue5Ecc,
                  fontFamily: AppConstants.inter,
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                ),
                children: [
                  TextSpan(
                    text: AppStrings.inrYear1300,
                    style: TextStyle(
                      color: AppColors.black1c,
                      fontFamily: AppConstants.inter,
                      fontWeight: FontWeight.w600,
                      fontSize: 24.sp,
                    ),
                  ),
                ]
            ),),
            SizedBox(
              height: 27.h,
            ),
            CustomBtn(onTap: ()=> paymentScreen1ViewModel.claimOfferBtnTap(), title: AppStrings.claimOffer, width: 353.w,),
            SizedBox(
              height: 38.h,
            ),
            CustomText(AppStrings.cancelAnytimeBilledAnnually, fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black1c,),
            SizedBox(
              height: 55.h,
            ),
            SizedBox(
              width: 353.w,
              child: const Divider(
                color: AppColors.black1c,
              ),
            ),
            SizedBox(
              height: 17.h,
            ),
            CustomText(AppStrings.termsAndConditionPrivacyPolicy, fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: AppColors.black1c,)
          ],
        ),
      ),
    );
  }
}

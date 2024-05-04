import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/view/subScriptionScreen/common_subscription_textfield.dart';
import 'package:session_mate/viewModel/add_bank_card_view_model.dart';

class AddBankCardScreen extends StatefulWidget {
  const AddBankCardScreen({super.key});

  @override
  State<AddBankCardScreen> createState() => _AddBankCardScreenState();
}

class _AddBankCardScreenState extends State<AddBankCardScreen> {

  AddBankCardViewModel addBankCardViewModel = Get.put(AddBankCardViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        width: Get.width,
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 87.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 27.w,
                  ),
                  LocalAssets(
                    imagePath: AppImageAssets.backArrow,
                    height: 16.h,
                    width: 16.w,
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  CustomText(
                    AppStrings.addCreditDebitCard,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              SizedBox(
                height: 31.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 47.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      AppStrings.cardNumber,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: AppColors.black1c,
                    ),
                    SizedBox(
                      height: 17.h,
                    ),
                    CommonSubscriptionTextField(
                      controller: addBankCardViewModel.cardNumberController,
                      height: 52.h,
                      width: 327.w,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: LocalAssets(imagePath: AppImageAssets.bankCard,
                            height: 23.33.h,
                            width: 28.w,),
                        ),
                      ),
                      focusedBorderColor: AppColors.blue5Ecc,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 26.h,
                    ),
                    Row(
                      children: [
                        GetBuilder<AddBankCardViewModel>(id: "mmVv",builder: (controller) {
                          return CommonSubscriptionTextField(
                            controller: addBankCardViewModel.mmVvController,
                            onChanged: (val) => addBankCardViewModel.mmVvFieldOnChange(val),
                            height: 44.h,
                            width: 122.w,
                            labelText: AppStrings.mmVv,
                            labelStyle: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blue5Ecc,
                            ),
                            focusedBorderColor: AppColors.blue5Ecc,
                            keyboardType: TextInputType.number,
                          );
                        }),
                        SizedBox(
                          width: 34.w,
                        ),
                        CommonSubscriptionTextField(
                          controller: addBankCardViewModel.cvvController,
                          height: 44.h,
                          width: 144.h,
                          labelText: AppStrings.cvv,
                          labelStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.blue5Ecc,
                          ),
                          focusedBorderColor: AppColors.blue5Ecc,
                          keyboardType: TextInputType.number,
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Padding(
                              padding: EdgeInsets.all(10.w),
                              child: LocalAssets(
                                imagePath: AppImageAssets.bankCard, height: 23.33.h, width: 28.w,),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15.r),
                      onTap: () => addBankCardViewModel.scanCardBtnTap(),
                      child: Container(
                        height: 43.2.h,
                        width: 149.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                            color: AppColors.black,
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 20.w,),
                            LocalAssets(
                                imagePath: AppImageAssets.cameraIcn, height: 42.h, width: 48.w),
                            SizedBox(width: 11.w,),
                            CustomText(AppStrings.scan, fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black1c,)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 163.8.h,
              ),
              CustomBtn(width: 372.w, onTap: () {}, title: AppStrings.save,)
            ],
          ),
        ),
      ),
    );
  }
}

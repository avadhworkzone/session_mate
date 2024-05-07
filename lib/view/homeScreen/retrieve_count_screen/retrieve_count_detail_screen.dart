import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/commom_textfield.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/regex.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/viewModel/session_view_model.dart';

class RetrieveCountDetailScreen extends StatefulWidget {
  const RetrieveCountDetailScreen({super.key});

  @override
  State<RetrieveCountDetailScreen> createState() =>
      _RetrieveCountDetailScreenState();
}

class _RetrieveCountDetailScreenState extends State<RetrieveCountDetailScreen> {
  SessionViewModel sessionViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          children: [
            commonAppBar(
                localAssets: LocalAssets(
                  imagePath: AppImageAssets.backArrow,
                  height: 23.h,
                  width: 23.w,
                ),
                title: AppStrings.sessionCount,
                color: AppColors.black1c),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      AppStrings.sessionName,
                      color: AppColors.black1c,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizeConfig.sH10,
                    CommonReadableTextField(
                      regularExpression:
                          RegularExpressionUtils.alphabetSpacePattern,
                      textEditController: sessionViewModel
                          .sessionNameTextEditingController.value,
                      keyBoardType: TextInputType.text,
                      hintText: '',
                      contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                    ),
                    SizeConfig.sH25,
                    CustomText(
                      AppStrings.count,
                      color: AppColors.black1c,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizeConfig.sH10,
                    CommonReadableTextField(
                      regularExpression:
                          RegularExpressionUtils.alphabetSpacePattern,
                      textEditController: sessionViewModel
                          .sessionNameTextEditingController.value,
                      keyBoardType: TextInputType.text,
                      hintText: '',
                      contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                    ),
                    SizeConfig.sH25,
                    CustomText(
                      AppStrings.therapyCenter,
                      color: AppColors.black1c,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizeConfig.sH10,
                    CommonReadableTextField(
                      regularExpression:
                          RegularExpressionUtils.alphabetSpacePattern,
                      textEditController: sessionViewModel
                          .sessionNameTextEditingController.value,
                      keyBoardType: TextInputType.text,
                      hintText: '',
                      contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                    ),
                    SizeConfig.sH20,
                    CustomText(
                      'Date & Tme',
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                    SizeConfig.sH10,
                    Container(
                      margin: EdgeInsets.only(left: 30.w),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CustomText(
                                '2 AM       04/05/2024',
                                color: AppColors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/sessionScreen/common_session_container.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(backgroundColor: AppColors.primaryColor),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30.w, bottom: 30.h),
            child: Row(
              children: [
                Container(
                  height: 50.h,
                  width: 65.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.r),
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu0gYR-As9-_w2_fjRc895mD_91WQ5p7N_9Q&s'))),
                ),
                SizeConfig.sW15,
                CustomText(
                  'Hi, Nitin',
                  color: AppColors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w400,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(35.r),
                      topLeft: Radius.circular(35.r))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizeConfig.sH30,
                  CustomText(
                    AppStrings.chooseYourSession,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: AppColors.black34,
                  ),
                  SizeConfig.sH25,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CommonSessionContainer(
                        imageUrl: AppImageAssets.sessionIcn,
                        titleText: AppStrings.specialEducation,
                      ),
                      CommonSessionContainer(
                        imageUrl: AppImageAssets.sessionIcn,
                        titleText: AppStrings.occupationalTherapy,
                      )
                    ],
                  ),
                  SizeConfig.sH35,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CommonSessionContainer(
                        imageUrl: AppImageAssets.sessionIcn,
                        titleText: AppStrings.sports,
                      ),
                      CommonSessionContainer(
                        imageUrl: AppImageAssets.sessionIcn,
                        titleText: AppStrings.speech,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

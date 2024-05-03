import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/sessionScreen/common_session_container.dart';
import 'package:session_mate/viewModel/session_view_model.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  SessionViewModel sessionViewModel = Get.put(SessionViewModel());

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
              child: SingleChildScrollView(
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
                          imageUrl: AppImageAssets.specialEducationIcn,
                          titleText: AppStrings.specialEducation,
                        ),
                        CommonSessionContainer(
                          imageUrl: AppImageAssets.occupationalTherapyIcn,
                          titleText: AppStrings.occupationalTherapy,
                        )
                      ],
                    ),
                    SizeConfig.sH35,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CommonSessionContainer(
                          imageUrl: AppImageAssets.sportIcn,
                          titleText: AppStrings.sports,
                        ),
                        CommonSessionContainer(
                          imageUrl: AppImageAssets.speechIcn,
                          titleText: AppStrings.speech,
                        )
                      ],
                    ),
                    SizeConfig.sH35,
                    CommonSessionContainer(
                      imageUrl: AppImageAssets.musicIcn,
                      titleText: AppStrings.music,
                    ),
                    SizeConfig.sH25,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.w),
                      child: Container(
                        height: 45.h,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17.r),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButton<String>(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                isExpanded: true,
                                underline: SizedBox(),
                                iconEnabledColor: AppColors.color97,
                                iconDisabledColor: AppColors.color97,
                                hint: CustomText(
                                  AppStrings.selectTherapy,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                  color: AppColors.color97,
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Therapy 1',
                                    child: Text('Therapy 1'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Therapy 2',
                                    child: Text('Therapy 2'),
                                  ),
                                ],
                                onChanged: (value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizeConfig.sH15,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.w),
                      child: GestureDetector(
                        onTap: () => sessionViewModel.selectDate(context),
                        child: Container(
                          height: 45.h,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.r),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Obx(
                              () => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    sessionViewModel.isSelected.value == true
                                        ? sessionViewModel.date.value
                                        : AppStrings.calender,
                                    fontSize: 15.sp,
                                    color: AppColors.color97,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  LocalAssets(
                                      imagePath: AppImageAssets.calenderIcn)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizeConfig.sH18,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: CustomBtn(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => SimpleDialog(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25.w),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  CustomBtn(
                                                    onTap: () {},
                                                    height: 33.h,
                                                    width: 70.w,
                                                    radius: 13.r,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: AppColors.black
                                                            .withOpacity(0.5),
                                                        blurRadius: 2,
                                                      )
                                                    ],
                                                    title: AppStrings.yes,
                                                  ),
                                                  CustomBtn(
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      height: 33.h,
                                                      width: 70.w,
                                                      radius: 13.r,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: AppColors.black
                                                              .withOpacity(0.5),
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
                          },
                          title: AppStrings.submit),
                    ),
                    SizeConfig.sH35,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

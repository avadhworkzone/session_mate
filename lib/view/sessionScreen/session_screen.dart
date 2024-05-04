import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/modal/add_service_data_model.dart';
import 'package:session_mate/service/session_service.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_constant.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/utils/loading_dialog.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/sessionScreen/common_session_container.dart';
import 'package:session_mate/view/dialogs/session_successfully_dialog.dart';
import 'package:session_mate/viewModel/session_view_model.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  SessionViewModel sessionViewModel = Get.put(SessionViewModel());
  AddSessionDataModel sessionDataReq = AddSessionDataModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor),
        leading: const SizedBox(),
        leadingWidth: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30.w, bottom: 30.w, top: 20.w),
            child: Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 26.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.r),
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu0gYR-As9-_w2_fjRc895mD_91WQ5p7N_9Q&s'))),
                ),
                SizeConfig.sW15,
                CustomText(
                  '${AppStrings.hi} Nitin',
                  color: AppColors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                )
              ],
            ),
          ),
          Obx(() {
            return Expanded(
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
                      Wrap(
                          alignment: WrapAlignment.center,
                          runSpacing: 30.w,
                          spacing: 40.w,
                          children: List.generate(
                              sessionDataList.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(
                                        8.0), // Add some spacing between items
                                    child: InkWell(
                                      onTap: () {
                                        sessionViewModel.sessionSelect.value =
                                            index;
                                        sessionViewModel.sessionName.value =
                                            sessionDataList[index]
                                                ['session_name'];
                                      },
                                      child: CommonSessionContainer(
                                        imageUrl: sessionDataList[index]
                                            ['image'],
                                        titleText: sessionDataList[index]
                                            ['session_name'],
                                        color: sessionViewModel
                                                    .sessionSelect.value ==
                                                index
                                            ? AppColors.primaryColor
                                            : Colors.transparent,
                                      ),
                                    ),
                                  ))

                          // sessionDataList.map((sessionData) {
                          //   return Padding(
                          //     padding: const EdgeInsets.all(
                          //         8.0), // Add some spacing between items
                          //     child: InkWell(
                          //       onTap: () {},
                          //       child: CommonSessionContainer(
                          //         imageUrl: sessionData['image'],
                          //         titleText: sessionData['session_name'],
                          //         color: AppColors.primaryColor,
                          //       ),
                          //     ),
                          //   );
                          // }).toList(),
                          ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     CommonSessionContainer(
                      //       imageUrl: AppImageAssets.specialEducationIcn,
                      //       titleText: AppStrings.specialEducation,
                      //     ),
                      //     CommonSessionContainer(
                      //       imageUrl: AppImageAssets.occupationalTherapyIcn,
                      //       titleText: AppStrings.occupationalTherapy,
                      //     )
                      //   ],
                      // ),
                      // SizeConfig.sH35,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     CommonSessionContainer(
                      //       imageUrl: AppImageAssets.sportIcn,
                      //       titleText: AppStrings.sports,
                      //     ),
                      //     CommonSessionContainer(
                      //       imageUrl: AppImageAssets.speechIcn,
                      //       titleText: AppStrings.speech,
                      //     )
                      //   ],
                      // ),
                      // SizeConfig.sH35,
                      // CommonSessionContainer(
                      //   imageUrl: AppImageAssets.musicIcn,
                      //   titleText: AppImageAssets.musicIcn,
                      // ),
                      SizeConfig.sH25,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.w),
                        child: Container(
                          height: Get.width / 9,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: DropdownButton<String>(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                            ),
                            isExpanded: true,
                            underline: const SizedBox(),
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
                      ),
                      SizeConfig.sH15,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        child: GestureDetector(
                          onTap: () => sessionViewModel.selectDate(context),
                          child: Container(
                            // height: 45.h,
                            // padding: const EdgeInsets.all(8.0),
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 10.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(color: Colors.grey),
                            ),
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
                                  const LocalAssets(
                                      imagePath: AppImageAssets.calenderIcn)
                                ],
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
                              addSessionOnTap();
                            },
                            title: AppStrings.submit),
                      ),
                      SizeConfig.sH35,
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Future<void> addSessionOnTap() async {
    showLoadingDialog(context: context);
    sessionDataReq.userId = SharedPreferenceUtils.getUserId();
    sessionDataReq.sessionName = sessionViewModel.sessionName.value;
    sessionDataReq.sessionSelectedDate = sessionViewModel.date.value;

    final status = await SessionService.addAppointmentData(sessionDataReq);

    print('APPOINTMENT  STATUS :=>$status');
    if (status) {
      // hideLoadingDialog(context: context);
      Get.back();
      sessionSuccessfullyDialog(context);
    } else {
      // hideLoadingDialog(context: context);
      Get.back();

      /// SOMETHING WENT WRONG
      commonSnackBar(message: AppStrings.somethingWrong);
    }
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/common_snackbar.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/commonWidget/no_data_found_widget.dart';
import 'package:session_mate/modal/get_session_list_model.dart';
import 'package:session_mate/service/session_service.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_constant.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/retrieve_count_screen/retrieve_count_detail_screen.dart';
import 'package:session_mate/view/sessionScreen/common_session_container.dart';
import 'package:session_mate/viewModel/session_view_model.dart';

class RetrieveCounts extends StatefulWidget {
  const RetrieveCounts({super.key});

  @override
  State<RetrieveCounts> createState() => _RetrieveCountsState();
}

class _RetrieveCountsState extends State<RetrieveCounts> {
  SessionViewModel sessionViewModel = Get.find();
  int? selectedDataIndex;
  String? selectedSessionName;
  List<SessionListData>? snapshotData;
  Map<String, dynamic> userDetail = {};

  @override
  void initState() {
    userDetail = jsonDecode(SharedPreferenceUtils.getUserDetail());
    // TODO: implement initState
    super.initState();
  }

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
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.w),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.white,
                  ),
                ),
                SizeConfig.sW15,
                userDetail["userName"] == ""
                    ? SizedBox()
                    : CustomText(
                        '${AppStrings.hi} ${userDetail["userName"].toString().capitalizeFirst}',
                        color: AppColors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                      ),
                Spacer(),
                userDetail["userName"] == ""
                    ? SizedBox()
                    : Container(
                        height: 50.h,
                        width: 60.w,
                        // padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 26.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            color: AppColors.grey
                            /*image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu0gYR-As9-_w2_fjRc895mD_91WQ5p7N_9Q&s'))*/
                            ),
                        child: Center(
                          child: CustomText(
                            userDetail["userName"]
                                .toString()
                                .split("")
                                .first
                                .toUpperCase(),
                            color: AppColors.black,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 26.w),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(25.r),
                //       image: const DecorationImage(
                //           fit: BoxFit.cover,
                //           image: NetworkImage(
                //               'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu0gYR-As9-_w2_fjRc895mD_91WQ5p7N_9Q&s'))),
                // ),
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
                      AppStrings.retrieveCountTxt,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: AppColors.black34,
                      textAlign: TextAlign.center,
                    ),
                    SizeConfig.sH25,
                    StreamBuilder(
                      stream: SessionService.getSessionList(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return noDataFound();
                        }
                        snapshotData = snapshot.data;
                        return Wrap(
                            alignment: WrapAlignment.center,
                            runSpacing: 30.w,
                            spacing: 40.w,
                            children: List.generate(
                                snapshotData!.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(
                                          8.0), // Add some spacing between items
                                      child: InkWell(
                                        onTap: () {
                                          selectedDataIndex = index;
                                          selectedSessionName =
                                              snapshotData![index].sessionName;
                                          setState(() {});
                                        },
                                        child: CommonSessionContainer(
                                          imageUrl: sessionDataList[index]
                                              ['image'],
                                          titleText:
                                              snapshotData![index].sessionName!,
                                          color: selectedDataIndex == index
                                              ? AppColors.primaryColor
                                              : Colors.transparent,
                                        ),
                                      ),
                                    )));
                      },
                    ),
                    SizeConfig.sH25,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.w),
                      child: GestureDetector(
                        onTap: () => sessionViewModel.selectMonth(context),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  sessionViewModel.retrieveCountMonthIs.value ==
                                          ''
                                      ? AppStrings.calender
                                      : sessionViewModel
                                          .retrieveCountMonthIs.value,
                                  // : AppStrings.calender,
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
                          onTap: () async {
                            if (selectedSessionName == '' ||
                                sessionViewModel
                                    .retrieveCountMonthIs.value.isEmpty) {
                              commonSnackBar(message: 'Please Select Data');
                            } else {
                              Get.to(() => RetrieveCountDetailScreen(
                                    sessionName: selectedSessionName!,
                                    sessionSelectedMonth: sessionViewModel
                                        .retrieveCountMonthIs.value,
                                  ));
                            }
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

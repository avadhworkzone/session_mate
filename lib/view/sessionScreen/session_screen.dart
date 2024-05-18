import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/common_snackbar.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/commonWidget/no_data_found_widget.dart';
import 'package:session_mate/modal/add_session_data_model.dart';
import 'package:session_mate/modal/get_session_list_model.dart';
import 'package:session_mate/modal/therapy_center_location_data_model.dart';
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
  SessionViewModel sessionViewModel = Get.find();
  AddSessionDataModel sessionDataReq = AddSessionDataModel();
  List<TherapyCenterLocationDataModel> locationData = [];
  List<SessionListData>? snapshotData;
  String? selectedValue;
  bool isLocationNotSelected = false;
  Map<String, dynamic> userDetail = {};

  @override
  void initState() {
    userDetail = jsonDecode(SharedPreferenceUtils.getUserDetail());
    getSessionData();
    SessionService().getTherapyDropdownCenter().then((data) {
      if (data != []) {
        setState(() {
          locationData = data;
        });
      } else {
        locationData = [];
        logs('Data is null');
      }
    }).catchError((error) {
      logs('Error fetching data: $error');
    });
    // TODO: implement initState
    super.initState();
  }

  getSessionData() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      sessionViewModel.selectedSession.clear();
      sessionViewModel.sessionDate.value = '';
      if (SharedPreferenceUtils.getSessionId() != '') {
        sessionViewModel.isLoadingData.value = true;
        final snapshot = await SessionService.getEditSessionDataDetail();
        // if (snapshot != null) {
        if (!sessionViewModel.selectedSession
            .any((element) => element['id'] == snapshot.sessionId)) {
          sessionViewModel.selectedSession.add({
            'id': snapshot.sessionId,
            'session_name': snapshot.sessionName ?? '',
          });
          logs(
              'sessionViewModel.selectedSession====${sessionViewModel.selectedSession}');
        }
        sessionViewModel.sessionDate.value =
            formatMilliseconds(snapshot.sessionSelectedDate ?? 0);
        selectedValue = snapshot.therapyCenter;
        sessionViewModel.isLoadingData.value = false;
        // } else {
        //   sessionViewModel.isLoadingData.value = false;
        // }
      }
    });
  }

  // List<TherapyCenterLocationDataModel>? snapshotData;

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
                      userDetail["userName"].toString().split("").first.toUpperCase(),
                      color: AppColors.black,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizeConfig.sW15,
                CustomText(
                  '${AppStrings.hi} ${userDetail["userName"]}',
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
                child: sessionViewModel.isLoadingData.value == true
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
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
                                                  if (!sessionViewModel
                                                      .selectedSession
                                                      .any((element) =>
                                                          element['id'] ==
                                                          snapshotData![index]
                                                              .id)) {
                                                    sessionViewModel
                                                        .selectedSession
                                                        .add({
                                                      'id': snapshotData![index]
                                                          .id,
                                                      'session_name':
                                                          snapshotData![index]
                                                              .sessionName
                                                    });
                                                    logs(
                                                        'sessionViewModel.selectedSession====${sessionViewModel.selectedSession}');
                                                  } else {
                                                    sessionViewModel
                                                        .selectedSession
                                                        .removeWhere(
                                                            (element) =>
                                                                element['id'] ==
                                                                snapshotData![
                                                                        index]
                                                                    .id);
                                                  }
                                                  setState(() {});
                                                },
                                                child: CommonSessionContainer(
                                                  imageUrl: snapshotData![index]
                                                      .image!,
                                                  titleText:
                                                      snapshotData![index]
                                                          .sessionName!,
                                                  color: sessionViewModel
                                                          .selectedSession
                                                          .any((element) =>
                                                              element['id'] ==
                                                              snapshotData![
                                                                      index]
                                                                  .id)
                                                      ? AppColors.primaryColor
                                                      : Colors.transparent,
                                                ),
                                              ),
                                            )));
                              },
                            ),
                            SizeConfig.sH25,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 60.w),
                              child: Container(
                                  height: Get.width / 9,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.r),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      hint: Align(
                                        alignment: Alignment.centerLeft,
                                        child: CustomText(
                                          AppStrings.selectTherapyCenter,
                                          color: AppColors.color97,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      alignment: Alignment.center,
                                      value: selectedValue,
                                      underline: Container(),
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                      ),
                                      items: locationData
                                          .map<DropdownMenuItem<String>>(
                                              (TherapyCenterLocationDataModel
                                                  serviceData) {
                                        return DropdownMenuItem<String>(
                                          value:
                                              '${serviceData.city}, ${serviceData.state}',
                                          child: CustomText(
                                            '${serviceData.city!}, ${serviceData.state!}',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.color97,
                                          ),
                                          // label: serviceData.serviceTypeName!,
                                        );
                                      }).toList(),
                                      onChanged: (String? serviceData) {
                                        setState(() {
                                          selectedValue = serviceData;
                                        });
                                      },
                                    ),
                                  )),
                            ),
                            SizeConfig.sH15,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50.w),
                              child: GestureDetector(
                                onTap: () =>
                                    sessionViewModel.selectDate(context),
                                child: Container(
                                  // height: 45.h,
                                  // padding: const EdgeInsets.all(8.0),
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.w),
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
                                          '${sessionViewModel.sessionDate.value == '' ? AppStrings.calender : sessionViewModel.sessionDate.value}',
                                          // : AppStrings.calender,
                                          fontSize: 15.sp,
                                          color: AppColors.color97,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        const LocalAssets(
                                            imagePath:
                                                AppImageAssets.calenderIcn)
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
    if (sessionViewModel.sessionDate.value == '' ||
        sessionViewModel.selectedSession.isEmpty ||
        selectedValue == null) {
      commonSnackBar(message: 'Please Select data');
    } else {
      showLoadingDialog(context: context);
      bool? status;
      if (SharedPreferenceUtils.getSessionId() != '') {
        SessionService.deleteSessionData(SharedPreferenceUtils.getSessionId());
      }
      for (int i = 0; i < sessionViewModel.selectedSession.length; i++) {
        sessionDataReq.sessionId =
            sessionViewModel.selectedSession[i]['id'].toString();
        sessionDataReq.userId = SharedPreferenceUtils.getUserId();
        sessionDataReq.sessionName =
            sessionViewModel.selectedSession[i]['session_name'];
        sessionDataReq.sessionSelectedDate =
            sessionViewModel.sessionDateMilliSecond.value;
        sessionDataReq.therapyCenter = '${selectedValue}';
        sessionDataReq.createdAt = DateTime.now().millisecondsSinceEpoch;
        sessionDataReq.selectedMonth = sessionViewModel.selectedMonth;

        status = await SessionService.addSessionData(sessionDataReq);
      }

      if (status!) {
        // hideLoadingDialog(context: context);
        await SharedPreferenceUtils.setSessionId('');

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
}

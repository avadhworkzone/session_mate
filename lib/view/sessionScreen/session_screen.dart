import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/modal/add_session_data_model.dart';
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

  @override
  void initState() {
    getSessionData();
    SessionService().getTherapyDropdownCenter().then((data) {
      if (data != null) {
        setState(() {
          locationData = data;
        });
      } else {
        print('Data is null');
      }
    }).catchError((error) {
      print('Error fetching data: $error');
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
        if (!sessionViewModel.selectedSession.any(
            (element) => element['id'] == int.parse(snapshot.id.toString()))) {
          sessionViewModel.selectedSession.add({
            'id': int.parse(snapshot.id.toString()),
            'session_name': snapshot.sessionName ?? '',
          });
        }
        sessionViewModel.sessionDate.value =
            formatMilliseconds(snapshot.sessionSelectedDate ?? 0);
        sessionViewModel.isLoadingData.value = false;
        // } else {
        //   sessionViewModel.isLoadingData.value = false;
        // }
      }
    });
  }

  TherapyCenterLocationDataModel? selectedValue;
  bool isLocationNotSelected = false;
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
                                              if (!sessionViewModel
                                                  .selectedSession
                                                  .any((element) =>
                                                      element['id'] ==
                                                      sessionDataList[index]
                                                          ['id'])) {
                                                sessionViewModel.selectedSession
                                                    .add({
                                                  'id': sessionDataList[index]
                                                      ['id'],
                                                  'session_name':
                                                      sessionDataList[index]
                                                          ['session_name']
                                                });
                                              } else {
                                                sessionViewModel.selectedSession
                                                    .removeWhere((element) =>
                                                        element['id'] ==
                                                        sessionDataList[index]
                                                            ['id']);
                                              }
                                            },
                                            child: CommonSessionContainer(
                                              imageUrl: sessionDataList[index]
                                                  ['image'],
                                              titleText: sessionDataList[index]
                                                  ['session_name'],
                                              color: sessionViewModel
                                                      .selectedSession
                                                      .any((element) =>
                                                          element['id'] ==
                                                          sessionDataList[index]
                                                              ['id'])
                                                  ? AppColors.primaryColor
                                                  : Colors.transparent,
                                            ),
                                          ),
                                        ))),
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
                                    child: DropdownButton<
                                        TherapyCenterLocationDataModel>(
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
                                      items: locationData.map<
                                              DropdownMenuItem<
                                                  TherapyCenterLocationDataModel>>(
                                          (TherapyCenterLocationDataModel
                                              serviceData) {
                                        return DropdownMenuItem<
                                            TherapyCenterLocationDataModel>(
                                          value: serviceData,
                                          child: CustomText(
                                            '${serviceData.city!}, ${serviceData.state!}',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.color97,
                                          ),
                                          // label: serviceData.serviceTypeName!,
                                        );
                                      }).toList(),
                                      onChanged:
                                          (TherapyCenterLocationDataModel?
                                              serviceData) {
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
    if (sessionViewModel.sessionDate.value == 0 ||
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
        sessionDataReq.id =
            sessionViewModel.selectedSession[i]['id'].toString();
        sessionDataReq.userId = SharedPreferenceUtils.getUserId();
        sessionDataReq.sessionName =
            sessionViewModel.selectedSession[i]['session_name'];
        sessionDataReq.sessionSelectedDate =
            sessionViewModel.sessionDateMilliSecond.value;
        sessionDataReq.therapyCenter =
            '${selectedValue!.city}, ${selectedValue!.state}';
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

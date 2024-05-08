import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/modal/add_service_data_model.dart';
import 'package:session_mate/service/session_service.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/viewModel/session_view_model.dart';

class RetrieveCountDetailScreen extends StatefulWidget {
  RetrieveCountDetailScreen(
      {super.key,
      required this.sessionName,
      required this.sessionSelectedMonth});
  String sessionName;
  String sessionSelectedMonth;

  @override
  State<RetrieveCountDetailScreen> createState() =>
      _RetrieveCountDetailScreenState();
}

class _RetrieveCountDetailScreenState extends State<RetrieveCountDetailScreen> {
  SessionViewModel sessionViewModel = Get.find();
  List<AddSessionDataModel> sessionData = [];
  bool isLoadingData = false;

  @override
  void initState() {
    getSessionFilteredData();
    // TODO: implement initState
    super.initState();
  }

  getSessionFilteredData() {
    setState(() {
      isLoadingData = true;
    });
    SessionService.fetchFilteredData(
            selectedMonth: widget.sessionSelectedMonth,
            sessionName: widget.sessionName)
        .then((data) {
      if (data != null) {
        setState(() {
          sessionData = data;

          print('sessionData is a ${sessionData}');
        });
      } else {
        print('Data is null');
      }
      setState(() {
        isLoadingData = false;
      });
    }).catchError((error) {
      setState(() {
        isLoadingData = false;
      });
      print('Error fetching data: $error');
    });
    // int count = await SessionService().fetchFilteredDataCount(
    //     selectedSessionName!, sessionViewModel.monthIs.value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: isLoadingData == true
            ? const Center(child: CircularProgressIndicator())
            : Column(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          AppStrings.sessionName,
                          color: AppColors.black1c,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizeConfig.sH15,
                        CustomText(
                          widget.sessionName,
                          color: AppColors.grey88,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        Divider(),
                        SizeConfig.sH18,
                        CustomText(
                          AppStrings.count,
                          color: AppColors.black1c,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizeConfig.sH15,
                        CustomText(
                          sessionData.length.toString(),
                          color: AppColors.grey88,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        Divider(),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: sessionData.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SizeConfig.sH20,
                                  CustomText(
                                    AppStrings.therapyCenter,
                                    color: AppColors.black1c,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizeConfig.sH10,
                                  CustomText(
                                    sessionData[index].therapyCenter ?? '',
                                    color: AppColors.grey88,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Divider(),
                                  SizeConfig.sH10,
                                  CustomText(
                                    'Date & Time',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: AppColors.black1c,
                                  ),
                                  SizeConfig.sH10,
                                  Container(
                                    margin: EdgeInsets.only(left: 30.w),
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 23.w, vertical: 5.w),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomText(
                                            formatMilliseconds(
                                                sessionData[index]
                                                        .sessionSelectedDate ??
                                                    0),
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w600,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  String formatMilliseconds(int millisecondsSinceEpoch) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

    String time = DateFormat('h a').format(dateTime);

    String date = DateFormat('MM/dd/yyyy').format(dateTime);

    String formattedDateTime = '$time       $date';

    return formattedDateTime;
  }
}

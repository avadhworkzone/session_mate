import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/service/session_service.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_constant.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/homeScreen/retrieve_count_screen/retrieve_count_detail_screen.dart';
import 'package:session_mate/view/sessionScreen/common_session_container.dart';
import 'package:session_mate/viewModel/session_view_model.dart';

class RetrieveCounts extends StatefulWidget {
  const RetrieveCounts({super.key});

  @override
  State<RetrieveCounts> createState() => _RetrieveCountsState();
}

class _RetrieveCountsState extends State<RetrieveCounts> {
  SessionViewModel sessionViewModel = Get.find();

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
                                    onTap: () {},
                                    child: CommonSessionContainer(
                                      imageUrl: sessionDataList[index]['image'],
                                      titleText: sessionDataList[index]
                                          ['session_name'],
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ))),
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
                                  sessionViewModel.retrieveCountDate.value == ''
                                      ? AppStrings.calender
                                      : sessionViewModel
                                          .retrieveCountDate.value,
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
                            // int count = await SessionService()
                            //     .fetchFilteredDataCount('Special Education',
                            //         sessionViewModel.monthIs!);
                            // print('count----=......${count}');
                            Get.to(() => const RetrieveCountDetailScreen());
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

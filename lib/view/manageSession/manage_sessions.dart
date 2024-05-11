import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/common_appbar.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/commonWidget/no_data_found_widget.dart';
import 'package:session_mate/modal/add_session_data_model.dart';
import 'package:session_mate/service/session_service.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_constant.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/bottomBar/bottom_bar_screen.dart';
import 'package:session_mate/viewModel/bottom_bar_view_model.dart';

class ManageSessions extends StatefulWidget {
  const ManageSessions({super.key});

  @override
  State<ManageSessions> createState() => _ManageSessionsState();
}

List<AddSessionDataModel>? snapshotData;

class _ManageSessionsState extends State<ManageSessions> {
  BottomBarViewModel bottomBarViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          children: [
            commonAppBar(
              title: AppStrings.manageSessions,
            ),
            Expanded(
              child: StreamBuilder(
                stream: SessionService.getSessionData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return noDataFound();
                  }
                  snapshotData = snapshot.data;
                  return snapshot.data == null || snapshot.data!.isEmpty
                      ? noDataFound()
                      : ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: AppColors.white,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              elevation: 2,
                              child: ListTile(
                                title: CustomText(
                                  snapshotData![index].sessionName ?? '',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                                subtitle: CustomText(
                                    '${formatMilliseconds(snapshotData![index].sessionSelectedDate ?? 0)}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        SessionService.deleteSessionData(
                                            snapshotData![index].id ?? '');
                                      },
                                      child: const LocalAssets(
                                        imagePath: AppImageAssets.delete,
                                      ),
                                    ),
                                    SizeConfig.sW30,
                                    InkWell(
                                      onTap: () async {
                                        bottomBarViewModel
                                            .selectedBottomIndex.value = 1;
                                        await SharedPreferenceUtils
                                            .setSessionId(
                                                snapshotData![index].id ?? '');
                                        Get.to(() => const BottomBar());
                                      },
                                      child: const LocalAssets(
                                        imagePath: AppImageAssets.edit,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.w),
              child: Center(
                child: CustomBtn(
                    height: 55.h,
                    onTap: () async {
                      Get.find<BottomBarViewModel>().selectedBottomIndex.value =
                          1;
                      await SharedPreferenceUtils.setSessionId('');
                      Get.to(() => const BottomBar());
                    },
                    title: AppStrings.addsession),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

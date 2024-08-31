<<<<<<< Updated upstream
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:session_mate/commonWidget/common_appbar.dart';
import 'package:session_mate/commonWidget/common_snackbar.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/modal/therapy_center_location_data_model.dart';
import 'package:session_mate/service/session_service.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/view/manageTherapyCenters/location_permission_method.dart';
import 'package:session_mate/view/manageTherapyCenters/location_screen.dart';
import 'package:session_mate/view/manageTherapyCenters/map_screen.dart';

class ManageTherapyCenters extends StatefulWidget {
  const ManageTherapyCenters({super.key});

  @override
  State<ManageTherapyCenters> createState() => _ManageTherapyCentersState();
}

class _ManageTherapyCentersState extends State<ManageTherapyCenters> {
  List<TherapyCenterLocationDataModel>? snapshotData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          children: [
            commonAppBar(
              title: AppStrings.therapyCentres,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizeConfig.sH66,
                  // CustomText(
                  //   AppStrings.noTherapy,
                  //   color: AppColors.black34,
                  //   fontSize: 25,
                  //   fontWeight: FontWeight.w600,
                  //   textAlign: TextAlign.center,
                  // ),
                  Expanded(
                    child: StreamBuilder(
                      stream: SessionService.getTherapyCenterLocationData(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return CustomText(
                            AppStrings.noTherapy,
                            color: AppColors.black34,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                          );
                        }
                        snapshotData = snapshot.data;
                        return snapshot.data == null || snapshot.data!.isEmpty
                            ? Center(
                                child: CustomText(
                                  AppStrings.noTherapy,
                                  color: AppColors.black34,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    surfaceTintColor: AppColors.white,
                                    borderOnForeground: true,
                                    // shape: Border.all(
                                    //     color: AppColors.grey.withOpacity(0.2)),
                                    shadowColor: AppColors.grey,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    elevation: 5,
                                    child: ListTile(
                                      horizontalTitleGap: 20.w,
                                      title: CustomText(
                                        snapshotData![index].city ?? '',
                                        fontSize: 18.sp,
                                        color: AppColors.black,
                                      ),
                                      subtitle: CustomText(
                                          snapshotData![index].state ?? '',
                                          fontSize: 18.sp,
                                          color: AppColors.grey88),
                                      trailing: Padding(
                                        padding: EdgeInsets.only(right: 10.w),
                                        child: InkWell(
                                          onTap: () {
                                            SessionService
                                                .deleteTherapyCenterData(
                                                    snapshotData![index]
                                                            .locationId ??
                                                        '');
                                          },
                                          child: const LocalAssets(
                                            imagePath: AppImageAssets.delete,
                                          ),
                                        ),
                                      ),
                                      leading: Icon(
                                        Icons.location_on,
                                        color: AppColors.blue,
                                        size: 40.w,
                                      ),
                                    ),
                                  );
                                },
                              );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
                    child: CustomBtn(
                      onTap: () {
                        checkGps();
                      },
                      title: AppStrings.addTherapyCenter,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
=======
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:session_mate/commonWidget/common_appbar.dart';
import 'package:session_mate/commonWidget/common_snackbar.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/modal/therapy_center_data_model.dart';
import 'package:session_mate/modal/therapy_center_location_data_model.dart';
import 'package:session_mate/service/session_service.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/view/bottomBar/bottom_bar_screen.dart';
import 'package:session_mate/view/manageTherapyCenters/location_permission_method.dart';
import 'package:session_mate/view/manageTherapyCenters/location_screen.dart';
import 'package:session_mate/view/manageTherapyCenters/map_screen.dart';

class ManageTherapyCenters extends StatefulWidget {
  const ManageTherapyCenters({super.key});

  @override
  State<ManageTherapyCenters> createState() => _ManageTherapyCentersState();
}

class _ManageTherapyCentersState extends State<ManageTherapyCenters> {
  List<TherapyCenterDataModel>? snapshotData;
  String? role;

  @override
  void initState() {
    // TODO: implement initState
    role = SharedPreferenceUtils.getRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          children: [
            commonAppBar(
              onTap: () {
                Get.to(const BottomBar());
              },
              title: AppStrings.therapyCentres,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizeConfig.sH66,
                  // CustomText(
                  //   AppStrings.noTherapy,
                  //   color: AppColors.black34,
                  //   fontSize: 25,
                  //   fontWeight: FontWeight.w600,
                  //   textAlign: TextAlign.center,
                  // ),

              Expanded(
              child: StreamBuilder(
              stream: SessionService.getTherapyCenterLocationData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return CustomText(
                    AppStrings.noTherapy,
                    color: AppColors.black34,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  );
                }

                final snapshotData = snapshot.data;

                if (snapshotData == null || snapshotData.isEmpty) {
                  return Center(
                    child: CustomText(
                      AppStrings.noTherapy,
                      color: AppColors.black34,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                // Check if all items have isFeatchCenter set to false
                final allTherapyCentersNotFetched = snapshotData.every((center) => center.isFeatchCenter == false);

                if (allTherapyCentersNotFetched) {
                  return Center(
                    child: CustomText(
                      AppStrings.noTherapy,
                      color: AppColors.black34,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: snapshotData.length,
                  itemBuilder: (context, index) {
                    if (snapshotData[index].isFeatchCenter == false) {
                      return const SizedBox.shrink(); // Return an empty container if isFeatchCenter is false
                    }

                    return Card(
                      surfaceTintColor: AppColors.white,
                      borderOnForeground: true,
                      shadowColor: AppColors.grey,
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      elevation: 5,
                      child: ListTile(
                        horizontalTitleGap: 20.0,
                        title: CustomText(
                          snapshotData[index].therapyCenterName ?? '',
                          fontSize: 18.0,
                          color: AppColors.black,
                        ),
                        subtitle: CustomText(
                          snapshotData[index].therapyCenterCode ?? '',
                          fontSize: 18.0,
                          color: AppColors.grey88,
                        ),
                        trailing: role == AppStrings.therapist
                            ? Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: InkWell(
                            onTap: () {
                              print("Selected ID for delete:- ${snapshotData[index].id}");

                              SessionService.deleteTherapyCenterData("${snapshotData[index].id}");
                            },
                            child: const LocalAssets(
                              imagePath: AppImageAssets.delete,
                            ),
                          ),
                        )
                            : const SizedBox(),
                        leading: const Icon(
                          Icons.location_on,
                          color: AppColors.blue,
                          size: 40.0,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      ),


                  const Spacer(),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
                    child: CustomBtn(
                      onTap: () {
                        checkGps(context);
                      },
                      title: AppStrings.addTherapyCenter,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
>>>>>>> Stashed changes

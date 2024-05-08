import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/modal/therapy_center_location_data_model.dart';
import 'package:session_mate/service/session_service.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/view/sessionScreen/manageSession/location_screen.dart';
import 'package:session_mate/view/sessionScreen/manageSession/map_screen.dart';

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
                localAssets: LocalAssets(
                  imagePath: AppImageAssets.backArrow,
                  height: 23.h,
                  width: 23.w,
                ),
                title: AppStrings.therapyCentres,
                color: AppColors.black1c),
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
                      title: AppStrings.add,
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

  bool serviceStatus = false;
  late LocationPermission permission;
  bool hasPermission = false;
  // bool isLoading = false;

  checkGps() async {
    var location = await Permission.location.request();

    if (location.isPermanentlyDenied) {
      openAppSettings().then((value) async {});
    } else if (location.isGranted) {
      serviceStatus = await Geolocator.isLocationServiceEnabled();
      if (serviceStatus) {
        permission = await Geolocator.checkPermission();

        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            commonErrorSnackBar(
              message: "Location permissions are denied",
            );
          } else if (permission == LocationPermission.deniedForever) {
            commonErrorSnackBar(
              message: "Location permissions are permanently denied",
            );
          } else {
            hasPermission = true;
          }
        } else {
          hasPermission = true;
        }
        if (hasPermission) {
          location1();
        }
      } else {
        commonSnackBar(
            message: "GPS Service is not enabled, turn on GPS location");
      }
    }
  }

  Future<void> location1() async {
    var permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();
    }
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        // isLoading = true;
        Position position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high)
            .catchError((e) {
          // isLoading = false;
          print('LOCATION ERROR :=>$e');
        });
        if (position.latitude == 0 && position.longitude == 0) {
          // isLoading = false;
          requestLocationPermission();
        } else {
          // isLoading = false;
          Get.to(MapScreen(
            lat: position.latitude.toString(),
            long: position.longitude.toString(),
          ));
        }
        // await PreferenceManagerUtils.setLatitude(position.latitude);
        // await PreferenceManagerUtils.setLongitude(position.longitude);
      }
    } on Exception catch (e) {
      print('LOCATION ERROR :==>$e');
    }
  }

  Future<void> requestLocationPermission() async {
    final permissionStatus = await Permission.location.status;
    print('permissionStatus:=>$permissionStatus');
    if (await Permission.location.request().isGranted ||
        await Permission.locationWhenInUse.request().isGranted) {
      try {
        final position = await Geolocator.getCurrentPosition();
        Get.to(MapScreen(
          lat: position.latitude.toString(),
          long: position.longitude.toString(),
        ));
        // await PreferenceManagerUtils.setLatitude(position.latitude);
        // await PreferenceManagerUtils.setLongitude(position.longitude);
      } on Exception catch (e) {
        print('LOCATION ERROR :=>$e');
      }
    } else if (await Permission.location.status.isDenied) {
      if (Platform.isAndroid) {
        await Get.to(() => const LocationSettingScreen());
      } else {
        requestLocationPermission();
      }
    } else {
      if (Platform.isAndroid) {
        await Get.to(() => const LocationSettingScreen());
      } else {
        requestLocationPermission();
      }
    }
  }
}

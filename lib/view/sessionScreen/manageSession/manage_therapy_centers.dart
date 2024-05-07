import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/sessionScreen/manageSession/location_screen.dart';
import 'package:session_mate/view/sessionScreen/manageSession/map_screen.dart';

import '../../../utils/local_assets.dart';

class ManageTherapyCenters extends StatefulWidget {
  const ManageTherapyCenters({super.key});

  @override
  State<ManageTherapyCenters> createState() => _ManageTherapyCentersState();
}

class _ManageTherapyCentersState extends State<ManageTherapyCenters> {
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizeConfig.sH66,
                CustomText(
                  AppStrings.noTherapy,
                  color: AppColors.black34,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 300.h,
                ),
                CustomBtn(
                  width: 353.w,
                  onTap: () {
                    checkGps();
                  },
                  title: AppStrings.add,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  bool serviceStatus = false;
  late LocationPermission permission;
  bool hasPermission = false;

  checkGps() async {
    var location = await Permission.location.request();
    logs("LOCATION PERMISSION $location");
    if (location.isPermanentlyDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      openAppSettings().then((value) async {
        logs("STATUS vale ${value}");

        if (value == false) {
          var status = await Permission.location.request();
        }
      });
    } else if (location.isGranted) {
      serviceStatus = await Geolocator.isLocationServiceEnabled();
      if (serviceStatus) {
        permission = await Geolocator.checkPermission();

        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            // showSnackBar(
            //     message: "Location permissions are denied",
            //     snackColor: ColorUtils.red);
          } else if (permission == LocationPermission.deniedForever) {
            // showSnackBar(
            //     message: "Location permissions are permanently denied",
            //     snackColor: ColorUtils.red);
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
        logs('===========logMsg =-=---------}');
        Position position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high)
            .catchError((e) {
          print('LOCATION ERROR :=>$e');
        });

        if (position.latitude == 0 && position.longitude == 0) {
          requestLocationPermission();
        } else {
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
        logs('logMsg =-=---MapScreen------}');
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

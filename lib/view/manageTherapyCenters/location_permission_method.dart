<<<<<<< Updated upstream
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:session_mate/commonWidget/common_snackbar.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/view/manageTherapyCenters/location_screen.dart';
import 'package:session_mate/view/manageTherapyCenters/map_screen.dart';

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
        logs('LOCATION ERROR :=>$e');
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
    logs('LOCATION ERROR :==>$e');
  }
}

Future<void> requestLocationPermission() async {
  final permissionStatus = await Permission.location.status;
  logs('permissionStatus:=>$permissionStatus');
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
      logs('LOCATION ERROR :=>$e');
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
=======
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:session_mate/commonWidget/common_snackbar.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/utils/loading_dialog.dart';
import 'package:session_mate/view/manageTherapyCenters/location_screen.dart';
import 'package:session_mate/view/manageTherapyCenters/map_screen.dart';

bool serviceStatus = false;
late LocationPermission permission;
bool hasPermission = false;
// bool isLoading = false;

checkGps(BuildContext context) async {
  var location = await Permission.location.request();
  showLoadingDialog(context: context);
  if (location.isPermanentlyDenied) {
    hideLoadingDialog(context: context);
    openAppSettings().then((value) async {});
  } else if (location.isGranted) {
    serviceStatus = await Geolocator.isLocationServiceEnabled();
    if (serviceStatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        hideLoadingDialog(context: context);
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          commonErrorSnackBar(
            message: "Location permissions are denied",
          );
        } else if (permission == LocationPermission.deniedForever) {
          hideLoadingDialog(context: context);
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
        location1(context);
        // hideLoadingDialog(context: context);
      }
    } else {
      hideLoadingDialog(context: context);
      commonSnackBar(message: "GPS Service is not enabled, turn on GPS location");
    }
  }
}

Future<void> location1(BuildContext context) async {
  var permission = await Geolocator.checkPermission();
  if (permission != LocationPermission.always && permission != LocationPermission.whileInUse) {
    permission = await Geolocator.requestPermission();
  }
  try {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      // isLoading = true;
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).catchError((e) => logs('LOCATION ERROR :=>$e'));
      if (position.latitude == 0 && position.longitude == 0) {
        // isLoading = false;
        requestLocationPermission();
      } else {
        // isLoading = false;
        hideLoadingDialog(context: context);
        print("Current Lattitude :- ${position.latitude}");
        print("Current longitude :- ${position.longitude}");
        Get.to(MapScreen(
          lat: position.latitude.toString(),
          long: position.longitude.toString(),
        ));
      }
      // await PreferenceManagerUtils.setLatitude(position.latitude);
      // await PreferenceManagerUtils.setLongitude(position.longitude);
    }
  } on Exception catch (e) {
    logs('LOCATION ERROR :==>$e');
  }
}

Future<void> requestLocationPermission() async {

  final permissionStatus = await Permission.location.status;
  logs('permissionStatus:=>$permissionStatus');
  if (await Permission.location.request().isGranted || await Permission.locationWhenInUse.request().isGranted) {
    try {
      final position = await Geolocator.getCurrentPosition();
      Get.to(MapScreen(
        lat: position.latitude.toString(),
        long: position.longitude.toString(),
      ));
      // await PreferenceManagerUtils.setLatitude(position.latitude);
      // await PreferenceManagerUtils.setLongitude(position.longitude);
    } on Exception catch (e) {
      logs('LOCATION ERROR :=>$e');
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
>>>>>>> Stashed changes

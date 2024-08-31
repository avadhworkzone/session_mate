import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/view/manageTherapyCenters/map_screen.dart';

class LocationSettingScreen extends StatefulWidget {
  const LocationSettingScreen({Key? key}) : super(key: key);

  @override
  State<LocationSettingScreen> createState() => _LocationSettingScreenState();
}

class _LocationSettingScreenState extends State<LocationSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.blue,
          title: const Text(
            "Location",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 30,
                  child: Icon(
                    Icons.location_on_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Use Your Location",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Our App is location driven. Please allow location access to serve you better.",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: settingBtnOnTap,
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                        child: Text(
                      "setting",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> settingBtnOnTap() async {
    if (Platform.isAndroid) {
      final locationStatus = await Permission.location.request().isGranted;
      final locationWhenInUseStatus =
          await Permission.locationWhenInUse.request().isGranted;

      logs('locationStatus:=>$locationStatus ');
      if (!locationStatus && !locationWhenInUseStatus) {
        openAppSettings();
        return;
      }
    } else {
      final locationStatus = await Permission.location.request().isGranted;
      final locationWhenInUseStatus =
          await Permission.locationWhenInUse.request().isGranted;
      logs(
          'locationStatus:=>$locationStatus locationWhenInUseStatus:=>$locationWhenInUseStatus');
      if (!locationStatus && !locationWhenInUseStatus) {
        openAppSettings();
        return;
      }
    }
    final position = await Geolocator.getCurrentPosition();
    logs('LOCATION :=>${position.latitude}');
    Get.to(MapScreen(
      lat: position.latitude.toString(),
      long: position.longitude.toString(),
    ));
    // await PreferenceManagerUtils.setLatitude(position.latitude);
    // await PreferenceManagerUtils.setLongitude(position.longitude);
    Get.back();
  }
}

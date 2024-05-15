import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:session_mate/utils/collection_utils.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:worldtime/worldtime.dart';

class HomeViewModel extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  final worldtimePlugin = Worldtime();
  bool isFreeTrial = true;
  GlobalKey<ScaffoldState> homeDrawerKey = GlobalKey();

  /// CHECK USER SUBSCRIPTION
  Future<void> checkSubscription() async {
    String data = SharedPreferenceUtils.getUserDetail();
    var userDetailSnapshot = jsonDecode(data);
    var userDetail = userDetailSnapshot;
    final DateTime currentDate = await worldtimePlugin.timeByLocation(
      latitude: double.parse(userDetail?["latitude"]),
      longitude: double.parse(userDetail?["longitude"]),
    );
    SharedPreferenceUtils.setCurrentDate(
        "${currentDate.year}-${currentDate.month < 10 ? "0${currentDate.month}" : "${currentDate.month}"}-${currentDate.day < 10 ? "0${currentDate.day}" : "${currentDate.day}"}");
    DateTime subscriptionEndDate = DateTime.parse(userDetail?["subscriptionEndDate"]);
    if (subscriptionEndDate.isAfter(currentDate)) {
      CollectionUtils.userCollection
          .doc(SharedPreferenceUtils.getUserId())
          .update({"isSubscription": true}).then((value) {
        SharedPreferenceUtils.setIsSubscription(true);
        isFreeTrial = true;
        update(["freeTrial"]);
        print("isSubscription ======>>>>${SharedPreferenceUtils.getIsSubscription()}<<<<");
      });
    } else {
      CollectionUtils.userCollection
          .doc(SharedPreferenceUtils.getUserId())
          .update({"isSubscription": false}).then((value) {
        SharedPreferenceUtils.setIsSubscription(false);

        ///CHECK 14 DAYS FREE TRIAL
        DateTime currentDate = DateTime.parse(SharedPreferenceUtils.getCurrentDate());
        DateTime registrationDate =
            DateTime.parse("2024-05-30" /*userDetail?["registrationDate"]*/);
        print(
            "Difference days from registration >>>> ${currentDate.difference(registrationDate).inDays}");
        if (registrationDate.difference(currentDate).inDays > 14) {
          isFreeTrial = false;
          update(["freeTrial"]);
        }
        print("isSubscription ======>>>>${SharedPreferenceUtils.getIsSubscription()}<<<<");
      });
    }
  }
}

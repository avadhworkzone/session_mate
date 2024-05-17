import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:session_mate/utils/collection_utils.dart';
import 'package:session_mate/utils/loading_dialog.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:worldtime/worldtime.dart';

class HomeViewModel extends GetxController {
  final worldtimePlugin = Worldtime();
  bool isFreeTrial = true;
  GlobalKey<ScaffoldState> homeDrawerKey = GlobalKey();

  /// CHECK USER SUBSCRIPTION
  Future<void> checkSubscription(BuildContext context) async {
    showLoadingDialog(context: context);
    String data = SharedPreferenceUtils.getUserDetail();
    var userDetailSnapshot = jsonDecode(data);
    var userDetail = userDetailSnapshot;
    CollectionUtils.userCollection
        .doc(SharedPreferenceUtils.getUserId())
        .snapshots()
        .listen((event) {
      userDetail = event.data();
    });
    final DateTime currentDate = await worldtimePlugin.timeByLocation(
      latitude: double.parse(userDetail?["latitude"]),
      longitude: double.parse(userDetail?["longitude"]),
    );
    SharedPreferenceUtils.setCurrentDate(
        "${currentDate.year}-${currentDate.month < 10 ? "0${currentDate.month}" : "${currentDate.month}"}-${currentDate.day < 10 ? "0${currentDate.day}" : "${currentDate.day}"}");
    DateTime subscriptionEndDate =
        DateTime.parse(userDetail?["subscriptionEndDate"]);
    if (subscriptionEndDate.isAfter(currentDate)) {
      CollectionUtils.userCollection
          .doc(SharedPreferenceUtils.getUserId())
          .update({"isSubscription": true}).then((value) {
        SharedPreferenceUtils.setIsSubscription(true);
        isFreeTrial = true;
        hideLoadingDialog(context: context);
        update(["freeTrial"]);
        print(
            "isSubscription ======>>>>${SharedPreferenceUtils.getIsSubscription()}<<<<");
      });
    } else {
      CollectionUtils.userCollection
          .doc(SharedPreferenceUtils.getUserId())
          .update({"isSubscription": false}).then((value) {
        SharedPreferenceUtils.setIsSubscription(false);

        ///CHECK 14 DAYS FREE TRIAL
        DateTime currentDate = DateTime.parse(
            "2024-05-30" /*SharedPreferenceUtils.getCurrentDate()*/);
        DateTime registrationDate =
            DateTime.parse(userDetail?["registrationDate"]);
        print(
            "Difference days from registration >>>> ${currentDate.difference(registrationDate).inDays}");
        hideLoadingDialog(context: context);
        if (currentDate.difference(registrationDate).inDays > 14) {
          isFreeTrial = false;
          update(["freeTrial"]);
        }
        print(
            "isSubscription ======>>>>${SharedPreferenceUtils.getIsSubscription()}<<<<");
      });
    }
  }
}

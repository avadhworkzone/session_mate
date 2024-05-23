import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/collection_utils.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:worldtime/worldtime.dart';

class HomeViewModel extends GetxController {
  final worldtimePlugin = Worldtime();
  Rx<bool> isFreeTrial = true.obs;
  List<Map<String, dynamic>> therapyPlanData = [];
  List<Map<String, dynamic>> currentTherapyPlanData = [];
  // GlobalKey<ScaffoldState> homeDrawerKey = GlobalKey();
  Rx<bool> checkSubscriptionLoader = false.obs;
  RxList<String> homeImageList = [
    AppImageAssets.addNewSession,
    AppImageAssets.retriveCount,
    AppImageAssets.therapyPlan
  ].obs;

  /// CHECK USER SUBSCRIPTION
  Future<void> checkSubscription(BuildContext context) async {
    // showLoadingDialog(context: context);
    checkSubscriptionLoader.value = true;
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
        isFreeTrial.value = true;
        checkSubscriptionLoader.value = false;
        // hideLoadingDialog(context: context);
        // update(["freeTrial"]);
        print(
            "isSubscription ======>>>>${SharedPreferenceUtils.getIsSubscription()}<<<<");
      });
    } else {
      CollectionUtils.userCollection
          .doc(SharedPreferenceUtils.getUserId())
          .update({"isSubscription": false}).then((value) {
        SharedPreferenceUtils.setIsSubscription(false);

        ///CHECK 14 DAYS FREE TRIAL
        DateTime currentDate =
            DateTime.parse(SharedPreferenceUtils.getCurrentDate());

        ///SharedPreferenceUtils.getCurrentDate()
        DateTime registrationDate =
            DateTime.parse(userDetail?["registrationDate"]);
        print(
            "Difference days from registration >>>> ${currentDate.difference(registrationDate).inDays}");
        // hideLoadingDialog(context: context);
        checkSubscriptionLoader.value = false;
        if (currentDate.difference(registrationDate).inDays > 14) {
          isFreeTrial.value = false;
          // update(["freeTrial"]);
        }
        print(
            "isSubscription ======>>>>${SharedPreferenceUtils.getIsSubscription()}<<<<");
      });
    }
  }

  Future<void> getTherapyPlanData() async {
    QuerySnapshot<Map<String, dynamic>> therapyDataSnapshot =
        await CollectionUtils.userTherapyDataCollection.get();
    therapyPlanData.clear();
    currentTherapyPlanData.clear();
    for (var element in therapyDataSnapshot.docs) {
      therapyPlanData.add(element.data());
    }
    for (var element in therapyPlanData) {
      for (var userName in element['UserName']) {
        print(element['UserName'].length);
        if (userName['mobile_number'] == SharedPreferenceUtils.getUserId()) {
          currentTherapyPlanData.add(element);
        }
      }
    }
    // print(therapyPlanData);
  }
}

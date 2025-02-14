import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:session_mate/utils/collection_utils.dart';
import 'package:session_mate/utils/loading_dialog.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/view/homeScreen/home_screen.dart';
import 'package:session_mate/view/profile_screen.dart';
import 'package:session_mate/view/sessionScreen/session_screen.dart';
import 'package:session_mate/view/setting_screen/setting_screen.dart';
import 'package:session_mate/view/subScriptionScreen/subScription_screen.dart';
import 'package:worldtime/worldtime.dart';

class BottomBarViewModel extends GetxController {
  Rx<int> selectedBottomIndex = 0.obs;
  RxList screenList = [
    const HomeScreen(),
    const SessionScreen(),
    SettingScreen(),
    SubscriptionsScreen(),
    // const SettingScreen(),
    // const WelcomeScreen(),
    // const WelcomeScreen(),
    // const WelcomeScreen(),
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }
}

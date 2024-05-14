import 'package:get/get.dart';
import 'package:session_mate/utils/collection_utils.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/view/homeScreen/home_screen.dart';
import 'package:session_mate/view/profile_screen.dart';
import 'package:session_mate/view/sessionScreen/session_screen.dart';
import 'package:session_mate/view/subScriptionScreen/subScription_screen.dart';
import 'package:worldtime/worldtime.dart';

class BottomBarViewModel extends GetxController {
  final worldtimePlugin = Worldtime();
  bool isFreeTrial = true;

  @override
  void onInit() {
    checkSubscription();
    super.onInit();
  }

  /// CHECK USER SUBSCRIPTION
  Future<void> checkSubscription() async {
    var userDetailSnapshot =
        await CollectionUtils.userCollection.doc(SharedPreferenceUtils.getUserId()).get();
    var userDetail = userDetailSnapshot.data();
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
        print("isSubscription ======>>>>${SharedPreferenceUtils.getIsSubscription()}<<<<");
      });
    } else {
      CollectionUtils.userCollection
          .doc(SharedPreferenceUtils.getUserId())
          .update({"isSubscription": false}).then((value) {
        SharedPreferenceUtils.setIsSubscription(false);
        checkIsFreeTrial();
        print("isSubscription ======>>>>${SharedPreferenceUtils.getIsSubscription()}<<<<");
      });
    }
  }

  ///CHECK 14 DAYS FREE TRIAL
  Future<void> checkIsFreeTrial() async {
    var userDetailSnapshot =
        await CollectionUtils.userCollection.doc(SharedPreferenceUtils.getUserId()).get();
    var userDetail = userDetailSnapshot.data();
    DateTime currentDate = DateTime.parse(SharedPreferenceUtils.getCurrentDate());
    DateTime registrationDate = DateTime.parse(userDetail?["registrationDate"]);
    if (currentDate.difference(registrationDate).inDays > 14) {
      isFreeTrial = false;
    }
  }

  Rx<int> selectedBottomIndex = 0.obs;
  RxList screenList = [
    const HomeScreen(),
    const SessionScreen(),
    const ProfileScreen(),
    const SubscriptionsScreen(),
    // const SettingScreen(),
    // const WelcomeScreen(),
    // const WelcomeScreen(),
    // const WelcomeScreen(),
  ].obs;
}

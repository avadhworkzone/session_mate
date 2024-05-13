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

  @override
  void onInit() {
    checkSubscription();
    super.onInit();
  }

  Future<void> checkSubscription() async {
    /// CHECK USER SUBSCRIPTION
    var userDetailSnapshot =
        await CollectionUtils.userCollection.doc(SharedPreferenceUtils.getUserId()).get();
    var userDetail = userDetailSnapshot.data();
    final DateTime timeAmsterdamGeo = await worldtimePlugin.timeByLocation(
      latitude: double.parse(userDetail?["latitude"]),
      longitude: double.parse(userDetail?["longitude"]),
    );
    DateTime subscriptionEndDate = DateTime.parse(userDetail?["subscriptionEndDate"]);
    if (subscriptionEndDate.isAfter(timeAmsterdamGeo)) {
      CollectionUtils.userCollection
          .doc(SharedPreferenceUtils.getUserId())
          .update({"isSubscription": true});
      SharedPreferenceUtils.setIsSubscription(true);
      print("isSubscription ======>>>>${SharedPreferenceUtils.getIsSubscription()}<<<<");
    } else {
      CollectionUtils.userCollection
          .doc(SharedPreferenceUtils.getUserId())
          .update({"isSubscription": false});
      SharedPreferenceUtils.setIsSubscription(false);
      print("isSubscription ======>>>>${SharedPreferenceUtils.getIsSubscription()}<<<<");
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

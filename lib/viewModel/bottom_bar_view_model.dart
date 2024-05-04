import 'package:get/get.dart';
import 'package:session_mate/view/homeScreen/home_screen.dart';
import 'package:session_mate/view/profile_screen.dart';
import 'package:session_mate/view/sessionScreen/session_screen.dart';
import 'package:session_mate/view/subScriptionScreen/subScription_screen.dart';

class BottomBarViewModel extends GetxController {
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

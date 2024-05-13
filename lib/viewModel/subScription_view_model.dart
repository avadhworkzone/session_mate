import 'package:get/get.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/collection_utils.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/view/auth/sign_in_screen.dart';
import 'package:session_mate/view/welcomeScreen/welcome_screen.dart';
import 'package:worldtime/worldtime.dart';

class SubscriptionViewModel extends GetxController {
  final worldtimePlugin = Worldtime();

  List carouselItem = [
    {
      "title": AppStrings.freeCapital,
      "title2": "",
      "firstColor": AppColors.white,
      "secondColor": AppColors.white,
      "thirdColor": AppColors.white,
      "fourthColor": AppColors.colorA2,
      "fifthColor": AppColors.colorA2,
    },
    {
      "title": AppStrings.monthly,
      "title2": AppStrings.inrTenMonth,
      "firstColor": AppColors.white,
      "secondColor": AppColors.white,
      "thirdColor": AppColors.colorA2,
      "fourthColor": AppColors.colorA2,
      "fifthColor": AppColors.colorA2,
    },
    {
      "title": AppStrings.yearly,
      "title2": AppStrings.inr100Year,
      "firstColor": AppColors.colorA2,
      "secondColor": AppColors.colorA2,
      "thirdColor": AppColors.colorA2,
      "fourthColor": AppColors.colorA2,
      "fifthColor": AppColors.colorA2,
    },
  ];

  Future<void> buyBtnTap(int index) async {
    var userDetailSnapshot =
        await CollectionUtils.userCollection.doc(SharedPreferenceUtils.getUserId()).get();
    var userDetail = userDetailSnapshot.data();
    final DateTime currentDateTime = await worldtimePlugin.timeByLocation(
      latitude: double.parse(userDetail?["latitude"]),
      longitude: double.parse(userDetail?["longitude"]),
    );
    if (index == 1) {
      if (userDetail?["isSubscription"]) {
        Get.snackbar("Message",
            "You have already purchased ${userDetail?["subscriptionType"]} subscription valid till '${userDetail?["subscriptionEndDate"]}'");
      } else {
        String subscriptionStartDate =
            "${currentDateTime.year}-${currentDateTime.month < 10 ? "0${currentDateTime.month}" : "${currentDateTime.month}"}-${currentDateTime.day < 10 ? "0${currentDateTime.day}" : "${currentDateTime.day}"}";
        String subscriptionEndDate =
            "${currentDateTime.year}-${currentDateTime.month + 1 < 10 ? "0${currentDateTime.month + 1}" : "${currentDateTime.month + 1}"}-${currentDateTime.day < 10 ? "0${currentDateTime.day}" : "${currentDateTime.day}"}";
        CollectionUtils.userCollection.doc(SharedPreferenceUtils.getUserId()).update({
          "subscriptionStartDate": subscriptionStartDate,
          "subscriptionEndDate": subscriptionEndDate,
          "subscriptionType": AppStrings.monthlySubscription,
          "isSubscription": true,
        }).then((value) => Get.snackbar("Message", AppStrings.monthlySubscriptionSuccess));
      }
    } else if (index == 2) {
      if (userDetail?["isSubscription"]) {
        Get.snackbar("Message",
            "You have already purchased ${userDetail?["subscriptionType"]} subscription valid till '${userDetail?["subscriptionEndDate"]}'");
      } else {
        String subscriptionStartDate =
            "${currentDateTime.year}-${currentDateTime.month < 10 ? "0${currentDateTime.month}" : "${currentDateTime.month}"}-${currentDateTime.day < 10 ? "0${currentDateTime.day}" : "${currentDateTime.day}"}";
        String subscriptionEndDate =
            "${currentDateTime.year + 1}-${currentDateTime.month < 10 ? "0${currentDateTime.month}" : "${currentDateTime.month}"}-${currentDateTime.day < 10 ? "0${currentDateTime.day}" : "${currentDateTime.day}"}";
        CollectionUtils.userCollection.doc(SharedPreferenceUtils.getUserId()).update({
          "subscriptionStartDate": subscriptionStartDate,
          "subscriptionEndDate": subscriptionEndDate,
          "subscriptionType": AppStrings.yearlySubscription,
          "isSubscription": true,
        }).then((value) => Get.snackbar("Message", AppStrings.yearlySubscriptionSuccess));
      }
    } else {
      SharedPreferenceUtils.clearPreference();
      Get.offAll(() => const WelcomeScreen());
    }
  }
}

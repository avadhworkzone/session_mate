import 'package:get/get.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/collection_utils.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/view/submitted_successfully_screen/submitted_successfully_screen.dart';

class SubscriptionViewModel extends GetxController {
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

  void buyBtnTap(int index) {
    if (index == 1) {
      print(SharedPreferenceUtils.getUserId());
      String subscriptionStartDate =
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
      String subscriptionEndDate =
          "${DateTime.now().year}-${DateTime.now().month + 1}-${DateTime.now().day}";
      CollectionUtils.userCollection.doc(SharedPreferenceUtils.getUserId()).update({
        "subscriptionStartDate": subscriptionStartDate,
        "subscriptionEndDate": subscriptionEndDate,
        "subscriptionType": AppStrings.monthlySubscription,
        "isSubscription": true,
      });
    } else if (index == 2) {
      print(SharedPreferenceUtils.getUserId());
      String subscriptionStartDate =
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
      String subscriptionEndDate =
          "${DateTime.now().year + 1}-${DateTime.now().month}-${DateTime.now().day}";
      CollectionUtils.userCollection.doc(SharedPreferenceUtils.getUserId()).update({
        "subscriptionStartDate": subscriptionStartDate,
        "subscriptionEndDate": subscriptionEndDate,
        "subscriptionType": AppStrings.yearlySubscription,
        "isSubscription": true,
      });
    } else {
      Get.to(() => const SubmittedSuccessfully());
    }
  }
}

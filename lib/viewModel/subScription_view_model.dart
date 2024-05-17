import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:session_mate/service/razorpay_service.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/collection_utils.dart';
import 'package:session_mate/utils/loading_dialog.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/view/auth/sign_in_screen.dart';
import 'package:session_mate/view/welcomeScreen/welcome_screen.dart';
import 'package:worldtime/worldtime.dart';

class SubscriptionViewModel extends GetxController {
  final worldtimePlugin = Worldtime();
  bool isLogin = false;

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

  Future<void> buyBtnTap(int index, BuildContext context) async {
    showLoadingDialog(context: context);
    var userDetailSnapshot =
        await CollectionUtils.userCollection.doc(SharedPreferenceUtils.getUserId()).get();
    var userDetail = userDetailSnapshot.data();
    final DateTime currentDateTime = await worldtimePlugin.timeByLocation(
      latitude: double.parse(userDetail?["latitude"]),
      longitude: double.parse(userDetail?["longitude"]),
    );
    if (index == 1) {
      if (userDetail?["isSubscription"]) {
        hideLoadingDialog(context: context);
        Get.snackbar("Message",
            "You have already purchased ${userDetail?["subscriptionType"]} subscription valid till '${userDetail?["subscriptionEndDate"]}'");
      } else {
        RazorpayService.context = context;
        RazorpayService.isMonthly = true;
        RazorpayService.makePaymentWithRazorPay(amount: 49);
      }
    } else if (index == 2) {
      if (userDetail?["isSubscription"]) {
        hideLoadingDialog(context: context);
        Get.snackbar("Message",
            "You have already purchased ${userDetail?["subscriptionType"]} subscription valid till '${userDetail?["subscriptionEndDate"]}'");
      } else {
        RazorpayService.context = context;
        RazorpayService.isMonthly = false;
        RazorpayService.makePaymentWithRazorPay(amount: 449);
      }
    } else {
      SharedPreferenceUtils.clearPreference();
      hideLoadingDialog(context: context);
      Get.offAll(() => const WelcomeScreen());
    }
  }
}

import 'dart:convert';

import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/collection_utils.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:worldtime/worldtime.dart';

class RazorpayService {
  static final worldtimePlugin = Worldtime();
  static late Razorpay razorpay;
  static bool isMonthly = false;

  static makePaymentWithRazorPay({required int amount}) {
    print("amount >>>>>>>>>>>>> $amount");
    var options = {
      'key': 'rzp_test_BLGsdJ6y7LBA6D',
      'amount': amount * 100,
      'name': 'Acme Corp.',
      'description': amount * 100 == 4900 ? 'Monthly Subscription' : 'Yearly Subscription',
      "timeout": "180",
      "currency": "INR",
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
    };
    initiateRazorPay();
    razorpay.open(options);
  }

  static void initiateRazorPay() {
    razorpay = Razorpay();

    /// To handle different event with previous functions
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  static Future<void> handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("PaymentSuccessResponse <><><><><><><><><> ${response.data}");
    var userDetailSnapshot =
        await CollectionUtils.userCollection.doc(SharedPreferenceUtils.getUserId()).get();
    var userDetail = userDetailSnapshot.data();
    final DateTime currentDateTime = await worldtimePlugin.timeByLocation(
      latitude: double.parse(userDetail?["latitude"]),
      longitude: double.parse(userDetail?["longitude"]),
    );
    if (isMonthly) {
      String subscriptionStartDate =
          "${currentDateTime.year}-${currentDateTime.month < 10 ? "0${currentDateTime.month}" : "${currentDateTime.month}"}-${currentDateTime.day < 10 ? "0${currentDateTime.day}" : "${currentDateTime.day}"}";
      String subscriptionEndDate =
          "${currentDateTime.year}-${currentDateTime.month + 1 < 10 ? "0${currentDateTime.month + 1}" : "${currentDateTime.month + 1}"}-${currentDateTime.day < 10 ? "0${currentDateTime.day}" : "${currentDateTime.day}"}";
      CollectionUtils.userCollection.doc(SharedPreferenceUtils.getUserId()).update({
        "subscriptionStartDate": subscriptionStartDate,
        "subscriptionEndDate": subscriptionEndDate,
        "subscriptionType": AppStrings.monthlySubscription,
        "isSubscription": true,
      }).then((value) {
        CollectionUtils.userCollection.doc(SharedPreferenceUtils.getUserId()).get().then((value) {
          SharedPreferenceUtils.setUserDetail(jsonEncode(value.data()));
          Get.snackbar("Message", AppStrings.monthlySubscriptionSuccess);
        });
      });
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
      }).then((value) {
        CollectionUtils.userCollection.doc(SharedPreferenceUtils.getUserId()).get().then((value) {
          SharedPreferenceUtils.setUserDetail(jsonEncode(value.data()));
          Get.snackbar("Message", AppStrings.yearlySubscriptionSuccess);
        });
      });
    }
  }

  static void handlePaymentError(PaymentFailureResponse response) {
    print("PaymentFailureResponse <><><><><><><><><> ${response.error}");
    Get.snackbar("Error", response.error!["description"], isDismissible: false);
  }

  static void handleExternalWallet(ExternalWalletResponse response) {
    print("ExternalWalletResponse <><><><><><><><><> ${response.walletName}");
  }
}

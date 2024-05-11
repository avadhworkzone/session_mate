import 'package:get/get.dart';
import 'package:session_mate/general/connectivity_wrapper.dart';
import 'package:session_mate/view/payment_screen1/payment_screen1.dart';

class InternetErrorViewModel extends GetxController {
  void goSettingBtnTap() {
    // navigate(view: PaymentScreen1());
    Get.to(() => const PaymentScreen1());
  }
}

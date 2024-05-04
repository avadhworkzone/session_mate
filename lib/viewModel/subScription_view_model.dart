import 'package:get/get.dart';
import 'package:session_mate/general/connectivity_wrapper.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_string.dart';
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

  void buyBtnTap(int index){
    navigate(view: SubmittedSuccessfully());
    // Get.to(()=> const SubmittedSuccessfully());
  }

}

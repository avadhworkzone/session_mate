import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:session_mate/utils/app_colors.dart';

class SessionViewModel extends GetxController {
  /// ADD SESSION SCREEN
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<String> sessionDate = ''.obs;
  RxInt sessionSelect = RxInt(-1);
  RxList<Map<String, dynamic>> selectedSession = <Map<String, dynamic>>[].obs;
  RxBool isLoadingData = false.obs;

  /// DATE PICKER
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme:
                const ColorScheme.light(primary: AppColors.primaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate.value) {
      String formatDate = "${picked.month}/${picked.day}/${picked.year}";
      sessionDate.value = formatDate;
    }
    // isSelected.value = true;
  }

  /// RETRIEVE COUNT SCREEN
  Rx<String> retrieveCountDate = ''.obs;
  Rx<DateTime> retrieveCountSelectedDate = DateTime.now().obs;
  DateTime? pickedMonth;
  int? monthIs;

  /// MONTH PICKER
  Future<void> selectMonth(BuildContext context) async {
    pickedMonth = await showMonthPicker(
      context: context,
      initialDate: retrieveCountSelectedDate.value,
      backgroundColor: AppColors.white,
      headerColor: AppColors.white,
      selectedMonthBackgroundColor: AppColors.primaryColor,
      currentMonthTextColor: AppColors.white,
      headerTextColor: AppColors.black,
      unselectedMonthTextColor: AppColors.black1c,
    );
    if (pickedMonth != null && pickedMonth != retrieveCountSelectedDate.value) {
      monthIs = pickedMonth!.month;
    }
  }

  /// SESSION COUNT SCREEN
  Rx<TextEditingController> sessionNameTextEditingController =
      TextEditingController().obs;
}

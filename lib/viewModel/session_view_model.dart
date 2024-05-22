import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:session_mate/modal/therapy_center_location_data_model.dart';
import 'package:session_mate/utils/app_colors.dart';

class SessionViewModel extends GetxController {
  /// ADD SESSION SCREEN
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<String> sessionDate = ''.obs;
  Rx<int> sessionDateMilliSecond = 0.obs;
  RxInt sessionSelect = RxInt(-1);
  RxList<Map<String, dynamic>> selectedSession = <Map<String, dynamic>>[].obs;
  RxBool isLoadingData = false.obs;
  Rx<bool> isLocationNotSelected = false.obs;
  String? selectedMonth;
  DateTime? combinedDateTime;

  /// DATE PICKER
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
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

    if (pickedDate != null && pickedDate != selectedDate.value) {
      // int formatDate = picked.millisecondsSinceEpoch;

      ///"${picked.month}/${picked.day}/${picked.year}";
      sessionDate.value =
          "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(sessionDateMilliSecond.value);
      selectedMonth = DateFormat('MMMM').format(pickedDate);
      print('selectedMonth${selectedMonth}');

      final TimeOfDay? pickedTime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (pickedTime != null) {
        combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      } else {
        combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          TimeOfDay.now().hour,
          TimeOfDay.now().minute,
        );
      }

      sessionDateMilliSecond.value = combinedDateTime!.millisecondsSinceEpoch;
    }
  }

  /// RETRIEVE COUNT SCREEN
  Rx<String> retrieveCountDate = ''.obs;
  Rx<DateTime> retrieveCountSelectedDate = DateTime.now().obs;
  Rx<String> retrieveCountMonthIs = ''.obs;

  /// MONTH PICKER
  Future<void> selectMonth(BuildContext context) async {
    DateTime? pickedMonth = await showMonthPicker(
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
      retrieveCountMonthIs.value = DateFormat('MMMM').format(pickedMonth);
    }
  }

  /// GET THERAPY CENTER DROP DOWN DATA
  // RxList<TherapyCenterLocationDataModel> therapyCenterListData =
  //     <TherapyCenterLocationDataModel>[].obs;
  // Rx<TherapyCenterLocationDataModel?> therapyCenterData =
  //     Rx<TherapyCenterLocationDataModel?>(null);
  // Rx<TherapyCenterLocationDataModel?> therapyCenterData =
  //     Rx<TherapyCenterLocationDataModel?>(null);
}

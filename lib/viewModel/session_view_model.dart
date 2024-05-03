import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:session_mate/utils/app_colors.dart';

class SessionViewModel extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<bool> isSelected = false.obs;
  Rx<String> date = ''.obs;
  RxInt sessionSelect = RxInt(-1);
  RxString sessionName = ''.obs;

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
      date.value = formatDate;
    }
    isSelected.value = true;
  }
}

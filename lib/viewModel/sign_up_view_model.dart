import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:session_mate/utils/app_colors.dart';

class SignUpViewModel extends GetxController {
  Rx<TextEditingController> signUpEmailController = TextEditingController().obs;
  Rx<TextEditingController> signUpUserNameController =
      TextEditingController().obs;
  Rx<TextEditingController> signUpPhoneNoController =
      TextEditingController().obs;
  Rx<TextEditingController> signUpPasswordController =
      TextEditingController().obs;
  Rx<TextEditingController> signUpConfirmPasswordController =
      TextEditingController().obs;
  Rx<TextEditingController> therapyCenterCodeController =
      TextEditingController().obs;

  Rx<TextEditingController> dateOfBirthController = TextEditingController().obs;
  final Rx<GlobalKey<FormState>> signUpFormKey = GlobalKey<FormState>().obs;
  RxString signUpCountryCode = '91'.obs;
  RxBool signUpShowPass = false.obs;
  RxBool signUpShowConPass = false.obs;
  RxBool signUpPhoneIsValidate = false.obs;
  RxBool isPrivacyAndTermsChecked = false.obs;
  RxBool isReadOnly = true.obs;
  Rx<String> roleVal = "".obs;
  Rx<DateTime> signUpSelectedDate = DateTime.now().obs;

  /// DATE PICKER
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: signUpSelectedDate.value,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime.now(),
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
        });

    if (picked != null && picked != signUpSelectedDate.value) {
      String date = "${picked.month}/${picked.day}/${picked.year}";
      dateOfBirthController.value.text = date;
    }
  }

  void dropDownChange(val) {
    roleVal.value = val ?? "";
    isReadOnly.value = false;
  }
}

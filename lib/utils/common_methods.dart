import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'local_assets.dart';

///SHOW APP LOGS
logs(String logMsg) {
  if (kDebugMode) {
    log(logMsg);
  }
}

///UN FOCUS KEYBOARD
unFocus() {
  FocusManager.instance.primaryFocus?.unfocus();
}

///CAPITALIZE TEXT
commonCapitalize(String value) {
  return value.capitalizeFirst;
}

//
// ///COMMON CHECKBOX
// commonCheckBox({onChanged, value}) {
//   return Transform.scale(
//     scale: 1.5,
//     child: Checkbox(
//         checkColor: AppColors.white,
//         fillColor: MaterialStateProperty.resolveWith<Color>(
//           (Set<MaterialState> states) {
//             if (states.contains(MaterialState.selected)) {
//               return AppColors.pink; // Color when checked
//             }
//             return AppColors.white; // Color when unchecked
//           },
//         ),
//         side: BorderSide(color: AppColors.grey),
//         value: value,
//         onChanged: onChanged),
//   );
// }

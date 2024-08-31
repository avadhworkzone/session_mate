import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:session_mate/commonWidget/custom_text.dart';

Widget noDataFound() {
  return Center(
      child: CustomText(
    'No Data Found',
    fontSize: 20.w,
  ));
}

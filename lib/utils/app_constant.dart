import 'dart:core';
import 'package:flutter/material.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';

class AppConstants {
  static const String baseImageAssetsPath = "assets/images/";
  static const String baseIconAssetsPath = "assets/icons/";

  static const String inter = "Inter";
}

List<String> homeImageList = [
  AppImageAssets.addNewSession,
  AppImageAssets.retriveCount,
  AppImageAssets.therapyPlan
];

List<String> homeTitle = [
  AppStrings.addsession,
  AppStrings.retrieveCounts,
  AppStrings.therepyPlan
];

List<String> homeSubtitle = [
  AppStrings.searchforbranch,
  AppStrings.searchForinterestRate,
  AppStrings.searchForExchangeRate
];

List<Map<String, dynamic>> sessionDataList = [
  {
    'id': 0,
    'image': AppImageAssets.specialEducationIcn,
    'session_name': AppStrings.specialEducation
  },
  {
    'id': 1,
    'image': AppImageAssets.occupationalTherapyIcn,
    'session_name': AppStrings.occupationalTherapy,
  },
  {
    'id': 2,
    'image': AppImageAssets.sportIcn,
    'session_name': AppStrings.sports
  },
  {
    'id': 3,
    'image': AppImageAssets.speechIcn,
    'session_name': AppStrings.speech
  },
  {
    'id': 4,
    'image': AppImageAssets.musicIcn,
    'session_name': AppStrings.music,
  }
];

String formatMilliseconds(int millisecondsSinceEpoch) {
  DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  String formattedDate = '${dateTime.month.toString().padLeft(2, '0')}/'
      '${dateTime.day.toString().padLeft(2, '0')}/'
      '${dateTime.year.toString()}';
  return formattedDate;
}

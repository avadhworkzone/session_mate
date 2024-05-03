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
    'image': AppImageAssets.specialEducationIcn,
    'session_name': AppStrings.specialEducation
  },
  {
    'image': AppImageAssets.occupationalTherapyIcn,
    'session_name': AppStrings.occupationalTherapy,
  },
  {'image': AppImageAssets.sportIcn, 'session_name': AppStrings.sports},
  {'image': AppImageAssets.speechIcn, 'session_name': AppStrings.speech},
  {
    'image': AppImageAssets.musicIcn,
    'session_name': AppStrings.music,
  }
];

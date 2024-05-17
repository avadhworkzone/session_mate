import 'dart:core';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';

class AppConstants {
  static const String baseImageAssetsPath = "assets/images/";
  static const String baseIconAssetsPath = "assets/icons/";

  static const String inter = "Inter";
  static const String poppins = "Poppins";
  static const String openSans = "Open Sans";
}

class CombinedData {
  final String category;
  final String subCategory;
  final String currentLevel;
  final String plannedStrategies;

  CombinedData({
    required this.category,
    required this.subCategory,
    required this.currentLevel,
    required this.plannedStrategies,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = category;
    data['subCategory'] = subCategory;
    data['currentLevel'] = currentLevel;
    data['plannedStrategies'] = plannedStrategies;
    return data;
  }
}

List<String> homeImageList = [
  AppImageAssets.addNewSession,
  AppImageAssets.retriveCount,
  AppImageAssets.therapyPlan
];

List<String> homeTitle = [AppStrings.addsession, AppStrings.retrieveCounts, AppStrings.therepyPlan];

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
  {'id': 2, 'image': AppImageAssets.sportIcn, 'session_name': AppStrings.sports},
  {'id': 3, 'image': AppImageAssets.speechIcn, 'session_name': AppStrings.speech},
  {
    'id': 4,
    'image': AppImageAssets.musicIcn,
    'session_name': AppStrings.music,
  }
];

String formatMilliseconds(int millisecondsSinceEpoch) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  String formattedDate = '${dateTime.month.toString().padLeft(2, '0')}/'
      '${dateTime.day.toString().padLeft(2, '0')}/'
      '${dateTime.year.toString()}';
  return formattedDate;
}

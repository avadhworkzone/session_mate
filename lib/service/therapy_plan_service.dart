import 'package:session_mate/modal/age_group_level_model.dart';
import 'package:session_mate/modal/current_level_model.dart';
import 'package:session_mate/modal/get_session_list_model.dart';
import 'package:session_mate/modal/goal_category_model.dart';
import 'package:session_mate/modal/goal_sub_category_model.dart';
import 'package:session_mate/modal/strategies_data_model.dart';
import 'package:session_mate/utils/collection_utils.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/utils/const_utils.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';

class TherapyPlanService {
  /// GET SESSION LIST FOR DROP DOWN
  Future<List<SessionListData>> getSessionList() async {
    try {
      final snapshot = await CollectionUtils.session.get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return SessionListData.fromJson(data);
        }).toList();
      } else {
        return []; // Return an empty list if no data found
      }
    } catch (e) {
      logs('get session list error :=>$e');
      throw e;
    }
  }

  /// GET AGE GROUP LEVEL
  Future<List<AgeGroupLevelModel>> getAgeGroupLevelList() async {
    try {
      final snapshot = await CollectionUtils.ageGroupLevel
          .where('sessionId',
              isEqualTo: SharedPreferenceUtils.getTherapyPlanSessionId())
          .get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return AgeGroupLevelModel.fromJson(data);
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      logs('get age group level error :=>$e');
      throw e;
    }
  }

  /// GET GOALS CATEGORY DATA
  Future<List<GoalCategoryModel>> getGoalsCategoryData(
      {required String ageLevelId}) async {
    try {
      final snapshot = await CollectionUtils.goalCategoryCollection
          .where('sessionId',
              isEqualTo: SharedPreferenceUtils.getTherapyPlanSessionId())
          .where('ageLevelId', isEqualTo: ageLevelId)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          logs('data-----${data}');
          return GoalCategoryModel.fromJson(data);
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      logs('get goal category error :=>$e');
      throw e;
    }
  }

  /// GET GOALS SUB CATEGORY DATA
  Future<List<GoalSubCategoryModel>> getGoalSubCategoryData(
      {required List<String?> goalIds}) async {
    try {
      List<GoalSubCategoryModel> subCategories = [];
      for (String? goalId in goalIds) {
        final snapshot = await CollectionUtils.goalSubCategoryCollection
            .where('goalId', isEqualTo: goalId)
            .get();
        if (snapshot.docs.isNotEmpty) {
          subCategories.addAll(snapshot.docs.map((doc) {
            final data = doc.data();
            return GoalSubCategoryModel.fromJson(data);
          }));
          logs('subCategories fngf fgjrtng jrtbgbn b${subCategories}');
        }
      }
      return subCategories;
    } catch (e) {
      logs('get goal sub category error :=>$e');
      throw e;
    }
  }

  /// GET CURRENT LEVEL
  Future<List<CurrentLevelModel>> currentLevelList() async {
    try {
      final snapshot = await CollectionUtils.currentLevelCollection.get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return CurrentLevelModel.fromJson(data);
        }).toList();
      } else {
        return []; // Return an empty list if no data found
      }
    } catch (e) {
      logs('get current level list error :=>$e');
      throw e;
    }
  }

  /// GET STRATEGIES DATA
  Future<List<StrategiesModel>> getStrategiesData(
      {required List<String?> goalIds}) async {
    try {
      List<StrategiesModel> strategies = [];
      for (String? goalId in goalIds) {
        final snapshot = await CollectionUtils.strategiesCollection
            .where('goalId', isEqualTo: goalId)
            .get();
        if (snapshot.docs.isNotEmpty) {
          strategies.addAll(snapshot.docs.map((doc) {
            final data = doc.data();
            return StrategiesModel.fromJson(data);
          }));
        }
      }
      return strategies;
    } catch (e) {
      logs('get goal strategies error :=>$e');
      throw e;
    }
  }
}

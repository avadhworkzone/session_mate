import 'package:session_mate/modal/age_group_level_model.dart';
import 'package:session_mate/modal/get_session_list_model.dart';
import 'package:session_mate/modal/goal_category_model.dart';
import 'package:session_mate/modal/goal_sub_category_model.dart';
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
      {required String goalId}) async {
    try {
      final snapshot = await CollectionUtils.goalCategoryCollection
          .where('goalId', isEqualTo: goalId)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) {
          final data = doc.data();

          return GoalSubCategoryModel.fromJson(data);
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      logs('get goal sub category error :=>$e');
      throw e;
    }
  }
}

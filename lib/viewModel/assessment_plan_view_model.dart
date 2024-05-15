import 'package:get/get.dart';
import 'package:session_mate/modal/age_group_level_model.dart';
import 'package:session_mate/modal/current_level_model.dart';
import 'package:session_mate/modal/get_session_list_model.dart';
import 'package:session_mate/modal/goal_category_model.dart';

class AssessmentAndPlanViewModel extends GetxController {
  /// get session list
  RxList<SessionListData> sessionListData = <SessionListData>[].obs;
  Rx<SessionListData?> sessionData = Rx<SessionListData?>(null);

  /// age group level
  RxList<AgeGroupLevelModel> childAgeLevelListData = <AgeGroupLevelModel>[].obs;
  Rx<AgeGroupLevelModel?> ageGroupData = Rx<AgeGroupLevelModel?>(null);

  /// get goal category
  RxList<GoalData> goalListData = <GoalData>[].obs;
  RxList<dynamic> goalSelectedList = [].obs;
  Rx<bool> goalExpanded = false.obs;

  /// get goal sub category
  RxList<Map<String, dynamic>> goalSubCategoryStringData =
      <Map<String, dynamic>>[].obs;
  RxList<dynamic> subGoalSelectedList = [].obs;
  Rx<bool> subGoalExpanded = false.obs;

  /// get current level data
  RxList<CurrentLevelModel> currentLevelListData = <CurrentLevelModel>[].obs;
  RxList<dynamic> currentLevelSelectedList = [].obs;
  Rx<bool> currentLevelExpanded = false.obs;

  /// get strategies data
  RxList<Map<String, dynamic>> strategiesStringData =
      <Map<String, dynamic>>[].obs;
  RxList<dynamic> strategiesSelectedList = [].obs;
  Rx<bool> strategiesExpanded = false.obs;
}

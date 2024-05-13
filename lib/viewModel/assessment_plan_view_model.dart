import 'package:get/get.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:session_mate/modal/age_group_level_model.dart';
import 'package:session_mate/modal/get_session_list_model.dart';
import 'package:session_mate/modal/goal_category_model.dart';
import 'package:session_mate/modal/goal_sub_category_model.dart';

class AssessmentAndPlanViewModel extends GetxController {
  /// get session list
  RxList<SessionListData> sessionListData = <SessionListData>[].obs;
  Rx<SessionListData?> sessionData = Rx<SessionListData?>(null);

  /// age group level
  RxList<AgeGroupLevelModel> childAgeLevelListData = <AgeGroupLevelModel>[].obs;
  Rx<AgeGroupLevelModel?> ageGroupData = Rx<AgeGroupLevelModel?>(null);

  /// get goal category
  // RxList<GoalCategoryModel> goalCategoryListData = <GoalCategoryModel>[].obs;
  RxList<GoalData> goalListData = <GoalData>[].obs;
  Rx<MultiSelectController<GoalData>> controller =
      MultiSelectController<GoalData>().obs;
  Rx<bool> isGoalLoading = false.obs;
  Rx<bool> isIgnoring = false.obs;
  // Rx<GoalData?> goalData = Rx<GoalData?>(null);

  /// get goal sub category

  RxList<String> goalSubCategoryStringData = <String>[].obs;

  Rx<bool> isGoalSubLoading = false.obs;
}

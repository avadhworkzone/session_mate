import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/common_appbar.dart';
import 'package:session_mate/commonWidget/common_snackbar.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/modal/age_group_level_model.dart';
import 'package:session_mate/modal/get_session_list_model.dart';
import 'package:session_mate/modal/goal_category_model.dart';
import 'package:session_mate/modal/goal_sub_category_model.dart';
import 'package:session_mate/service/session_service.dart';
import 'package:session_mate/service/therapy_plan_service.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_constant.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/utils/const_utils.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/viewModel/assessment_plan_view_model.dart';

class AssessmentAndPlanScreen extends StatefulWidget {
  const AssessmentAndPlanScreen({super.key});

  @override
  State<AssessmentAndPlanScreen> createState() =>
      _AssessmentAndPlanScreenState();
}

class _AssessmentAndPlanScreenState extends State<AssessmentAndPlanScreen> {
  AssessmentAndPlanViewModel assessmentAndPlanViewModel =
      Get.put(AssessmentAndPlanViewModel());
  // SessionListData? sessionData;

  @override
  void initState() {
    getSessionList();
    // TODO: implement initState
    super.initState();
  }

  getSessionList() {
    TherapyPlanService().getSessionList().then((sessionData) {
      if (sessionData != []) {
        assessmentAndPlanViewModel.sessionListData.value = sessionData;
      } else {
        assessmentAndPlanViewModel.sessionListData.value = [];
      }
    }).catchError((error) {
      logs('Error fetching session list data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor),
        leading: const SizedBox(),
        leadingWidth: 0,
      ),
      body: Obx(
        () => Column(
          children: [
            commonAppBar(
                title: AppStrings.assessmentAndPlan,
                iconColor: AppColors.white,
                textColor: AppColors.white),
            SizeConfig.sH40,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  /// CHILD AGE GROUP
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: Colors.grey),
                          color: AppColors.white),
                      child: TapRegion(
                        onTapInside: (val) {
                          if (assessmentAndPlanViewModel.sessionData.value ==
                              null) {
                            commonSnackBar(
                                message: 'Please Select Session',
                                snackBackgroundColor: AppColors.white,
                                textColor: AppColors.primaryColor);
                          }
                        },
                        child: DropdownButton<AgeGroupLevelModel>(
                          value: assessmentAndPlanViewModel.sessionData.value ==
                                  null
                              ? null
                              : assessmentAndPlanViewModel.ageGroupData.value,
                          isExpanded: true,
                          underline: const SizedBox(),
                          iconEnabledColor: AppColors.color09,
                          iconDisabledColor: AppColors.color09,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          hint: CustomText(
                            AppStrings.childAgeGroup,
                            fontWeight: FontWeight.w300,
                            fontSize: 16.sp,
                            color: AppColors.black,
                          ),
                          onChanged: (AgeGroupLevelModel? newValue) {
                            assessmentAndPlanViewModel.ageGroupData.value =
                                null;
                            assessmentAndPlanViewModel.ageGroupData.value =
                                newValue!;
                            TherapyPlanService()
                                .getGoalsCategoryData(
                                    ageLevelId: assessmentAndPlanViewModel
                                            .ageGroupData.value!.id ??
                                        '')
                                .then((goalData) {
                              if (goalData.isNotEmpty) {
                                assessmentAndPlanViewModel
                                    .goalCategoryListData.value = goalData;

                                assessmentAndPlanViewModel.goalCategoryListData
                                    .forEach((element) {
                                  assessmentAndPlanViewModel
                                      .goalListData.value = element.goal!;
                                });
                                logs(
                                    'assessmentAndPlanViewModel=-==----->>${jsonEncode(assessmentAndPlanViewModel.goalCategoryListData)}');
                              } else {
                                assessmentAndPlanViewModel
                                    .goalCategoryListData.value = [];
                              }
                            }).catchError((error) {
                              logs('Error goalData list data: $error');
                            });
                          },
                          items: assessmentAndPlanViewModel
                              .childAgeLevelListData
                              .map<DropdownMenuItem<AgeGroupLevelModel>>(
                                  (AgeGroupLevelModel ageGroupLevel) =>
                                      DropdownMenuItem<AgeGroupLevelModel>(
                                        value: ageGroupLevel,
                                        child: CustomText(ageGroupLevel.level!),
                                      ))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  SizeConfig.sW15,

                  /// SESSION
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: Colors.grey),
                          color: AppColors.white),
                      child: DropdownButton<SessionListData>(
                        value: assessmentAndPlanViewModel.sessionData.value,
                        isExpanded: true,
                        underline: const SizedBox(),
                        iconEnabledColor: AppColors.color97,
                        iconDisabledColor: AppColors.color97,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        // const LocalAssets(
                        //     imagePath: AppImageAssets.dropDownArrowIcn),
                        hint: CustomText(
                          AppStrings.session,
                          fontWeight: FontWeight.w300,
                          fontSize: 17.sp,
                          color: AppColors.black,
                        ),
                        onChanged: (SessionListData? newValue) async {
                          assessmentAndPlanViewModel.sessionData.value =
                              newValue!;
                          await SharedPreferenceUtils.setTherapyPlanSessionId(
                              assessmentAndPlanViewModel
                                      .sessionData.value!.id ??
                                  '');
                          TherapyPlanService()
                              .getAgeGroupLevelList()
                              .then((ageGroupData) {
                            if (ageGroupData != []) {
                              assessmentAndPlanViewModel
                                  .childAgeLevelListData.value = [];
                              assessmentAndPlanViewModel.ageGroupData.value =
                                  null;
                              assessmentAndPlanViewModel
                                  .childAgeLevelListData.value = ageGroupData;
                            } else {
                              assessmentAndPlanViewModel
                                  .childAgeLevelListData.value = [];
                              assessmentAndPlanViewModel.ageGroupData.value =
                                  null;
                            }
                          }).catchError((error) {
                            logs(
                                'Error fetching age group level list data: $error');
                          });
                        },
                        items: assessmentAndPlanViewModel.sessionListData
                            .map<DropdownMenuItem<SessionListData>>(
                                (SessionListData sessionData) =>
                                    DropdownMenuItem<SessionListData>(
                                      value: sessionData,
                                      child: CustomText(
                                          sessionData.sessionName ?? ''),
                                    ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizeConfig.sH40,
            Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 25.w),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: Colors.grey),
                  color: AppColors.white),
              child: Column(
                children: [
                  /// SELECT YOUR GOAL
                  DropdownMenu<GoalData>(
                    width: Get.width / 1.2,
                    textStyle:
                        TextStyle(fontSize: 14.sp, color: AppColors.black1c),
                    trailingIcon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30.sp,
                      color: AppColors.primaryColor,
                    ),
                    initialSelection: assessmentAndPlanViewModel.goalData.value,
                    // controller: languageEditController,
                    requestFocusOnTap: false,
                    onSelected: (GoalData? newValue) {
                      unFocus();
                      assessmentAndPlanViewModel.goalData.value = newValue!;
                      TherapyPlanService()
                          .getGoalSubCategoryData(
                              goalId: assessmentAndPlanViewModel
                                  .goalData.value!.goalId!)
                          .then((goalSubCategory) {
                        if (goalSubCategory != []) {
                          assessmentAndPlanViewModel
                              .goalSubCategoryListData.value = goalSubCategory;
                        } else {
                          assessmentAndPlanViewModel
                              .goalSubCategoryListData.value = [];
                          assessmentAndPlanViewModel.goalSubCategoryData.value =
                              null;
                        }
                      }).catchError((error) {
                        logs(
                            'Error fetching age group level list data: $error');
                      });
                    },
                    hintText: AppStrings.selectYourGoal,
                    menuHeight: Get.height / 4,
                    inputDecorationTheme: InputDecorationTheme(
                        fillColor: AppColors.white,
                        filled: true,
                        isDense: true,
                        hintStyle: TextStyle(
                          color: AppColors.black1c,
                          fontSize: 14.sp,
                        ),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.colorA2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: AppColors.colorA2)),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: AppColors.colorA2),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: AppColors.colorA2),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            color: AppColors.colorA2,
                            width: 1.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.w)),
                    dropdownMenuEntries: assessmentAndPlanViewModel
                        .goalListData.value
                        .map<DropdownMenuEntry<GoalData>>((GoalData goalData) {
                      return DropdownMenuEntry<GoalData>(
                        value: goalData,
                        label: goalData.goalName!,
                      );
                    }).toList(),
                  ),

                  SizeConfig.sH20,

                  /// SELECT YOUR SUB GOAL
                  DropdownMenu<String>(
                    width: Get.width / 1.2,
                    textStyle:
                        TextStyle(fontSize: 14.sp, color: AppColors.black1c),
                    trailingIcon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30.sp,
                      color: AppColors.primaryColor,
                    ),
                    initialSelection:
                        assessmentAndPlanViewModel.goalSubCategoryData.value,
                    // controller: languageEditController,
                    requestFocusOnTap: false,
                    onSelected: (String? newValue) {
                      unFocus();
                      assessmentAndPlanViewModel.goalSubCategoryData.value =
                          newValue!;
                    },
                    hintText: AppStrings.selectYourSubGoal,
                    menuHeight: Get.height / 4,
                    inputDecorationTheme: InputDecorationTheme(
                        fillColor: AppColors.white,
                        filled: true,
                        isDense: true,
                        hintStyle: TextStyle(
                          color: AppColors.black1c,
                          fontSize: 14.sp,
                        ),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.colorA2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: AppColors.colorA2)),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: AppColors.colorA2),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: AppColors.colorA2),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            color: AppColors.colorA2,
                            width: 1.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.w)),
                    dropdownMenuEntries: assessmentAndPlanViewModel
                        .goalSubCategoryListData.value
                        .map<DropdownMenuEntry<String>>(
                            (GoalSubCategoryModel goalData) {
                      return DropdownMenuEntry<String>(
                        value: goalData.subGoal![0],
                        label: goalData.subGoal![0],
                      );
                    }).toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List sessionData1 = [
    AppStrings.specialEducation,
    AppStrings.occupationalTherapy,
    AppStrings.sports,
    AppStrings.speech,
    AppStrings.music
  ];

  final List<CourseData> courseList = [
    CourseData(
      title: AppStrings.selectYourGoal,
      description: 'Lorem ipsum dolor sit amet consectetur. ',
    ),
    CourseData(
      title: AppStrings.selectYourSubGoal,
      description: 'Lorem ipsum dolor sit amet consectetur.',
    ),
    CourseData(
      title: AppStrings.selectYourCurrentLevel,
      description: 'Lorem ipsum dolor sit amet consectetur. ',
    ),
    CourseData(
      title: AppStrings.selectYourStrategies,
      description: 'Lorem ipsum dolor sit amet consectetur. ',
    ),
  ];

  List strategies = [
    'Encourage eye contact and joint attention',
    'Respond to their name being called.',
    'Use gestures or simple words to communicate needs and wants.',
    'Explore and engage with a variety of sensory stimuli.',
    'Develop self-regulation strategies to manage sensory overload.',
    'Joint attention activities: Encourage the child to follow your gaze and point to objects of interest.',
    'Responsive interaction: Respond to the child is attempts at communication with enthusiasm and reinforcement.',
    'Sensory play: Provide a variety of sensory experiences, such as water play, sand, textures, and sensory toys.',
    'Visual schedules: Use pictures or objects to create a simple daily routine to help the child anticipate activities.',
    'Social stories: Read stories that promote social skills, such as turn-taking and sharing.',
    'Interactive games like peek-a-boo, and reading simple picture books.',
    'Gesture games, hand-on-hand guidance to teach actions like clapping.',
    'Use daily routines to point and show objects of interest.',
  ];
  List<Map<String, dynamic>> data = [
    {
      'Goal Category': 'Develop pre-verbal communication skills',
      'Goal Subcategory': [
        'Encourage eye contact and joint attention',
        'Respond to their name being called.',
        'Use gestures or simple words to communicate needs and wants.',
        'Explore and engage with a variety of sensory stimuli.',
        'Develop self-regulation strategies to manage sensory overload.',
      ],
      'Strategies': [
        'Joint attention activities: Encourage the child to follow your gaze and point to objects of interest.',
        'Responsive interaction: Respond to the child is attempts at communication with enthusiasm and reinforcement.',
        'Sensory play: Provide a variety of sensory experiences, such as water play, sand, textures, and sensory toys.',
        'Visual schedules: Use pictures or objects to create a simple daily routine to help the child anticipate activities.',
        'Social stories: Read stories that promote social skills, such as turn-taking and sharing.',
        'Interactive games like peek-a-boo, and reading simple picture books.',
        'Gesture games, hand-on-hand guidance to teach actions like clapping.',
        'Use daily routines to point and show objects of interest.',
      ]
    },
    {
      'Goal Category': 'Increase receptive language skills',
      'Goal Subcategory': [
        'Respond to simple commands',
        'Identify common objects',
      ],
      'Strategies': [
        'Play "Simon Says" with basic instructions like "clap your hands"',
        'Create a picture book with familiar items and practice naming them',
        'Use clear, concise language and pair words with gestures',
        'Use real objects and pictures to teach vocabulary',
      ]
    }
  ];
}

class CourseData {
  final String title;
  final String description;

  CourseData({
    required this.title,
    required this.description,
  });
}

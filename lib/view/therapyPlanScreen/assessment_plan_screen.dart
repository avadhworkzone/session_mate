import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/common_appbar.dart';
import 'package:session_mate/commonWidget/common_snackbar.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/modal/age_group_level_model.dart';
import 'package:session_mate/modal/get_session_list_model.dart';
import 'package:session_mate/service/therapy_plan_service.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/common_methods.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/therapyPlanScreen/therapy_plan_screen.dart';
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

  List<String?> selectedGoalIds = [];
  bool strategiesExpanded = false;

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
    TherapyPlanService().currentLevelList().then((currentLevelData) {
      if (currentLevelData != []) {
        assessmentAndPlanViewModel.currentLevelListData.value =
            currentLevelData;
      } else {
        assessmentAndPlanViewModel.currentLevelListData.value = [];
      }
    }).catchError((error) {
      logs('Error fetching current level list data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Get.width / 3.2, vertical: 20),
        child: CustomBtn(
          radius: 12,
          onTap: () {
            Get.to(() => const TherapyPlan());
          },
          bgColor: AppColors.whiteF5,
          title: AppStrings.submit,
          textColor: AppColors.colorA2,
        ),
      ),
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
            SizeConfig.sH30,
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
                                message: AppStrings.selectYourSession,
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
                            assessmentAndPlanViewModel.goalExpanded.value =
                                false;
                            assessmentAndPlanViewModel.goalSelectedList.clear();
                            assessmentAndPlanViewModel.goalListData.value
                                .clear();
                            assessmentAndPlanViewModel.subGoalSelectedList
                                .clear();
                            assessmentAndPlanViewModel.goalSubCategoryStringData
                                .clear();
                            assessmentAndPlanViewModel.strategiesSelectedList
                                .clear();
                            assessmentAndPlanViewModel.strategiesStringData
                                .clear();
                            selectedGoalIds.clear();
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
                                goalData.forEach((element) {
                                  assessmentAndPlanViewModel
                                      .goalListData.value = element.goal!;
                                });
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
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.black1c,
                        ),
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
            SizeConfig.sH20,

            // /// CHILD AGE
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20.w),
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 12.w),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(4.r),
            //         border: Border.all(color: Colors.grey),
            //         color: AppColors.white),
            //     child: DropdownButton<String>(
            //       value: assessmentAndPlanViewModel.childSelectedAge.value,
            //       isExpanded: true,
            //       underline: const SizedBox(),
            //       iconEnabledColor: AppColors.color97,
            //       iconDisabledColor: AppColors.color97,
            //       icon: const Icon(
            //         Icons.keyboard_arrow_down,
            //         color: AppColors.black1c,
            //       ),
            //       hint: CustomText(
            //         AppStrings.childAge,
            //         fontWeight: FontWeight.w300,
            //         fontSize: 17.sp,
            //         color: AppColors.black,
            //       ),
            //       onChanged: (String? newValue) async {
            //         assessmentAndPlanViewModel.childSelectedAge.value =
            //             newValue!;
            //       },
            //       items: assessmentAndPlanViewModel.childAge
            //           .map<DropdownMenuItem<String>>(
            //               (String sessionData) => DropdownMenuItem<String>(
            //                     value: sessionData,
            //                     child: CustomText(sessionData),
            //                   ))
            //           .toList(),
            //     ),
            //   ),
            // ),
            // SizeConfig.sH20,

            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: Get.width,
                  padding:
                      EdgeInsets.symmetric(vertical: 25.w, horizontal: 15.w),
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: Colors.grey),
                      color: AppColors.white),
                  child: Column(
                    children: [
                      /// SELECT YOUR GOAL
                      InkWell(
                        onTap: () {
                          if (assessmentAndPlanViewModel
                              .goalSelectedList.value.isEmpty) {
                            if (assessmentAndPlanViewModel.goalExpanded.value ==
                                true) {
                              assessmentAndPlanViewModel.goalExpanded.value =
                                  false;
                            } else {
                              assessmentAndPlanViewModel.goalExpanded.value =
                                  true;
                            }
                          } else {
                            assessmentAndPlanViewModel.goalExpanded.value =
                                true;
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: AppColors.grey, spreadRadius: 1)
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: assessmentAndPlanViewModel
                                            .goalSelectedList.value.isEmpty
                                        ? CustomText(
                                            AppStrings.selectYourGoal,
                                            fontSize: 17.sp,
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                                assessmentAndPlanViewModel
                                                    .goalSelectedList.length,
                                                (index) => CustomText(
                                                    '${assessmentAndPlanViewModel.goalSelectedList[index]['name']}${assessmentAndPlanViewModel.goalSelectedList.length > 1 ? ',' : ''}')),
                                          )),
                              ),
                              const Icon(Icons.keyboard_arrow_down_sharp)
                            ],
                          ),
                        ),
                      ),
                      SizeConfig.sH10,
                      assessmentAndPlanViewModel.goalExpanded.value == false
                          ? const SizedBox()
                          : Container(
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color:
                                          AppColors.black1c.withOpacity(0.1))),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      assessmentAndPlanViewModel
                                          .goalListData.value.length, (index) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  if (assessmentAndPlanViewModel
                                                          .goalListData
                                                          .value[index]
                                                          .status ==
                                                      true) {
                                                    assessmentAndPlanViewModel
                                                        .goalListData
                                                        .value[index]
                                                        .status = false;
                                                    assessmentAndPlanViewModel
                                                        .goalSelectedList
                                                        .removeWhere((element) =>
                                                            element['id'] ==
                                                            assessmentAndPlanViewModel
                                                                .goalListData
                                                                .value[index]
                                                                .goalId);
                                                    selectedGoalIds.remove(
                                                        assessmentAndPlanViewModel
                                                            .goalListData
                                                            .value[index]
                                                            .goalId);
                                                  } else {
                                                    assessmentAndPlanViewModel
                                                        .goalListData
                                                        .value[index]
                                                        .status = true;
                                                    assessmentAndPlanViewModel
                                                        .goalSelectedList
                                                        .add({
                                                      'id':
                                                          assessmentAndPlanViewModel
                                                              .goalListData
                                                              .value[index]
                                                              .goalId,
                                                      'name':
                                                          assessmentAndPlanViewModel
                                                              .goalListData
                                                              .value[index]
                                                              .goalName
                                                    });
                                                    if (assessmentAndPlanViewModel
                                                            .ageGroupData
                                                            .value!
                                                            .level !=
                                                        '0 to 3 years') {
                                                      selectedGoalIds.clear();
                                                      selectedGoalIds.add(
                                                          assessmentAndPlanViewModel
                                                              .goalListData
                                                              .value[index]
                                                              .goalId);
                                                    } else {
                                                      selectedGoalIds.add(
                                                          assessmentAndPlanViewModel
                                                              .goalListData
                                                              .value[index]
                                                              .goalId);
                                                    }
                                                  }
                                                  // assessmentAndPlanViewModel.goalListData
                                                  //             .value[index].status ==
                                                  //         true
                                                  //     ? assessmentAndPlanViewModel
                                                  //         .goalListData
                                                  //         .value[index]
                                                  //         .status = false
                                                  //     : assessmentAndPlanViewModel
                                                  //         .goalListData
                                                  //         .value[index]
                                                  //         .status = true;
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CustomText(
                                                      assessmentAndPlanViewModel
                                                          .goalListData
                                                          .value[index]
                                                          .goalName!),
                                                ),
                                              ),
                                            ),
                                            Checkbox(
                                                value:
                                                    assessmentAndPlanViewModel
                                                            .goalListData
                                                            .value[index]
                                                            .status ??
                                                        false,
                                                onChanged: (val) {
                                                  if (assessmentAndPlanViewModel
                                                          .goalListData
                                                          .value[index]
                                                          .status ==
                                                      true) {
                                                    assessmentAndPlanViewModel
                                                        .goalListData
                                                        .value[index]
                                                        .status = false;
                                                    assessmentAndPlanViewModel
                                                        .goalSelectedList
                                                        .removeWhere((element) =>
                                                            element['id'] ==
                                                            assessmentAndPlanViewModel
                                                                .goalListData
                                                                .value[index]
                                                                .goalId);
                                                    selectedGoalIds.remove(
                                                        assessmentAndPlanViewModel
                                                            .goalListData
                                                            .value[index]
                                                            .goalId);
                                                  } else {
                                                    assessmentAndPlanViewModel
                                                        .goalListData
                                                        .value[index]
                                                        .status = true;
                                                    assessmentAndPlanViewModel
                                                        .goalSelectedList
                                                        .add({
                                                      'id':
                                                          assessmentAndPlanViewModel
                                                              .goalListData
                                                              .value[index]
                                                              .goalId,
                                                      'name':
                                                          assessmentAndPlanViewModel
                                                              .goalListData
                                                              .value[index]
                                                              .goalName
                                                    });
                                                    selectedGoalIds.add(
                                                        assessmentAndPlanViewModel
                                                            .goalListData
                                                            .value[index]
                                                            .goalId);
                                                  }
                                                })
                                          ],
                                        ),
                                        index ==
                                                assessmentAndPlanViewModel
                                                        .goalListData
                                                        .value
                                                        .length -
                                                    1
                                            ? Padding(
                                                padding: EdgeInsets.all(20.w),
                                                child: CustomBtn(
                                                    onTap: () {
                                                      assessmentAndPlanViewModel
                                                          .goalExpanded
                                                          .value = false;
                                                      assessmentAndPlanViewModel
                                                          .goalSubCategoryStringData
                                                          .value
                                                          .clear();
                                                      assessmentAndPlanViewModel
                                                          .subGoalSelectedList
                                                          .value
                                                          .clear();

                                                      /// GOAL SUB CATEGORY
                                                      TherapyPlanService()
                                                          .getGoalSubCategoryData(
                                                              goalIds:
                                                                  selectedGoalIds)
                                                          .then(
                                                              (subCategories) {
                                                        subCategories
                                                            .forEach((element) {
                                                          element.subGoal!
                                                              .forEach(
                                                                  (element) {
                                                            assessmentAndPlanViewModel
                                                                .goalSubCategoryStringData
                                                                .value
                                                                .add({
                                                              'status': false,
                                                              'name': element
                                                            });
                                                          });
                                                        });
                                                      }).catchError((error) {
                                                        // Handle errors
                                                      });

                                                      /// GOAL STRATEGIES
                                                      TherapyPlanService()
                                                          .getStrategiesData(
                                                              goalIds:
                                                                  selectedGoalIds)
                                                          .then((strategies) {
                                                        assessmentAndPlanViewModel
                                                            .strategiesStringData
                                                            .value
                                                            .clear();
                                                        strategies
                                                            .forEach((element) {
                                                          element.strategies!
                                                              .forEach(
                                                                  (element) {
                                                            assessmentAndPlanViewModel
                                                                .strategiesStringData
                                                                .value
                                                                .add({
                                                              'status': false,
                                                              'name': element
                                                            });
                                                          });
                                                        });
                                                      }).catchError((error) {
                                                        // Handle errors
                                                      });
                                                    },
                                                    title: 'Done'),
                                              )
                                            : const SizedBox()
                                      ],
                                    );
                                  }))),

                      SizeConfig.sH20,

                      /// SELECT YOUR SUB GOAL
                      InkWell(
                        onTap: () {
                          if (assessmentAndPlanViewModel
                              .subGoalSelectedList.value.isEmpty) {
                            if (assessmentAndPlanViewModel
                                    .subGoalExpanded.value ==
                                true) {
                              assessmentAndPlanViewModel.subGoalExpanded.value =
                                  false;
                            } else {
                              assessmentAndPlanViewModel.subGoalExpanded.value =
                                  true;
                            }
                          } else {
                            assessmentAndPlanViewModel.subGoalExpanded.value =
                                true;
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: AppColors.grey, spreadRadius: 1)
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: assessmentAndPlanViewModel
                                            .subGoalSelectedList.value.isEmpty
                                        ? CustomText(
                                            AppStrings.selectYourSubGoal,
                                            fontSize: 17.sp,
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                                assessmentAndPlanViewModel
                                                    .subGoalSelectedList.length,
                                                (index) => Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5.w),
                                                      child: CustomText(
                                                          maxLines: 2,
                                                          '${assessmentAndPlanViewModel.subGoalSelectedList[index]['name']}${assessmentAndPlanViewModel.subGoalSelectedList.length > 1 ? ',' : ''}'),
                                                    )),
                                          )),
                              ),
                              const Icon(Icons.keyboard_arrow_down_sharp)
                            ],
                          ),
                        ),
                      ),
                      SizeConfig.sH10,
                      assessmentAndPlanViewModel.subGoalExpanded.value == false
                          ? const SizedBox()
                          : Container(
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color:
                                          AppColors.black1c.withOpacity(0.1))),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      assessmentAndPlanViewModel
                                          .goalSubCategoryStringData
                                          .value
                                          .length, (index) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  if (assessmentAndPlanViewModel
                                                          .goalSubCategoryStringData
                                                          .value[index]['status'] ==
                                                      true) {
                                                    assessmentAndPlanViewModel
                                                            .goalSubCategoryStringData
                                                            .value[index]
                                                        ['status'] = false;
                                                    assessmentAndPlanViewModel
                                                        .subGoalSelectedList
                                                        .removeWhere((element) =>
                                                            element['name'] ==
                                                            assessmentAndPlanViewModel
                                                                    .goalSubCategoryStringData
                                                                    .value[
                                                                index]['name']);
                                                  } else {
                                                    assessmentAndPlanViewModel
                                                            .goalSubCategoryStringData
                                                            .value[index]
                                                        ['status'] = true;
                                                    assessmentAndPlanViewModel
                                                        .subGoalSelectedList
                                                        .add({
                                                      'name': assessmentAndPlanViewModel
                                                          .goalSubCategoryStringData
                                                          .value[index]['name']
                                                    });
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CustomText(
                                                      assessmentAndPlanViewModel
                                                          .goalSubCategoryStringData
                                                          .value[index]['name']),
                                                ),
                                              ),
                                            ),
                                            Checkbox(
                                                value: assessmentAndPlanViewModel
                                                        .goalSubCategoryStringData
                                                        .value[index]['status'] ??
                                                    false,
                                                onChanged: (val) {
                                                  if (assessmentAndPlanViewModel
                                                          .goalSubCategoryStringData
                                                          .value[index]['status'] ==
                                                      true) {
                                                    assessmentAndPlanViewModel
                                                            .goalSubCategoryStringData
                                                            .value[index]
                                                        ['status'] = false;
                                                    assessmentAndPlanViewModel
                                                        .subGoalSelectedList
                                                        .removeWhere((element) =>
                                                            element['name'] ==
                                                            assessmentAndPlanViewModel
                                                                    .goalSubCategoryStringData
                                                                    .value[
                                                                index]['name']);
                                                  } else {
                                                    assessmentAndPlanViewModel
                                                            .goalSubCategoryStringData
                                                            .value[index]
                                                        ['status'] = true;
                                                    assessmentAndPlanViewModel
                                                        .subGoalSelectedList
                                                        .add({
                                                      'name': assessmentAndPlanViewModel
                                                          .goalSubCategoryStringData
                                                          .value[index]['name']
                                                    });
                                                  }
                                                })
                                          ],
                                        ),
                                        index ==
                                                assessmentAndPlanViewModel
                                                        .goalSubCategoryStringData
                                                        .value
                                                        .length -
                                                    1
                                            ? Padding(
                                                padding: EdgeInsets.all(20.w),
                                                child: CustomBtn(
                                                    onTap: () {
                                                      assessmentAndPlanViewModel
                                                          .subGoalExpanded
                                                          .value = false;
                                                    },
                                                    title: 'Done'),
                                              )
                                            : const SizedBox()
                                      ],
                                    );
                                  }))),
                      SizeConfig.sH20,

                      /// SELECT YOUR CURRENT LEVEL
                      InkWell(
                        onTap: () {
                          if (assessmentAndPlanViewModel
                              .currentLevelSelectedList.value.isEmpty) {
                            if (assessmentAndPlanViewModel
                                    .currentLevelExpanded.value ==
                                true) {
                              assessmentAndPlanViewModel
                                  .currentLevelExpanded.value = false;
                            } else {
                              assessmentAndPlanViewModel
                                  .currentLevelExpanded.value = true;
                            }
                          } else {
                            assessmentAndPlanViewModel
                                .currentLevelExpanded.value = true;
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: AppColors.grey, spreadRadius: 1)
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: assessmentAndPlanViewModel
                                            .currentLevelSelectedList
                                            .value
                                            .isEmpty
                                        ? CustomText(
                                            AppStrings.selectYourCurrentLevel,
                                            fontSize: 17.sp,
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                                assessmentAndPlanViewModel
                                                    .currentLevelSelectedList
                                                    .length,
                                                (index) => CustomText(
                                                    '${assessmentAndPlanViewModel.currentLevelSelectedList[index]['name']}${assessmentAndPlanViewModel.currentLevelSelectedList.length > 1 ? ',' : ''}')),
                                          )),
                              ),
                              const Icon(Icons.keyboard_arrow_down_sharp)
                            ],
                          ),
                        ),
                      ),
                      SizeConfig.sH10,
                      assessmentAndPlanViewModel.currentLevelExpanded.value ==
                              false
                          ? const SizedBox()
                          : Container(
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color:
                                          AppColors.black1c.withOpacity(0.1))),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      assessmentAndPlanViewModel
                                          .currentLevelListData
                                          .value
                                          .length, (index) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  if (assessmentAndPlanViewModel
                                                          .currentLevelListData
                                                          .value[index]
                                                          .status ==
                                                      true) {
                                                    assessmentAndPlanViewModel
                                                        .currentLevelListData
                                                        .value[index]
                                                        .status = false;
                                                    assessmentAndPlanViewModel
                                                        .currentLevelSelectedList
                                                        .removeWhere((element) =>
                                                            element['id'] ==
                                                            assessmentAndPlanViewModel
                                                                .currentLevelListData
                                                                .value[index]
                                                                .id);
                                                  } else {
                                                    assessmentAndPlanViewModel
                                                        .currentLevelListData
                                                        .value[index]
                                                        .status = true;
                                                    assessmentAndPlanViewModel
                                                        .currentLevelSelectedList
                                                        .add({
                                                      'id': assessmentAndPlanViewModel
                                                          .currentLevelListData
                                                          .value[index]
                                                          .id,
                                                      'name':
                                                          assessmentAndPlanViewModel
                                                              .currentLevelListData
                                                              .value[index]
                                                              .name
                                                    });
                                                  }
                                                  // assessmentAndPlanViewModel.goalListData
                                                  //             .value[index].status ==
                                                  //         true
                                                  //     ? assessmentAndPlanViewModel
                                                  //         .goalListData
                                                  //         .value[index]
                                                  //         .status = false
                                                  //     : assessmentAndPlanViewModel
                                                  //         .goalListData
                                                  //         .value[index]
                                                  //         .status = true;
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CustomText(
                                                      assessmentAndPlanViewModel
                                                          .currentLevelListData
                                                          .value[index]
                                                          .name!),
                                                ),
                                              ),
                                            ),
                                            Checkbox(
                                                value: assessmentAndPlanViewModel
                                                        .currentLevelListData
                                                        .value[index]
                                                        .status ??
                                                    false,
                                                onChanged: (val) {
                                                  if (assessmentAndPlanViewModel
                                                          .currentLevelListData
                                                          .value[index]
                                                          .status ==
                                                      true) {
                                                    assessmentAndPlanViewModel
                                                        .currentLevelListData
                                                        .value[index]
                                                        .status = false;
                                                    assessmentAndPlanViewModel
                                                        .currentLevelSelectedList
                                                        .removeWhere((element) =>
                                                            element['id'] ==
                                                            assessmentAndPlanViewModel
                                                                .currentLevelListData
                                                                .value[index]
                                                                .id);
                                                  } else {
                                                    assessmentAndPlanViewModel
                                                        .currentLevelListData
                                                        .value[index]
                                                        .status = true;
                                                    assessmentAndPlanViewModel
                                                        .currentLevelSelectedList
                                                        .add({
                                                      'id': assessmentAndPlanViewModel
                                                          .currentLevelListData
                                                          .value[index]
                                                          .id,
                                                      'name':
                                                          assessmentAndPlanViewModel
                                                              .currentLevelListData
                                                              .value[index]
                                                              .name
                                                    });
                                                  }
                                                })
                                          ],
                                        ),
                                        index ==
                                                assessmentAndPlanViewModel
                                                        .currentLevelListData
                                                        .value
                                                        .length -
                                                    1
                                            ? Padding(
                                                padding: EdgeInsets.all(20.w),
                                                child: CustomBtn(
                                                    onTap: () {
                                                      assessmentAndPlanViewModel
                                                          .currentLevelExpanded
                                                          .value = false;
                                                    },
                                                    title: 'Done'),
                                              )
                                            : const SizedBox()
                                      ],
                                    );
                                  }))),
                      SizeConfig.sH20,

                      /// SELECT YOUR STRATEGIES
                      InkWell(
                        onTap: () {
                          if (assessmentAndPlanViewModel
                              .strategiesSelectedList.value.isEmpty) {
                            if (assessmentAndPlanViewModel
                                    .strategiesExpanded.value ==
                                true) {
                              assessmentAndPlanViewModel
                                  .strategiesExpanded.value = false;
                            } else {
                              assessmentAndPlanViewModel
                                  .strategiesExpanded.value = true;
                            }
                          } else {
                            assessmentAndPlanViewModel
                                .strategiesExpanded.value = true;
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: AppColors.grey, spreadRadius: 1)
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: assessmentAndPlanViewModel
                                            .strategiesSelectedList
                                            .value
                                            .isEmpty
                                        ? CustomText(
                                            AppStrings.selectYourStrategies,
                                            fontSize: 17.sp,
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                                assessmentAndPlanViewModel
                                                    .strategiesSelectedList
                                                    .length,
                                                (index) => Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5),
                                                      child: CustomText(
                                                          '${assessmentAndPlanViewModel.strategiesSelectedList[index]['name']}${assessmentAndPlanViewModel.strategiesSelectedList.length > 1 ? ',' : ''}'),
                                                    )),
                                          )),
                              ),
                              const Icon(Icons.keyboard_arrow_down_sharp)
                            ],
                          ),
                        ),
                      ),
                      SizeConfig.sH10,
                      assessmentAndPlanViewModel.strategiesExpanded.value ==
                              false
                          ? const SizedBox()
                          : Container(
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color:
                                          AppColors.black1c.withOpacity(0.1))),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      assessmentAndPlanViewModel
                                          .strategiesStringData
                                          .value
                                          .length, (index) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  if (assessmentAndPlanViewModel
                                                              .strategiesStringData
                                                              .value[index]
                                                          ['status'] ==
                                                      true) {
                                                    assessmentAndPlanViewModel
                                                            .strategiesStringData
                                                            .value[index]
                                                        ['status'] = false;
                                                    assessmentAndPlanViewModel
                                                        .strategiesSelectedList
                                                        .removeWhere((element) =>
                                                            element['name'] ==
                                                            assessmentAndPlanViewModel
                                                                    .strategiesStringData
                                                                    .value[
                                                                index]['name']);
                                                  } else {
                                                    assessmentAndPlanViewModel
                                                            .strategiesStringData
                                                            .value[index]
                                                        ['status'] = true;
                                                    assessmentAndPlanViewModel
                                                        .strategiesSelectedList
                                                        .add({
                                                      'name': assessmentAndPlanViewModel
                                                          .strategiesStringData
                                                          .value[index]['name']
                                                    });
                                                  }
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CustomText(
                                                      assessmentAndPlanViewModel
                                                          .strategiesStringData
                                                          .value[index]['name']),
                                                ),
                                              ),
                                            ),
                                            Checkbox(
                                                value: assessmentAndPlanViewModel
                                                            .strategiesStringData
                                                            .value[index]
                                                        ['status'] ??
                                                    false,
                                                onChanged: (val) {
                                                  if (assessmentAndPlanViewModel
                                                              .strategiesStringData
                                                              .value[index]
                                                          ['status'] ==
                                                      true) {
                                                    assessmentAndPlanViewModel
                                                            .strategiesStringData
                                                            .value[index]
                                                        ['status'] = false;
                                                    assessmentAndPlanViewModel
                                                        .strategiesSelectedList
                                                        .removeWhere((element) =>
                                                            element['name'] ==
                                                            assessmentAndPlanViewModel
                                                                    .strategiesStringData
                                                                    .value[
                                                                index]['name']);
                                                  } else {
                                                    assessmentAndPlanViewModel
                                                            .strategiesStringData
                                                            .value[index]
                                                        ['status'] = true;
                                                    assessmentAndPlanViewModel
                                                        .strategiesSelectedList
                                                        .add({
                                                      'name': assessmentAndPlanViewModel
                                                          .strategiesStringData
                                                          .value[index]['name']
                                                    });
                                                  }
                                                })
                                          ],
                                        ),
                                        index ==
                                                assessmentAndPlanViewModel
                                                        .strategiesStringData
                                                        .value
                                                        .length -
                                                    1
                                            ? Padding(
                                                padding: EdgeInsets.all(20.w),
                                                child: CustomBtn(
                                                    onTap: () {
                                                      assessmentAndPlanViewModel
                                                          .strategiesExpanded
                                                          .value = false;
                                                    },
                                                    title: 'Done'),
                                              )
                                            : const SizedBox()
                                      ],
                                    );
                                  }))),
                    ],
                  ),
                ),
              ),
            ),

            // Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 30.w),
            //     child: CustomBtn(
            //       onTap: () {
            //         checkGps();
            //       },
            //       title: AppStrings.addTherapyCenter,
            //       textColor: AppColors.black1c,
            //       bgColor: AppColors.white,
            //     )),
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

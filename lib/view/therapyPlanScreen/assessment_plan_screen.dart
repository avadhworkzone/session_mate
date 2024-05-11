import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/common_appbar.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/viewModel/assessmentAndPlan_view_model.dart';

class AssessmentAndPlanScreen extends StatefulWidget {
  const AssessmentAndPlanScreen({super.key});

  @override
  State<AssessmentAndPlanScreen> createState() =>
      _AssessmentAndPlanScreenState();
}

class _AssessmentAndPlanScreenState extends State<AssessmentAndPlanScreen> {
  AssessmentAndPlanViewModel assessmentAndPlanViewModel =
      Get.put(AssessmentAndPlanViewModel());
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
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: Colors.grey),
                          color: AppColors.white),
                      child: DropdownButton<String>(
                        value: assessmentAndPlanViewModel.dropDownValue.value,
                        isExpanded: true,
                        underline: const SizedBox(),
                        iconEnabledColor: AppColors.color09,
                        iconDisabledColor: AppColors.color09,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        hint: CustomText(
                          AppStrings.childAgeGroup,
                          fontWeight: FontWeight.w300,
                          fontSize: 19.sp,
                          color: AppColors.black,
                        ),
                        onChanged: (newValue) {
                          assessmentAndPlanViewModel.dropDownValue.value =
                              newValue!;
                        },
                        items: childAgeGroup
                            .map((val) => DropdownMenuItem<String>(
                                  child: CustomText(val),
                                  value: val,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  SizeConfig.sW20,
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(color: Colors.grey),
                          color: AppColors.white),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              value: assessmentAndPlanViewModel
                                  .sessionDropDownValue.value,
                              isExpanded: true,
                              underline: SizedBox(),
                              iconEnabledColor: AppColors.color97,
                              iconDisabledColor: AppColors.color97,
                              icon: const LocalAssets(
                                  imagePath: AppImageAssets.dropDownArrowIcn),
                              hint: CustomText(
                                AppStrings.session,
                                fontWeight: FontWeight.w300,
                                fontSize: 17.sp,
                                color: AppColors.black,
                              ),
                              onChanged: (newValue) {
                                assessmentAndPlanViewModel
                                    .sessionDropDownValue.value = newValue!;
                              },
                              items: sessionData
                                  .map((e) => DropdownMenuItem<String>(
                                        child: Text(e),
                                        value: e,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizeConfig.sH40,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 1),
                      blurRadius: 4.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: ListView.builder(
                  itemCount: courseList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            childrenPadding:
                                EdgeInsets.symmetric(horizontal: 10.w),
                            title: CustomText(
                              courseList[index].title,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black1c,
                              fontSize: 20.sp,
                            ),
                            children: [
                              (index == 0)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                          data.length,
                                          (index) => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {},
                                                    child: CustomText(
                                                        '• ${data[index]['Goal Category']}'),
                                                  ),
                                                  if (index != data.length - 1)
                                                    Divider(
                                                      color: AppColors.colorA2
                                                          .withOpacity(0.2),
                                                    ),
                                                ],
                                              )),
                                    )
                                  : CustomText('anc'),
                            ],
                          ),
                        ),
                        if (index != courseList.length - 1)
                          Divider(
                            color: AppColors.colorA2.withOpacity(0.2),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List childAgeGroup = [
    AppStrings.zeroTo3YearTxt,
    AppStrings.threeTo7YearTxt,
    AppStrings.sevenTo14YearTxt,
    AppStrings.fortinPlus
  ];

  List sessionData = [
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

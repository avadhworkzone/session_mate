import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/common_appbar.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/size_config_utils.dart';

class UserTherapyPlanScreen extends StatefulWidget {
  final Map<String, dynamic> therapyPlan;

  const UserTherapyPlanScreen({super.key, required this.therapyPlan});

  @override
  State<UserTherapyPlanScreen> createState() => _UserTherapyPlanScreenState();
}

class _UserTherapyPlanScreenState extends State<UserTherapyPlanScreen> {
  @override
  void initState() {
    // TODO: implement initState
    print(widget.therapyPlan);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Column(
            children: [
              commonAppBar(
                  title: AppStrings.therepyPlan,
                  textColor: AppColors.white,
                  iconColor: AppColors.white),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizeConfig.sH20,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              AppStrings.category,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.w,
                            ),
                            SizeConfig.sH5,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  widget.therapyPlan['goal'].length,
                                  (index) => CustomText(
                                        widget.therapyPlan['goal'][index],
                                        color: AppColors.white,
                                      )),
                            ),
                            SizeConfig.sH20,
                            CustomText(
                              AppStrings.subCategory,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.w,
                            ),
                            SizeConfig.sH5,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  widget.therapyPlan['subGoal'].length,
                                      (index) => CustomText(
                                    widget.therapyPlan['subGoal'][index],
                                    color: AppColors.white,
                                  )),
                            ),
                            SizeConfig.sH20,
                            CustomText(
                              AppStrings.currentLeval,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.w,
                            ),
                            SizeConfig.sH5,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  widget.therapyPlan['currentLevel'].length,
                                      (index) => CustomText(
                                    widget.therapyPlan['currentLevel'][index],
                                    color: AppColors.white,
                                  )),
                            ),
                            SizeConfig.sH20,
                            CustomText(
                              AppStrings.strategies,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.w,
                            ),
                            SizeConfig.sH5,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  widget.therapyPlan['strategies'].length,
                                      (index) => CustomText(
                                    widget.therapyPlan['strategies'][index],
                                    color: AppColors.white,
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

      ),
    );
  }
}

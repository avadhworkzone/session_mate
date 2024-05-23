import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/view/therapyPlanScreen/user_therapy_plan_screen.dart';
import 'package:session_mate/viewModel/home_view_model.dart';

class ShowTherapyData extends StatefulWidget {
  const ShowTherapyData({super.key});

  @override
  State<ShowTherapyData> createState() => _ShowTherapyDataState();
}

class _ShowTherapyDataState extends State<ShowTherapyData> {
  HomeViewModel homeViewModel = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: homeViewModel.currentTherapyPlanData.length,
              itemBuilder: (context, index) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    onTap: () {
                      Get.to(() => UserTherapyPlanScreen(
                            therapyPlan:
                                homeViewModel.currentTherapyPlanData[index],
                          ));
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(homeViewModel.currentTherapyPlanData[index]
                            ['therapistName']),
                        CustomText(homeViewModel.currentTherapyPlanData[index]
                            ['userId']),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

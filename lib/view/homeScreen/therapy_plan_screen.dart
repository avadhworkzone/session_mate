import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_string.dart';

import '../../utils/common_methods.dart';

class TherapyPlan extends StatefulWidget {
  const TherapyPlan({super.key});

  @override
  State<TherapyPlan> createState() => _TherapyPlanState();
}

class _TherapyPlanState extends State<TherapyPlan> {
  TextEditingController childNameController = TextEditingController();
  TextEditingController ageNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Column(
          children: [
            commonAppBar(title:AppStrings.therepyPlan,color: AppColors.white),
            SingleChildScrollView(
              child: Column(
                children: [
                  commonAppTextField(
                      text: AppStrings.childName,
                      textEditingController:childNameController ),
                  SizedBox(height: 10.h,),
                  commonAppTextField(
                      text: AppStrings.childAge,
                      textEditingController:ageNameController ),
                  SizedBox(height: 10.h,),
                  Stack(
                    children: [
                      Container(
                        height: 499.78.h,
                        width: 367.w,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
              
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomBtn(onTap: (){},
                          height:55.h ,
                          width: 144.w,
                          bgColor: AppColors.white,
                          title: AppStrings.back,textColor: AppColors.colorA2,),
                      CustomBtn(onTap: (){},
                        height:55.h ,
                        width: 144.w,
                        bgColor: AppColors.white,
                        title: AppStrings.submit,textColor: AppColors.colorA2,)
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 56,
                      )
                    ],
                  )
                  
                ],
              ),
            ),
       

          ],
        ),

      ),
    );
  }

}

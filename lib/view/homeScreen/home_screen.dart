import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/size_config_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Stack(children: [
            const LocalAssets(imagePath: AppImageAssets.signInAppBarImage),
            Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LocalAssets(
                    imagePath: AppImageAssets.menuIcn,
                    imgColor: Colors.white,
                  ),
                  SizeConfig.sW40,
                  CustomText(
                    'Hi, Nitin',
                    color: AppColors.black1c,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w400,
                  )
                ],
              ),
            )
          ]),
          SizeConfig.sH45,
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.black.withOpacity(0.20),
                            blurRadius: 10,
                            spreadRadius: 1)
                      ]),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.w,
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            CustomText(
                              'Add new Session',
                              fontWeight: FontWeight.w600,
                              color: AppColors.black34,
                              fontSize: 16.sp,
                            ),
                            SizeConfig.sH8,
                            CustomText(
                              'Search for branch',
                              fontWeight: FontWeight.w500,
                              color: AppColors.black34,
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                        SizeConfig.sW60,
                        Image(
                          image: NetworkImage(
                              'https://media.istockphoto.com/id/689698190/vector/businessman-hands-holding-checklist-and-marker-vector-illustration.jpg?s=612x612&w=0&k=20&c=z_wTpbYEUKe3Tba-3FwU_RklGpHwS6oPYh8W_1jF90s='),
                          height: 131.h,
                          width: 93.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

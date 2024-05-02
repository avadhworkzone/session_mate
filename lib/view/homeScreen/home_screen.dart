import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/size_config_utils.dart';
import 'package:session_mate/view/homeScreen/retrieve_counts_screen.dart';
import 'package:session_mate/view/homeScreen/therapy_plan_screen.dart';

import '../../utils/app_string.dart';
import '../drawer_screen/manage_sessions.dart';
import '../drawer_screen/manage_therapy_centers.dart';
import 'add_new_session_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  List<String> imageList = [
    AppImageAssets.addNewSession,
    AppImageAssets.retriveCount,
    AppImageAssets.therapyPlan
  ];
  List<String> title = [
    AppStrings.addsession,
    AppStrings.retrieveCounts,
    AppStrings.therepyPlan
  ];
  List<String> subtitle = [
    AppStrings.searchforbranch,
    AppStrings.searchForinterestRate,
    AppStrings.searchForExchangeRate
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: buildDrawer(),
      body: Column(
        children: [
          Stack(children: [
            const LocalAssets(imagePath: AppImageAssets.signInAppBarImage),
            Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _key.currentState?.openDrawer();
                    },
                    child: const LocalAssets(
                      imagePath: AppImageAssets.menuIcn,
                      imgColor: AppColors.primaryColor,
                    ),
                  ),
                  SizeConfig.sW40,
                  CustomText(
                    '${AppStrings.hi} Nitin',
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
                child: GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      Get.to(() => const AddNewSession());
                    } else if (index == 1) {
                      Get.to(() => const RetrieveCounts());
                    } else {
                      Get.to(() => const TherapyPlan());
                    }
                  },
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
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              CustomText(
                                title[index],
                                fontWeight: FontWeight.w600,
                                color: AppColors.black34,
                                fontSize: 16.sp,
                              ),
                              SizeConfig.sH8,
                              CustomText(
                                subtitle[index],
                                fontWeight: FontWeight.w500,
                                color: AppColors.black34,
                                fontSize: 12.sp,
                              ),
                            ],
                          ),
                          SizeConfig.sW60,
                          LocalAssets(
                            imagePath: imageList[index],
                            height: 131.h,
                            width: 93.w,
                          ),
                        ],
                      ),
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

  Drawer buildDrawer() {
    return Drawer(
      width: Get.width / 1.3,
      backgroundColor: AppColors.primaryColor.withOpacity(0.8),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: Get.width / 1.3,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 28.w, vertical: 25.h),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30.w,
                            backgroundImage:
                                const AssetImage(AppImageAssets.profile),
                          ),
                          SizedBox(height: 12.h),
                          CustomText(
                            "Nitin",
                            color: AppColors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 7.h),
                          CustomText(
                            "User 0987654321",
                            color: AppColors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 13.w, right: 29.w),
                        child: Column(
                          children: [
                            commonDrawerBtn(
                              image: AppImageAssets.person,
                              title: AppStrings.manageSessions,
                              ontap: () {
                                Get.to(() => const ManageSessions());
                              },
                            ),
                            const Divider(
                              color: AppColors.white,
                            ),
                            commonDrawerBtn(
                                image: AppImageAssets.person,
                                title: AppStrings.therapyCentres,
                                ontap: () {
                                  Get.to(() => const ManageTherapyCenters());
                                }),
                            const Divider(
                              color: AppColors.white,
                            ),
                            commonDrawerBtn(
                                image: AppImageAssets.setting,
                                title: AppStrings.settings,
                                ontap: () {}),
                            const Divider(
                              color: AppColors.white,
                            ),
                            commonDrawerBtn(
                                image: AppImageAssets.person,
                                title: AppStrings.myPlan,
                                ontap: () {}),
                            const Divider(
                              color: AppColors.white,
                            ),
                            commonDrawerBtn(
                                image: AppImageAssets.delete,
                                title: AppStrings.delete,
                                ontap: () {}),
                            const Divider(
                              color: AppColors.white,
                            ),
                            commonDrawerBtn(
                                image: AppImageAssets.exit,
                                title: AppStrings.logOut,
                                ontap: () {}),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell commonDrawerBtn({
    required String image,
    required String title,
    required Function ontap,
  }) {
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
      focusColor: Colors.cyan,
      onTap: () {
        ontap();
      },
      child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: LocalAssets(
            imagePath: image,
            width: 30.w,
            height: 30.w,
          ),
          title: CustomText(
            title,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
            color: AppColors.white,
          ),
          trailing: LocalAssets(
            imagePath: AppImageAssets.arrow,
            width: 30.w,
            height: 30.w,
          )),
    );
  }
}

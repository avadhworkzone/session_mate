import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/size_config_utils.dart';

import '../../utils/app_string.dart';
import '../drawer_screen/manage_sessions.dart';
import '../drawer_screen/manage_therapy_centers.dart';

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
                   onTap: (){
                     _key.currentState?.openDrawer();
                   },

                      child: Image(
                        height: 30.w,width: 30.w,
                          image: AssetImage(AppImageAssets.menuDrawer))),
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
                          image:  AssetImage(
                              imageList[index]),
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

  Drawer buildDrawer() {
    return Drawer(
      backgroundColor: AppColors.primaryColor,
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                 SizedBox(
                  height: 250.w,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(AppImageAssets.profile),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: CustomText(
                              "Nitin",
                              color: AppColors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            )),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: CustomText(
                              "User 0987654321",
                              color:  AppColors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            )),

                      ],

                    ),
                  ),
                ),
                Column(
                  children: [
                    commonDrawerBtn(
                      image:  AppImageAssets.person,
                      title: AppStrings.manageSessions,

                      ontap: () {Get.to(()=> ManageSessions());},

                    ),
                    Container(
                      height: 1.w,
                      width: 250.w,
                      color: Colors.white,

                    ),
                    commonDrawerBtn(
                        image:  AppImageAssets.person,
                        title: AppStrings.therapyCentres,
                        ontap: () {Get.to(()=>ManageTherapyCenters());}),
                    Container(
                      height: 1.w,
                      width: 250.w,
                      color:Colors.white,
                    ),
                    commonDrawerBtn(
                        image:  AppImageAssets.setting,
                        title: AppStrings.settings,
                        ontap: () {}),
                    Container(
                      height: 1.w,
                      width: 250.w,
                      color: Colors.white,

                    ),
                    commonDrawerBtn(
                        image:  AppImageAssets.person,
                        title: AppStrings.myPlan,
                        ontap: () {}),
                    Container(
                      height: 1.w,
                      width: 250.w,
                      color: Colors.white,

                    ),
                    commonDrawerBtn(
                        image:  AppImageAssets.delete,
                        title: AppStrings.delete,
                        ontap: () {}),
                    Container(
                      height: 1.w,
                      width: 250.w,
                      color: Colors.white,

                    ),
                    commonDrawerBtn(
                        image:  AppImageAssets.exit,
                        title: AppStrings.logOut,
                        ontap: () {}),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
  InkWell commonDrawerBtn(
      {required String image,
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
        leading: Image(
          width: 30,height: 30,
          image: AssetImage(image),

        ),
        title: CustomText(
          title,
          fontWeight: FontWeight.bold, fontSize: 17,color: AppColors.white,
        ),
        trailing: const Image(
          width: 30,height: 30,
          image: AssetImage( AppImageAssets.arrow,),
        ),
      ),

    );

  }
}

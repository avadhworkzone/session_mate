import 'package:flutter/material.dart';

import '../../commonWidget/custom_text.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_image_assets.dart';
import '../../utils/app_string.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("hii"),
        // leading: IconButton(onPressed: (){}, icon: const Icon(Icons.align_vertical_bottom)),
      ),
      drawer: Drawer(
        backgroundColor: AppColors.primaryColor,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: DrawerHeader(
                      decoration: const BoxDecoration(
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
                                AppStrings.nitin,
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: CustomText(
                                AppStrings.user,
                                color:  AppColors.white,
                                fontSize: 20,
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

                        ontap: () {},

                      ),
                      Container(
                        height: 1,
                        width: 250,
                        color: Colors.white,

                      ),
                      commonDrawerBtn(
                          image:  AppImageAssets.person,
                          title: AppStrings.therapyCentres,
                          ontap: () {}),
                      Container(
                        height: 1,
                        width: 250,
                        color:Colors.white,
                      ),
                      commonDrawerBtn(
                          image:  AppImageAssets.setting,
                          title: AppStrings.settings,
                          ontap: () {}),
                      Container(
                        height: 1,
                        width: 250,
                        color: Colors.white,

                      ),
                      commonDrawerBtn(
                          image:  AppImageAssets.person,
                          title: AppStrings.myPlan,
                          ontap: () {}),
                      Container(
                        height: 1,
                        width: 250,
                        color: Colors.white,

                      ),
                      commonDrawerBtn(
                          image:  AppImageAssets.delete,
                          title: AppStrings.delete,
                          ontap: () {}),
                      Container(
                        height: 1,
                        width: 250,
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

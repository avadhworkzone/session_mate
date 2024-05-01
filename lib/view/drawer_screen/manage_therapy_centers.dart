import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/common_methods.dart';

import '../../utils/local_assets.dart';

class ManageTherapyCenters extends StatefulWidget {
  const ManageTherapyCenters({super.key});

  @override
  State<ManageTherapyCenters> createState() => _ManageTherapyCentersState();
}

class _ManageTherapyCentersState extends State<ManageTherapyCenters> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(

        body: Column(

          children: [
            commonAppBar(localAssets: LocalAssets(
              imagePath: AppImageAssets.backArrow,height: 23.h,width: 23.w,),
                title:AppStrings.therapyCentres),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(60),
                  child: CustomText(AppStrings.noTherapy,color: AppColors.black34,fontSize: 25,textAlign: TextAlign.center,),
                ),
                Center(
                  child: CustomBtn(
                    width: 353.w,
                      onTap: (){}, title: AppStrings.add),
                ),
              ],
            )
          ],
        ),

      ),
    );
  }
}

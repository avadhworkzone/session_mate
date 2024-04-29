import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:session_mate/commonWidget/custom_btn.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';

class ManageTherapyCenters extends StatefulWidget {
  const ManageTherapyCenters({super.key});

  @override
  State<ManageTherapyCenters> createState() => _ManageTherapyCentersState();
}

class _ManageTherapyCentersState extends State<ManageTherapyCenters> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: Image(
         height: 10.w,width: 10.w,
          image: AssetImage(AppImageAssets.backArrow),),
        title: CustomText(AppStrings.therapyCentres,fontSize: 23,fontWeight: FontWeight.w600,),
        
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(60),
            child: CustomText(AppStrings.noTherapy,color: AppColors.black34,fontSize: 25,textAlign: TextAlign.center,),
          ),
          Center(
            child: CustomBtn(
              width: 353.w,
                onTap: (){}, title: AppStrings.add),
          )
        ],
      ),

    );
  }
}

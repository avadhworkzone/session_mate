import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/local_assets.dart';

import '../../commonWidget/custom_text.dart';
import '../../utils/app_image_assets.dart';
import '../../utils/app_string.dart';
import '../../utils/common_methods.dart';

class ManageSessions extends StatefulWidget {
  const ManageSessions({super.key});

  @override
  State<ManageSessions> createState() => _ManageSessionsState();
}

class _ManageSessionsState extends State<ManageSessions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            commonAppBar(title:AppStrings.manageSessions),
        
        
            Expanded(child:
            ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Card(
                  color: AppColors.white,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  elevation: 2,
                  child: ListTile(
                    title: CustomText('Speech',fontWeight: FontWeight.w600,fontSize: 18,),
                    subtitle: CustomText('08/04/24'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LocalAssets(
                          imagePath: AppImageAssets.edit,
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        LocalAssets(
                          imagePath: AppImageAssets.deleteIcon,
                        ),
                      ],
                    ),
                  ),
                );
              },


            ),
            )
        
        
          ],
        ),
      ),
    );
  }
}

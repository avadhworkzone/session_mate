import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../commonWidget/custom_text.dart';
import '../../utils/app_image_assets.dart';
import '../../utils/app_string.dart';

class ManageSessions extends StatefulWidget {
  const ManageSessions({super.key});

  @override
  State<ManageSessions> createState() => _ManageSessionsState();
}

class _ManageSessionsState extends State<ManageSessions> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Image(
          height: 10.w,width: 10.w,
          image: const AssetImage(AppImageAssets.backArrow,),),
        title: CustomText(AppStrings.manageSessions,fontSize: 23,fontWeight: FontWeight.w600,),

      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}

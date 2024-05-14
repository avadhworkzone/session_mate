import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/commonWidget/network_assets.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/local_assets.dart';

class CommonSessionContainer extends StatelessWidget {
  final String titleText;
  final String imageUrl;
  final Color color;
  const CommonSessionContainer(
      {super.key,
      required this.titleText,
      required this.imageUrl,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 112.h,
        width: 133.w,
        decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(15.r),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.black1c.withOpacity(0.20),
                blurRadius: 20,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // NetWorkOcToAssets(imgUrl: imageUrl),
            LocalAssets(imagePath: imageUrl),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomText(
                titleText,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

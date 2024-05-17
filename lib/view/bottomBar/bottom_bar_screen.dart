import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_image_assets.dart';
import 'package:session_mate/utils/app_string.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/viewModel/bottom_bar_view_model.dart';
import 'package:session_mate/viewModel/session_view_model.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  BottomBarViewModel bottomBarViewModel = Get.put(BottomBarViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBody: false,
        body: bottomBarViewModel.screenList[bottomBarViewModel.selectedBottomIndex.value],
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 12.w),
          width: Get.width,
          decoration: const BoxDecoration(color: AppColors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              navItem(
                  index: 0,
                  icon: AppImageAssets.homeImg,
                  selectedIcon: AppImageAssets.homeSelectedImg,
                  title: AppStrings.home),
              navItem(
                  index: 1,
                  icon: AppImageAssets.sessionImg,
                  selectedIcon: AppImageAssets.sessionSelectedImg,
                  title: AppStrings.session),
              navItem(
                  index: 2,
                  icon: AppImageAssets.profileImg,
                  selectedIcon: AppImageAssets.profileSelectedImg,
                  title: AppStrings.profile),
              navItem(
                  index: 3,
                  icon: AppImageAssets.settingImg,
                  selectedIcon: AppImageAssets.settingSelectedImg,
                  title: AppStrings.settings),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem({
    required int index,
    required String icon,
    required String title,
    required String selectedIcon,
  }) {
    return InkWell(
      onTap: () async {
        bottomBarViewModel.selectedBottomIndex.value = index;
        if (bottomBarViewModel.selectedBottomIndex.value != 1) {
          if (SharedPreferenceUtils.getSessionId() != '') {
            await SharedPreferenceUtils.setSessionId('');
          }
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LocalAssets(
            imagePath: bottomBarViewModel.selectedBottomIndex.value == index ? selectedIcon : icon,
            height: 25.h,
            width: 25.w,
            // imgColor: bottomBarViewModel.selectedBottomIndex.value == index
            //     ? AppColors.primaryColor
            //     : AppColors.colorA2,
          ),
          CustomText(
            title,
            color: bottomBarViewModel.selectedBottomIndex.value == index
                ? AppColors.primaryColor
                : AppColors.colorA2,
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
          ),
        ],
      ),
    );
  }
}

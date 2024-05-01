import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/local_assets.dart';
import 'package:session_mate/utils/size_config_utils.dart';

import '../../commonWidget/custom_btn.dart';
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
            commonAppBar(
                localAssets: LocalAssets(
                  imagePath: AppImageAssets.backArrow,
                  height: 23.h,
                  width: 23.w,
                ),
                title: AppStrings.manageSessions),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Card(
                    color: AppColors.white,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    elevation: 2,
                    child: ListTile(
                      title: CustomText(
                        'Speech',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      subtitle: CustomText('08/04/24'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LocalAssets(
                            imagePath: AppImageAssets.deleteIcon,
                          ),
                          SizeConfig.sW30,
                          LocalAssets(
                            imagePath: AppImageAssets.edit,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Center(
                child: CustomBtn(
                    width: 353.w,
                    onTap: (){}, title: AppStrings.addsession),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

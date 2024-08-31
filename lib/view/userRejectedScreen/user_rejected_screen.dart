import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:session_mate/commonWidget/custom_text.dart';
import 'package:session_mate/commonWidget/no_data_found_widget.dart';
import 'package:session_mate/service/auth_service.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';

class UserRejectedScreen extends StatefulWidget {
  const UserRejectedScreen({super.key});

  @override
  State<UserRejectedScreen> createState() => _UserRejectedScreenState();
}

class _UserRejectedScreenState extends State<UserRejectedScreen> {
  @override
  void initState() {
    SharedPreferenceUtils.setIsUserRejectedLogin(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Center(
          child: StreamBuilder(
            stream: AuthService.getAdminCommentData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.blue,
                    ));
              }
              if (snapshot.hasError) {
                return noDataFound();
              }

              print("Data Length :- ${snapshot.data?.docs.length}");

              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return noDataFound();
              }

              var userDoc = snapshot.data!.docs[0];

              return Center(
                child: CustomText(
                  "${userDoc.data().containsKey('adminCommentOfUnVerifyUser') ? userDoc['adminCommentOfUnVerifyUser'] : ''}",
                  color: AppColors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

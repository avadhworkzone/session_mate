import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_theme.dart';
import 'package:session_mate/view/welcome_screen/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarColor: AppColors.white),
      child: ScreenUtilInit(
        designSize: AppTheme.designSize,
        child: GetMaterialApp(
          enableLog: true,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.white,
            pageTransitionsTheme: const PageTransitionsTheme(),
            useMaterial3: true,
          ),
          home: const WelcomeScreen(),
        ),
      ),
    );
  }
}

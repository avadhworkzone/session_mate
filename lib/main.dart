import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:session_mate/general/connectivity_wrapper.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_theme.dart';
import 'package:session_mate/view/welcomeScreen/welcome_screen.dart';
import 'package:session_mate/viewModel/otp_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
//demo
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
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: GetMaterialApp(
            enableLog: true,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.white,
              pageTransitionsTheme: const PageTransitionsTheme(),
              useMaterial3: true,
            ),
            transitionDuration: const Duration(milliseconds: 100),
            // builder: (context, widget) => ColoredBox(
            //   color: AppColors.white,
            //   child: NotificationListener<OverscrollIndicatorNotification>(
            //     onNotification: (OverscrollIndicatorNotification overscroll) {
            //       overscroll.disallowIndicator();
            //       return true;
            //     },
            // child: MediaQuery(
            //   data: MediaQuery.of(context)
            //       .copyWith(textScaler: const TextScaler.linear(1.0)),
            //   child: const SizedBox(),
            // ),
            //   ),
            // ),
            home: const ConnectivityWrapper(child: WelcomeScreen()),
          ),
        ),
      ),
    );
  }

  OtpViewModel otpViewModel = Get.put(OtpViewModel());
}

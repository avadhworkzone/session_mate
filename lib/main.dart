<<<<<<< Updated upstream
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:session_mate/general/connectivity_wrapper.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_theme.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/view/bottomBar/bottom_bar_screen.dart';
import 'package:session_mate/view/welcomeScreen/welcome_screen.dart';
import 'package:session_mate/viewModel/otp_view_model.dart';
import 'package:session_mate/viewModel/sign_in_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCCPvygb8Emu4AV-9Z0bl8SQq2apISQ2hk",
          appId: "1:824473918339:android:9e77aaa912a92eb4fd34b6",
          messagingSenderId: "824473918339",
          projectId: "session-mate-v2",
          storageBucket: "session-mate-v2.appspot.com"));
  runApp(MyApp());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

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
            ),
            transitionDuration: const Duration(milliseconds: 100),
            home: ConnectivityWrapper(
              child: SharedPreferenceUtils.getIsLogin() == true
                  ? const BottomBar()
                  : const WelcomeScreen(),
            ),
          ),
        ),
      ),
    );
  }

  OtpViewModel otpViewModel = Get.put(OtpViewModel());
  SignInViewModel signInViewModel = Get.put(SignInViewModel());
}
=======
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:session_mate/general/connectivity_wrapper.dart';
import 'package:session_mate/utils/app_colors.dart';
import 'package:session_mate/utils/app_theme.dart';
import 'package:session_mate/utils/shared_preference_utils.dart';
import 'package:session_mate/view/bottomBar/bottom_bar_screen.dart';
import 'package:session_mate/view/userRejectedScreen/user_rejected_screen.dart';
import 'package:session_mate/view/userVerificationStatus/user_verification_status_screen.dart';
import 'package:session_mate/view/welcomeScreen/welcome_screen.dart';
import 'package:session_mate/viewModel/otp_view_model.dart';
import 'package:session_mate/viewModel/sign_in_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCCPvygb8Emu4AV-9Z0bl8SQq2apISQ2hk",
          appId: "1:824473918339:android:9e77aaa912a92eb4fd34b6",
          messagingSenderId: "824473918339",
          projectId: "session-mate-v2",
          storageBucket: "session-mate-v2.appspot.com"));
  runApp(MyApp());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print(
        "SharedPreferenceUtils.getIsLogin() :- ${SharedPreferenceUtils.getIsLogin()}");
    print(
        "SharedPreferenceUtils.getIsAdminLogin() :- ${SharedPreferenceUtils.getIsAdminLogin()}");
    print("SharedPreferenceUtils.getIsUserRejectedLogin() :- ${SharedPreferenceUtils.getIsUserRejectedLogin()}");
    print("SharedPreferenceUtils.getIsHomeLogin() :- ${SharedPreferenceUtils.getIsHomeLogin()}");
    print("SharedPreferenceUtils.getUserId() :- ${SharedPreferenceUtils.getUserId()}");

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
            ),
            transitionDuration: const Duration(milliseconds: 100),

            home: ConnectivityWrapper(
              child: (SharedPreferenceUtils.getIsHomeLogin() == true && SharedPreferenceUtils.getUserId() != "")
                  ? const BottomBar()

                      : SharedPreferenceUtils.getIsAdminLogin() == true
                          ? const UserVerificationStatusScreen()
                          : SharedPreferenceUtils.getIsUserRejectedLogin() == true
                              ? const UserRejectedScreen()
                              : const WelcomeScreen(),
            ),

            // home:    const WelcomeScreen()
          ),
        ),
      ),
    );
  }

  OtpViewModel otpViewModel = Get.put(OtpViewModel());
  SignInViewModel signInViewModel = Get.put(SignInViewModel());

}
>>>>>>> Stashed changes
